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
}
