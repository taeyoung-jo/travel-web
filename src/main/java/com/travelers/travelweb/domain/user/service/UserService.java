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

	public void register(User user) {
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

	public Optional<User> getById(Long id) {
		return repository.findById(id);
	}

	public Optional<User> getByEmail(String email) {
		return repository.findByEmail(email);
	}

	public List<User> getAll() {
		return repository.findAll();
	}

	public void update(User user) {
		// 회원 존재 여부 확인
		Optional<User> existingUserOpt = repository.findById(user.getId());
		if (!existingUserOpt.isPresent()) {
			throw new RuntimeException("[UserService] 회원정보수정 실패 : 해당 회원을 찾을 수 없습니다.");
		}

		// 비밀번호가 비어있지 않으면 해시 처리
		if (user.getPassword() != null && !user.getPassword().isEmpty()) {
			String hashedPassword = PasswordUtil.hash(user.getPassword());
			user.setPassword(hashedPassword);
		}

		// 전화번호가 비어있지 않으면 포맷 검증
		if (user.getPhone() != null && !user.getPhone().isEmpty()) {
			user.setPhone(PhoneUtil.inputPhoneNumber(user.getPhone()));
		}

		// DB 업데이트 실행
		repository.update(user);
	}

	public void removeById(Long id) {
		repository.deleteById(id);
	}

	public Optional<User> getByNameAndPhone(String name, String phone) {
		String formattedPhone = PhoneUtil.inputPhoneNumber(phone);
		return repository.findByNameAndPhone(name, formattedPhone);
	}

	public Optional<User> getByEmailAndPhone(String email, String phone) {
		String formattedPhone = PhoneUtil.inputPhoneNumber(phone);
		return repository.findByEmailAndPhone(email, formattedPhone);
	}

	public void updatePassword(Long id, String newPassword) {
		String hashedPassword = PasswordUtil.hash(newPassword);
		repository.updatePasswordById(id, hashedPassword);
	}

	public Optional<User> login(String email, String password) {
		Optional<User> userOpt = repository.findByEmail(email);

		if (userOpt.isPresent()) {
			User user = userOpt.get();

			// 비밀번호 검증 (DB 해시 vs 입력 평문)
			if (PasswordUtil.check(password, user.getPassword())) {
				return Optional.of(user);
			}
		}
		return Optional.empty();
	}
}