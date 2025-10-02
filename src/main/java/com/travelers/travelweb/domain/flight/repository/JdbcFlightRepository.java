package com.travelers.travelweb.domain.flight.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.flight.domain.Flight;
import com.travelers.travelweb.global.util.DBConnection;

public class JdbcFlightRepository implements FlightRepository {

	@Override
	public Optional<Flight> findById(Long id) {
		String sql = "select * from flights where id = ?";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return Optional.of(mapRow(rs));
			}
		} catch (SQLException e) {
			throw new RuntimeException("항공 단건 조회에 실패했습니다.", e);
		}
		return Optional.empty();
	}

	@Override
	public List<Flight> findAll() {
		String sql = "select * from flights";
		List<Flight> flights = new ArrayList<>();
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next())
				flights.add(mapRow(rs));
		} catch (SQLException e) {
			throw new RuntimeException("항공 전체 조회에 실패했습니다.", e);
		}
		return flights;
	}

	private Flight mapRow(ResultSet rs) throws SQLException {
		return Flight.builder()
			.id(rs.getLong("id"))
			.locationId(rs.getLong("location_id"))
			.flightNumber(rs.getString("flight_number"))
			.airline(rs.getString("airline"))
			.deptTime(rs.getObject("dept_time", LocalDateTime.class))
			.arrivalTime(rs.getObject("arrival_time", LocalDateTime.class))
			.price(rs.getDouble("price"))
			.build();
	}
}
