package com.travelers.travelweb.global.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequestValidator {

	// id가 숫자인지 검증
	public static Long validateAndParseId(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String idParam = req.getParameter("id");
		if (idParam == null || !idParam.matches("\\d+")) {
			res.sendError(HttpServletResponse.SC_BAD_REQUEST, "id는 숫자여야 합니다.");
			return null;
		}
		return Long.parseLong(idParam);
	}

	// 가격 검증 - 숫자 형식, 빈 값 허용
	public static boolean validatePrice(String price) {
		return price == null || price.isBlank() || price.matches("\\d+");
	}

	// 필수 가격 검증 - 숫자 형식, 빈 값 불가
	public static boolean validateRequiredPrice(String price, HttpServletResponse res) throws IOException {
		if (price == null || price.isBlank() || !price.matches("\\d+(\\.\\d+)?")) {
			res.sendError(HttpServletResponse.SC_BAD_REQUEST, "가격 형식이 잘못되었습니다.");
			return false;
		}
		return true;
	}

	// 최소/최대 가격 범위 검증 (빈 값 허용)
	public static boolean validatePriceRange(String min, String max, HttpServletResponse res) throws IOException {
		if (!validatePrice(min) || !validatePrice(max)) {
			res.sendError(HttpServletResponse.SC_BAD_REQUEST, "가격 형식이 잘못되었습니다.");
			return false;
		}
		return true;
	}
}
