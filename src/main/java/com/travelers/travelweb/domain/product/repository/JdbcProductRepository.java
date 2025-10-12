package com.travelers.travelweb.domain.product.repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
			session.insert("com.travelers.travelweb.domain.product.repository.ProductRepository.save", product);
		}
	}

	@Override
	public Optional<Product> findById(Long id) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			Product product = session.selectOne(
				"com.travelers.travelweb.domain.product.repository.ProductRepository.findById", id);
			return Optional.ofNullable(product);
		}
	}

	@Override
	public List<Product> findAll() {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			return session.selectList("com.travelers.travelweb.domain.product.repository.ProductRepository.findAll");
		}
	}

	@Override
	public List<Product> findByFilter(String continent, String city,
		BigDecimal minPrice, BigDecimal maxPrice,
		LocalDate deptDate, LocalDate arriveDate) {
		try (SqlSession session = sqlSessionFactory.openSession()) {
			Map<String, Object> params = new HashMap<>();
			params.put("continent", continent);
			params.put("city", city);
			params.put("minPrice", minPrice);
			params.put("maxPrice", maxPrice);
			params.put("deptDate", deptDate);
			params.put("arriveDate", arriveDate);
			return session.selectList(
				"com.travelers.travelweb.domain.product.repository.ProductRepository.findByFilter", params);
		}
	}

	@Override
	public void update(Product product) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			session.update("com.travelers.travelweb.domain.product.repository.ProductRepository.update", product);
		}
	}

	@Override
	public void deleteById(Long id) {
		try (SqlSession session = sqlSessionFactory.openSession(true)) {
			session.delete("com.travelers.travelweb.domain.product.repository.ProductRepository.deleteById", id);
		}
	}
}
