package com.travelers.travelweb.domain.product.repository;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.product.domain.Product;

public interface ProductRepository {

	void save(Product product);

	Optional<Product> findById(Long id);

	List<Product> findAll();

	void update(Product product);

	void deleteById(Long id);
}
