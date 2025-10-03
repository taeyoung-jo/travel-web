package com.travelers.travelweb.domain.user.service;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.domain.user.repository.UserRepository;
import com.travelers.travelweb.global.util.auth.PasswordUtil;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class UserService {

	private final UserRepository repository;

	public void register(User user) {
		// 이메일 중복 체크
		if (repository.findByEmail(user.getEmail()).isPresent()) {
			throw new RuntimeException("이미 존재하는 이메일입니다.");
		}

		// 비밀번호 해시 처리
		String hashedPassword = PasswordUtil.hash(user.getPassword());
		user.setPassword(hashedPassword);

		repository.save(user);
	}

	public Optional<User> getById(Long id) {
		return repository.findById(id);
	}

	public Optional<User> getByEmail(String email) {
		return repository.findByEmail(email);
	}

	public List<User> findAll() {
		return repository.findAll();
	}

	public void removeById(Long id) {
		repository.deleteById(id);
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
