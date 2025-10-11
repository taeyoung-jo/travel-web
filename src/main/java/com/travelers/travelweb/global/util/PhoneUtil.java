package com.travelers.travelweb.global.util;

public class PhoneUtil {
	public static String inputPhoneNumber(String phoneNumber) {
		if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
			throw new IllegalArgumentException("전화번호가 비어 있거나 null입니다.");
		}

		String input = phoneNumber.trim();

		// 하이픈이 없는 경우 자동으로 하이픈 추가
		if (input.matches("^\\d{11}$")) {
			// 예: 01012345678 → 010-1234-5678
			input = input.substring(0, 3) + "-" + input.substring(3, 7) + "-" + input.substring(7);
		}

		// 폰번호 패턴 (010-1234-5678 형태)
		String phonePattern = "^\\d{3}-\\d{4}-\\d{4}$";
		if (!input.matches(phonePattern)) {
			throw new IllegalArgumentException("잘못된 전화번호 형식입니다. 예: 010-1234-5678");
		}

		return input;
	}
}
