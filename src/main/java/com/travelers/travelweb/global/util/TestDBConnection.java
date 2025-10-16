package com.travelers.travelweb.global.util;

import java.sql.Connection;

public class TestDBConnection {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.open()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ DB 연결 성공!");
            } else {
                System.out.println("❌ DB 연결 실패...");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
