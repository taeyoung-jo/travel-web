package com.travelers.travelweb.domain.product.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.travelers.travelweb.domain.product.domain.Product;
import com.travelers.travelweb.domain.product.repository.JdbcProductRepository;
import com.travelers.travelweb.domain.product.repository.ProductRepository;
import com.travelers.travelweb.domain.product.service.ProductService;
import com.travelers.travelweb.global.config.MyBatisConfig;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

	private ProductService productService;

	@Override
	public void init() {
		ProductRepository productRepository = new JdbcProductRepository(MyBatisConfig.getSqlSessionFactory());
		productService = new ProductService(productRepository);
	}

	/**
	 * 상품 전체 목록 또는 단건 조회
	 * @GET /products?id=1	→ 단건 조회
	 * @GET /products 		→ 전체 조회
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String param = req.getParameter("id");
		if (param != null) {
			Long id = Long.valueOf(param);
			Optional<Product> product = productService.getProduct(id);
			product.ifPresent(p -> req.setAttribute("product", p));
			req.getRequestDispatcher("/WEB-INF/views/product/detail.jsp").forward(req, res);
		} else {
			List<Product> products = productService.getAllProducts();
			req.setAttribute("products", products);
			req.getRequestDispatcher("/WEB-INF/jsp/product/list.jsp").forward(req, res);
		}
	}

	/**
	 * 상품 필터 검색
	 * @POST /products
	 * @body: continent, city, minPrice, maxPrice
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String continent = req.getParameter("continent");
		String city = req.getParameter("city");
		String min = req.getParameter("minPrice");
		String max = req.getParameter("maxPrice");

		BigDecimal minPrice = (min == null || min.isBlank()) ? BigDecimal.ZERO : new BigDecimal(min);
		BigDecimal maxPrice = (max == null || max.isBlank()) ? BigDecimal.valueOf(Long.MAX_VALUE) : new BigDecimal(max);

		List<Product> products = productService.findProductsByFilter(continent, city, minPrice, maxPrice, null, null);
		req.setAttribute("products", products);
		req.getRequestDispatcher("/WEB-INF/views/product/list.jsp").forward(req, res);
	}

	/**
	 * 상품 수정
	 * @PUT /products?id=1
	 */
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Long id = Long.valueOf(req.getParameter("id"));
		BigDecimal price = new BigDecimal(req.getParameter("price"));

		Product product = Product.builder()
			.id(id)
			.price(price)
			.build();

		productService.updateProduct(product);
		res.setStatus(HttpServletResponse.SC_OK);
		res.getWriter().write("updated");
	}

	/**
	 * 상품 삭제
	 * @DELETE /products?id=1
	 */
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Long id = Long.valueOf(req.getParameter("id"));
		productService.deleteProduct(id);
		res.setStatus(HttpServletResponse.SC_NO_CONTENT);
	}
}
