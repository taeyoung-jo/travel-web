package com.travelers.travelweb.domain.user.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.global.util.DBConnection;

public class JdbcUserRepository implements UserRepository {

	@Override
	public void save(User user) {
		String sql = "INSERT INTO users (email, name, password, phone) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getPassword());
			ps.setInt(4, user.getPhone());
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("회원 저장에 실패했습니다.", e);
		}
	}

	@Override
	public Optional<User> findById(Long id) {
		String sql = "SELECT * FROM users WHERE id = ?";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return Optional.of(mapRow(rs));
			}
		} catch (SQLException e) {
			throw new RuntimeException("회원정보 단건 조회에 실패했습니다.", e);
		}
		return Optional.empty();
	}

	@Override
	public Optional<User> findByEmail(String email) {
		String sql = "SELECT * FROM users WHERE email = ?";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, email);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return Optional.of(mapRow(rs));
			}
		} catch (SQLException e) {
			throw new RuntimeException("회원정보 이메일 조회에 실패했습니다.", e);
		}
		return Optional.empty();
	}

	@Override
	public List<User> findAll() {
		String sql = "SELECT * FROM users";
		List<User> users = new ArrayList<>();
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next())
				users.add(mapRow(rs));
		} catch (SQLException e) {
			throw new RuntimeException("회원정보 전체 조회에 실패했습니다.", e);
		}
		return users;
	}

	@Override
	public void deleteById(Long id) {
		String sql = "DELETE FROM users WHERE id = ?";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("회원 삭제에 실패했습니다.", e);
		}
	}

	private User mapRow(ResultSet rs) throws SQLException {
		return User.builder()
			.id(rs.getLong("id"))
			.email(rs.getString("email"))
			.name(rs.getString("name"))
			.password(rs.getString("password"))
			.phone(rs.getInt("phone"))
			.build();
	}
}