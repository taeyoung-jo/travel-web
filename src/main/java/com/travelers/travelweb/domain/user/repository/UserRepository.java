package com.travelers.travelweb.domain.user.repository;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;

public interface UserRepository {

	// Create
	void save(User user);

	// Read
	Optional<User> findById(Long id);

	Optional<User> findByEmail(String email);

	List<User> findAll();

	// Update
	void update(User user);

	// Delete
	void deleteById(Long id);

	// 아이디 찾기, 비밀번호 찾기 기능 구현
	Optional<User> findByNameAndPhone(String name, String phone);

	Optional<User> findByEmailAndPhone(String email, String phone);

	void updatePasswordById(Long userId, String hashedPassword);
}
