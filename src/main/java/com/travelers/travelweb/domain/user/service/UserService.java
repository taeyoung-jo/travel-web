package com.travelers.travelweb.domain.user.service;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.domain.user.repository.UserRepository;
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

		// 이메일 중복 체크
		if (repository.findByEmail(user.getEmail()).isPresent()) {
			throw new RuntimeException("[UserService] 회원가입 실패 : 이미 존재하는 이메일입니다.");
		}

		// 비밀번호 해시 처리
		String hashedPassword = PasswordUtil.hash(user.getPassword());
		user.setPassword(hashedPassword);

		// 폰번호 포맷 처리
		if (user.getPhone() != null && !user.getPhone().trim().isEmpty()) {
			user.setPhone(PhoneUtil.inputPhoneNumber(user.getPhone()));
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
			throw new RuntimeException("[UserService] 회원정보수정 실패 : 해당 회원을 찾을 수 없습니다.");
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

		// DB 업데이트 실행
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
			return Optional.empty();
		}

		// 이메일 형식 검증
		String emailPattern = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";
		if (!email.matches(emailPattern)) {
			return Optional.empty();
		}

		Optional<User> userOpt = repository.findByEmail(email.trim());

		if (userOpt.isPresent()) {
			User user = userOpt.get();

			// 비밀번호 검증 (DB 해시 vs 입력 평문)
			if (PasswordUtil.check(password, user.getPassword())) {
				return Optional.of(user);
			}
		}
		return Optional.empty();
	}

	/**
	 * 아이디 찾기 (name/phone)
	 */
	public Optional<User> getByNameAndPhone(String name, String phone) {
		if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
			return Optional.empty();
		}

		if (name.length() > 10) {
			return Optional.empty();
		}

		String formattedPhone = PhoneUtil.inputPhoneNumber(phone);
		return repository.findByNameAndPhone(name, formattedPhone);
	}

	/**
	 * 비밀번호 찾기 (새 비밀번호 입력)
	 */
	public Optional<User> getByEmailAndPhone(String email, String phone) {
		if (email == null || email.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
			return Optional.empty();
		}

		String emailPattern = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";
		if (!email.matches(emailPattern)) {
			return Optional.empty();
		}

		String formattedPhone = PhoneUtil.inputPhoneNumber(phone);
		return repository.findByEmailAndPhone(email, formattedPhone);
	}

	public void updatePassword(Long id, String newPassword) {
		if (newPassword == null || newPassword.trim().isEmpty()) {
			throw new RuntimeException("[UserService] 새 비밀번호는 8자 이상이어야 합니다.");
		}

		if (newPassword.length() < 8) {
			throw new RuntimeException("[UserService] 새 비밀번호는 8자 이상이어야 합니다.");
		}

		String hashedPassword = PasswordUtil.hash(newPassword);
		repository.updatePasswordById(id, hashedPassword);
	}

	/**
	 * 조회
	 */
	public Optional<User> getById(Long id) {
		return repository.findById(id);
	}

	public Optional<User> getByEmail(String email) {
		return repository.findByEmail(email);
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
				throw new RuntimeException("[UserService] 이메일은 필수 입력입니다.");
			}
			if (!user.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
				throw new RuntimeException("[UserService] 이메일 형식이 올바르지 않습니다.");
			}

			if (user.getPassword() == null || user.getPassword().length() < 8) {
				throw new RuntimeException("[UserService] 비밀번호는 8자 이상이어야 합니다.");
			}
		} else {
			// 회원정보 수정 시 입력된 값만(email, password) 체크
			if (user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
				if (!user.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
					throw new RuntimeException("[UserService] 이메일 형식이 올바르지 않습니다.");
				}
			}

			if (user.getPassword() != null && !user.getPassword().isEmpty()) {
				if (user.getPassword().length() < 8) {
					throw new RuntimeException("[UserService] 비밀번호는 8자 이상이어야 합니다.");
				}
			}
		}

		// 입력값 name 체크
		if (user.getName() != null && !user.getName().isEmpty()) {
			if (user.getName().length() > 10) {
				throw new RuntimeException("[UserService] 이름은 10자 이하로 입력해야 합니다.");
			}
		}

		// 입력값 phone 체크
		if (user.getPhone() != null && !user.getPhone().trim().isEmpty()) {
			String phoneDigits = user.getPhone().replaceAll("\\D", "");
			if (!phoneDigits.matches("^\\d{11}$")) {
				throw new RuntimeException("[UserService] 전화번호는 11자리 숫자로 입력해야 합니다.");
			}
		}
	}
}