package com.travelers.travelweb.domain.product.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.product.domain.Product;
import com.travelers.travelweb.domain.product.repository.ProductRepository;

public class ProductService {

	private final ProductRepository productRepository;

	public ProductService(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	public void registerProduct(Product product) {
		productRepository.save(product);
	}

	public Optional<Product> getProduct(Long id) {
		return productRepository.findById(id);
	}

	public List<Product> getAllProducts() {
		return productRepository.findAll();
	}

	public List<Product> findProductsByFilter(String continent, String city,
		BigDecimal minPrice, BigDecimal maxPrice,
		LocalDate deptDate, LocalDate arriveDate) {
		return productRepository.findByFilter(continent, city, minPrice, maxPrice, deptDate, arriveDate);
	}

	public void updateProduct(Product product) {
		productRepository.update(product);
	}

	public void deleteProduct(Long id) {
		productRepository.deleteById(id);
	}
}
