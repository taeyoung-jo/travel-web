package com.travelers.travelweb.domain.user.service;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.domain.user.repository.UserRepository;
import com.travelers.travelweb.global.exception.CustomException;
import com.travelers.travelweb.global.util.PhoneUtil;
import com.travelers.travelweb.global.util.auth.PasswordUtil;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class UserService {

	private final UserRepository repository;

	/**
	 * 회원가입
	 */
	public void register(User user) {
		validateUser(user, true); // 사용자의 입력값 체크

		if (repository.findByEmail(user.getEmail()).isPresent()) {
			throw new CustomException(
				"이미 사용 중인 이메일입니다.",
				"[Service Error] 이메일 중복: " + user.getEmail(),
				400
			);
		}

		String hashedPassword = PasswordUtil.hash(user.getPassword());  // 비밀번호 해시 처리
		user.setPassword(hashedPassword);

		if (user.getPhone() != null && !user.getPhone().trim().isEmpty()) {
			user.setPhone(PhoneUtil.inputPhoneNumber(user.getPhone()));  // 폰번호 포맷 처리
		}

		repository.save(user);
	}

	/**
	 * 회원정보 수정
	 */
	public void update(User user) {
		validateUser(user, false); // 사용자의 입력값 체크

		// 회원 존재 여부 확인
		Optional<User> existingUserOpt = repository.findById(user.getId());
		if (!existingUserOpt.isPresent()) {
			throw new CustomException(
				"해당 회원을 찾을 수 없습니다.",
				"[Service Error] 회원 정보 수정 실패: id=" + user.getId(),
				404
			);
		}

		// 비밀번호 입력했으면, 해시 처리
		if (user.getPassword() != null && !user.getPassword().isEmpty()) {
			String hashedPassword = PasswordUtil.hash(user.getPassword());
			user.setPassword(hashedPassword);
		}

		// 전화번호 입력했으면, 폰번호 포맷으로 변환
		if (user.getPhone() != null && !user.getPhone().isEmpty()) {
			user.setPhone(PhoneUtil.inputPhoneNumber(user.getPhone()));
		}

		repository.update(user);
	}

	/**
	 * 회원 삭제
	 */
	public void removeById(Long id) {
		repository.deleteById(id);
	}

	/**
	 * 로그인
	 */
	public Optional<User> login(String email, String password) {
		// 사용자의 입력값 검증 : null 또는 빈 문자열 체크
		if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			throw new CustomException(
				"이메일과 비밀번호를 모두 입력해주세요.",
				"[Service Error] 로그인 요청값 부족",
				400
			);
		}

		// 이메일 형식 검증
		String emailPattern = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";
		if (!email.matches(emailPattern)) {
			throw new CustomException(
				"이메일 형식이 올바르지 않습니다.",
				"[Service Error] 이메일 형식 오류",
				400
			);
		}

		Optional<User> userOpt = repository.findByEmail(email.trim());

		if (userOpt.isPresent()) {
			User user = userOpt.get();

			// 비밀번호 검증 (DB 해시 vs 입력 평문)
			if (PasswordUtil.check(password, user.getPassword())) {
				return Optional.of(user);
			}
		}

		throw new CustomException(
			"입력하신 로그인 정보가 일치하지 않습니다.",
			"[Service Error] 로그인 실패: " + email,
			401
		);
	}

	/**
	 * 아이디 찾기 (name/phone)
	 */
	public Optional<User> getByNameAndPhone(String name, String phone) {
		if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
			throw new CustomException(
				"이름과 전화번호를 모두 입력해주세요.",
				"[Service Error] getByNameAndPhone 요청값 부족",
				400
			);
		}

		String formattedPhone = PhoneUtil.inputPhoneNumber(phone);
		Optional<User> userOpt = repository.findByNameAndPhone(name, formattedPhone);

		if (userOpt.isEmpty()) {
			throw new CustomException(
				"해당하는 사용자를 찾을 수 없습니다.",
				"[Service Info] getByNameAndPhone 조회 결과 없음: " + name,
				404
			);
		}

		return userOpt;
	}

	/**
	 * 비밀번호 찾기 (새 비밀번호 입력)
	 */
	public Optional<User> getByEmailAndPhone(String email, String phone) {
		if (email == null || email.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
			throw new CustomException(
				"이메일과 전화번호를 모두 입력해주세요.",
				"[Service Error] getByEmailAndPhone 요청값 부족",
				400
			);
		}

		String emailPattern = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";
		if (!email.matches(emailPattern)) {
			throw new CustomException(
				"이메일 형식이 올바르지 않습니다.",
				"[Service Error] 이메일 형식 오류",
				400
			);
		}

		String formattedPhone = PhoneUtil.inputPhoneNumber(phone);
		Optional<User> userOpt = repository.findByEmailAndPhone(email, formattedPhone);

		if (userOpt.isEmpty()) {
			throw new CustomException(
				"해당하는 사용자를 찾을 수 없습니다.",
				"[Service Info] getByEmailAndPhone 조회 결과 없음: " + email,
				404
			);
		}

		return userOpt;
	}

	public void updatePassword(Long id, String newPassword) {
		if (newPassword == null || newPassword.trim().length() < 8) {
			throw new CustomException(
				"새 비밀번호는 8자 이상이어야 합니다.",
				"[Service Error] 새 비밀번호 길이 부족",
				400
			);
		}

		String hashedPassword = PasswordUtil.hash(newPassword);
		repository.updatePasswordById(id, hashedPassword);
	}

	/**
	 * 조회
	 */
	public Optional<User> getById(Long id) {
		Optional<User> userOpt = repository.findById(id);
		if (userOpt.isEmpty()) {
			throw new CustomException(
				"해당 사용자를 찾을 수 없습니다.",
				"[Service Info] getById 조회 결과 없음: id=" + id,
				404
			);
		}
		return userOpt;
	}

	public Optional<User> getByEmail(String email) {
		Optional<User> userOpt = repository.findByEmail(email);
		if (userOpt.isEmpty()) {
			throw new CustomException(
				"해당 사용자를 찾을 수 없습니다.",
				"[Service Info] getByEmail 조회 결과 없음: " + email,
				404
			);
		}
		return userOpt;
	}

	public List<User> getAll() {
		return repository.findAll();
	}

	/**
	 * === 입력값을 체크하는 헬퍼 메서드 ===
	 * [회원가입]에서는 isNew = true,
	 * [회원정보 수정]에서는 isNew = false 로 사용.
	 */
	private void validateUser(User user, boolean isNew) {
		if (isNew) {
			// 회원가입 시 입력값(email, password) 체크
			if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
				throw new CustomException(
					"이메일은 필수 입력입니다.",
					"[Service Error] 이메일 누락",
					400
				);
			}
			if (!user.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
				throw new CustomException(
					"이메일 형식이 올바르지 않습니다.",
					"[Service Error] 이메일 형식 오류",
					400
				);
			}

			if (user.getPassword() == null || user.getPassword().trim().length() < 8) {
				throw new CustomException(
					"비밀번호는 8자 이상이어야 합니다.",
					"[Service Error] 비밀번호 길이 부족",
					400
				);
			}
		} else {
			// 회원정보 수정 시 입력된 값만(email, password) 체크
			if (user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
				if (!user.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
					throw new CustomException(
						"이메일 형식이 올바르지 않습니다.",
						"[Service Error] 이메일 형식 오류(수정)",
						400
					);
				}
			}

			if (user.getPassword() != null && !user.getPassword().isEmpty()) {
				if (user.getPassword().length() < 8) {
					throw new CustomException(
						"비밀번호는 8자 이상이어야 합니다.",
						"[Service Error] 비밀번호 길이 부족(수정)",
						400
					);
				}
			}
		}

		// 입력값 name 체크
		if (user.getName() != null && !user.getName().isEmpty()) {
			if (user.getName().length() > 10) {
				throw new CustomException(
					"이름은 10자 이하로 입력해야 합니다.",
					"[Service Error] 이름 길이 초과",
					400
				);
			}
		}

		// 입력값 phone 체크
		if (user.getPhone() != null && !user.getPhone().trim().isEmpty()) {
			String phoneDigits = user.getPhone().replaceAll("\\D", "");
			if (!phoneDigits.matches("^\\d{11}$")) {
				throw new CustomException(
					"전화번호는 11자리 숫자로 입력해야 합니다.",
					"[Service Error] 전화번호 형식 오류",
					400
				);
			}
		}
	}
}