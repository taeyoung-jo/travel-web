package com.travelers.travelweb.domain.product.repository;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.travelers.travelweb.domain.product.domain.Product;

public class JdbcProductRepository implements ProductRepository {

	private final SqlSessionFactory sqlSessionFactory;

	public JdbcProductRepository(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	@Override
	public void save(Product product) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			session.insert("com.travelers.travelweb.domain.product.ProductRepository.save", product);
		}
	}

	@Override
	public Optional<Product> findById(Long id) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			Product product = session.selectOne(
				"com.travelers.travelweb.domain.product.ProductRepository.findById", id);
			return Optional.ofNullable(product);
		}
	}

	@Override
	public List<Product> findAll() {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			return session.selectList("com.travelers.travelweb.domain.product.ProductRepository.findAll");
		}
	}

	@Override
	public void update(Product product) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			session.update("com.travelers.travelweb.domain.product.ProductRepository.update", product);
		}
	}

	@Override
	public void deleteById(Long id) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			session.delete("com.travelers.travelweb.domain.product.ProductRepository.deleteById", id);
		}
	}
}
