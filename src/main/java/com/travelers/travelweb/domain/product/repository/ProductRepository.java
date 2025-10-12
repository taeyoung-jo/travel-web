package com.travelers.travelweb.domain.product.repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.product.domain.Product;

public interface ProductRepository {

	void save(Product product);

	Optional<Product> findById(Long id);

	List<Product> findAll();

	List<Product> findByFilter(
		String continent,
		String city,
		BigDecimal minPrice,
		BigDecimal maxPrice,
		LocalDate deptDate,
		LocalDate arriveDate
	);

	void update(Product product);

	void deleteById(Long id);
}
