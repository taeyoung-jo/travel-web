package com.travelers.travelweb.domain.hotel.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "hotelServlet", value = "/hotel-servlet")
public class HotelServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, java.io.IOException {
		// JSON 서버에서 데이터 가져오기
		String jsonResult = fetchJsonFromServer("http://localhost:3000/hotels");
		JSONArray filteredHotels = new JSONArray();
		try {
			// db.json이 배열 형태라면 JSONArray로 바로 읽기
			JSONArray hotels = new JSONArray(jsonResult);
			for (int i = 0; i < hotels.length(); i++) {
				JSONObject hotel = hotels.getJSONObject(i);
				// city가 "Tokyo"인 것만 필터
				int tokyoId = 4;
				if (hotel.getInt("city") == tokyoId) {
					JSONObject obj = new JSONObject();
					obj.put("name", hotel.getString("name"));
					obj.put("rating", hotel.getString("rating"));
					filteredHotels.put(obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().write(filteredHotels.toString());
	}

	private String fetchJsonFromServer(String urlStr) {
		StringBuilder result = new StringBuilder();
		try {
			URL url = new URL(urlStr);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");

			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line;
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			rd.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}

	public void destroy() {
	}
}
