package com.travelers.travelweb.domain.product.service;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.product.domain.Product;
import com.travelers.travelweb.domain.product.repository.JdbcProductRepository;
import com.travelers.travelweb.domain.product.repository.ProductRepository;
import com.travelers.travelweb.global.config.MyBatisConfig;

public class ProductService {

	private final ProductRepository productRepository = new JdbcProductRepository(MyBatisConfig.getSqlSessionFactory());

	public void registerProduct(Product product) {
		productRepository.save(product);
	}

	public Optional<Product> getProduct(Long id) {
		return productRepository.findById(id);
	}

	public List<Product> getAllProducts() {
		return productRepository.findAll();
	}

	public void updateProduct(Product product) {
		productRepository.update(product);
	}

	public void deleteProduct(Long id) {
		productRepository.deleteById(id);
	}
}
