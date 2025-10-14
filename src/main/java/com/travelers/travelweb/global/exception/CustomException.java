package com.travelers.travelweb.global.exception;

/**
 * 공통 커스텀 예외 클래스
 * - 사용자에게 보여줄 메시지(userMessage)
 * - 개발자가 로그로 볼 메시지(developerMessage)
 */
public class CustomException extends RuntimeException {

	private final String userMessage;        // 사용자에게 보여줄 메시지
	private final String developerMessage;   // 개발자용 메시지
	private final int statusCode;            // HTTP 상태 코드 (선택사항)

	public CustomException(String userMessage, String developerMessage) {
		super(developerMessage);
		this.userMessage = userMessage;
		this.developerMessage = developerMessage;
		this.statusCode = 500;
	}

	public CustomException(String userMessage, String developerMessage, int statusCode) {
		super(developerMessage);
		this.userMessage = userMessage;
		this.developerMessage = developerMessage;
		this.statusCode = statusCode;
	}

	public String getUserMessage() {
		return userMessage;
	}

	public String getDeveloperMessage() {
		return developerMessage;
	}

	public int getStatusCode() {
		return statusCode;
	}
}
