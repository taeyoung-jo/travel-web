package com.travelers.travelweb.global.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.travelers.travelweb.global.exception.CustomException;

/**
 * 전역 예외 처리 필터
 * - 모든 요청의 예외를 공통 처리
 * - 개발자에게는 오류 메시지 남기고,
 * - 사용자에게는 오류 내용을 json으로 변환하여 전달
 */
@WebFilter("/*")
public class GlobalExceptionFilter implements Filter {

	private final ObjectMapper objectMapper = new ObjectMapper();

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		try {
			// 다음 필터 또는 서블릿 실행
			chain.doFilter(request, response);

		} catch (CustomException e) {
			// 개발자 로그
			System.err.println("[CustomException] " + e.getDeveloperMessage());

			// JSON으로 전달
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.setStatus(e.getStatusCode());

			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("userMessage", e.getUserMessage());
			errorResponse.put("developerMessage", e.getDeveloperMessage());
			errorResponse.put("statusCode", e.getStatusCode());

			String json = objectMapper.writeValueAsString(errorResponse);
			resp.getWriter().write(json);
			resp.getWriter().flush();

		} catch (Exception e) {
			// 예기치 않은 오류 (CustomException 에서 잡지 못한 나머지 모든 오류)
			System.err.println("[Unhandled Exception] " + e.getMessage());

			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.setStatus(500);

			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("userMessage", "처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			errorResponse.put("developerMessage", e.getMessage());
			errorResponse.put("statusCode", 500);

			String json = objectMapper.writeValueAsString(errorResponse);
			resp.getWriter().write(json);
			resp.getWriter().flush();
		}
	}
}