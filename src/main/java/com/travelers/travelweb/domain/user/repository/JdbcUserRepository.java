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
import com.travelers.travelweb.global.util.PhoneUtil;
import com.travelers.travelweb.global.util.auth.PasswordUtil;

public class JdbcUserRepository implements UserRepository {

	@Override
	public void save(User user) {
		String sql = "INSERT INTO users (email, name, password, phone) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getPhone());
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
	public void update(User user) {
		StringBuilder sql = new StringBuilder("UPDATE users SET ");
		List<Object> params = new ArrayList<>();

		// 이메일이 비어있지 않으면 수정
		if (user.getEmail() != null && !user.getEmail().isEmpty()) {
			sql.append("email = ?, ");
			params.add(user.getEmail());
		}

		// 이름이 비어있지 않으면 수정
		if (user.getName() != null && !user.getName().isEmpty()) {
			sql.append("name = ?, ");
			params.add(user.getName());
		}

		// 비밀번호가 비어있지 않으면 해시 처리 후 수정
		if (user.getPassword() != null && !user.getPassword().isEmpty()) {
			String hashedPassword = PasswordUtil.hash(user.getPassword());
			sql.append("password = ?, ");
			params.add(hashedPassword);
		}

		// 전화번호가 비어있지 않으면 형식 검증 후 수정
		if (user.getPhone() != null && !user.getPhone().isEmpty()) {
			String formattedPhone = PhoneUtil.inputPhoneNumber(user.getPhone());
			sql.append("phone = ?, ");
			params.add(formattedPhone);
		}

		// 수정할 필드가 없으면 종료
		if (params.isEmpty()) {
			return;
		}

		// 마지막 쉼표 제거 후 WHERE 절 추가
		sql.setLength(sql.length() - 2);
		sql.append(" WHERE id = ?");
		params.add(user.getId());

		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql.toString())) {

			// 순서대로 파라미터 바인딩
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("회원정보 수정에 실패했습니다.", e);
		}
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
			.phone(rs.getString("phone"))
			.build();
	}
}