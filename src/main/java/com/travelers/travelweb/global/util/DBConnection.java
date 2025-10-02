package com.travelers.travelweb.global.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

	private static final String JDBC_DRIVER;
	private static final String DB_URL;
	private static final String USER;
	private static final String PASSWORD;

	static {
		try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
			Properties prop = new Properties();
			if (input == null)
				throw new RuntimeException("DB.properties 파일을 찾지 못했습니다.");
			prop.load(input);

			JDBC_DRIVER = prop.getProperty("JDBC_DRIVER");
			DB_URL = prop.getProperty("DB_URL");
			USER = prop.getProperty("USER");
			PASSWORD = prop.getProperty("PASSWORD");

			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException | IOException e) {
			throw new RuntimeException("DB 연결에 실패했습니다.", e);
		}
	}

	private DBConnection() {
		// 인스턴스화 방지
	}

	public static Connection open() throws SQLException {
		return DriverManager.getConnection(DB_URL, USER, PASSWORD);
	}
}
