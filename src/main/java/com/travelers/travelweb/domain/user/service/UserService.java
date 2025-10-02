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
		user.setPassword(PasswordUtil.hash(user.getPassword()));

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
		User user = repository.findByEmailAndPassword(email, password);
		return Optional.ofNullable(user);
	}
}
