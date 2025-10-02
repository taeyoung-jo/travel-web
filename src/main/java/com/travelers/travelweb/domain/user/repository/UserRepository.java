package com.travelers.travelweb.domain.user.repository;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;

public interface UserRepository {

	// Create
	void save(User user);

	Optional<User> findById(Long id);

	Optional<User> findByEmail(String email);

	List<User> findAll();

	// Delete
	void deleteById(Long id);

	// 인증 관련 메서드
	User findByEmailAndPassword(String email, String password);

}
