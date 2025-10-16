package com.travelers.travelweb.domain.user.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.global.exception.CustomException;
import com.travelers.travelweb.global.util.DBConnection;

public class JdbcUserRepository implements UserRepository {

	@Override
	public void save(User user) {
		if (user.getCreatedAt() == null)
			user.markCreated();

		String sql = "INSERT INTO users (email, name, password, phone, created_at, updated_at, deleted_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getPhone());
			ps.setObject(5, user.getCreatedAt());
			ps.setObject(6, user.getUpdatedAt());
			ps.setObject(7, user.getDeletedAt());
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new CustomException(
				"회원가입 처리 중 오류가 발생했습니다.",
				"[DB Error] save 실패: " + e.getMessage(),
				500
			);
		}
	}

	@Override
	public Optional<User> findById(Long id) {
        String sql = "SELECT * FROM users WHERE id = ? AND deleted_at IS NULL";
        try (Connection conn = DBConnection.open();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("DB 조회 성공: " + rs.getString("email")); // <- 로그 추가
                    return Optional.of(mapRow(rs));
                } else {
                    System.out.println("DB 조회 실패: id=" + id); // <- 로그 추가
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
//		String sql = "SELECT * FROM users WHERE id = ? AND deleted_at IS NULL";
//		try (Connection conn = DBConnection.open();
//			 PreparedStatement ps = conn.prepareStatement(sql)) {
//			ps.setLong(1, id);
//			try (ResultSet rs = ps.executeQuery()) {
//				if (rs.next())
//					return Optional.of(mapRow(rs));
//			}
//		} catch (SQLException e) {
//			throw new CustomException(
//				"회원 조회(id) 중 오류가 발생했습니다.",
//				"[DB Error] findById 실패: " + e.getMessage(),
//				500
//			);
//		}
//		return Optional.empty();
	}

	@Override
	public Optional<User> findByEmail(String email) {
		String sql = "SELECT * FROM users WHERE email = ? AND deleted_at IS NULL";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, email);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return Optional.of(mapRow(rs));
			}
		} catch (SQLException e) {
			throw new CustomException(
				"회원 조회(email) 중 오류가 발생했습니다.",
				"[DB Error] findByEmail 실패: " + e.getMessage(),
				500
			);
		}
		return Optional.empty();
	}

	@Override
	public List<User> findAll() {
		String sql = "SELECT * FROM users WHERE deleted_at IS NULL";
		List<User> users = new ArrayList<>();
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next())
				users.add(mapRow(rs));
		} catch (SQLException e) {
			throw new CustomException(
				"회원 전체 조회 중 오류가 발생했습니다.",
				"[DB Error] findAll 실패: " + e.getMessage(),
				500
			);
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
			sql.append("password = ?, ");
			params.add(user.getPassword());
		}

		// 전화번호가 비어있지 않으면 형식 검증 후 수정
		if (user.getPhone() != null && !user.getPhone().isEmpty()) {
			sql.append("phone = ?, ");
			params.add(user.getPhone());
		}

		// 수정할 필드가 없으면 종료
		if (params.isEmpty()) {
			return;
		}

		user.markUpdated();
		sql.append("updated_at = ?, ");
		params.add(user.getUpdatedAt());

		// 마지막 쉼표 제거 후 WHERE 절 추가
		sql.setLength(sql.length() - 2);
		sql.append(" WHERE id = ? AND deleted_at IS NULL");
		params.add(user.getId());

		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql.toString())) {

			// 순서대로 파라미터 바인딩
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new CustomException(
				"회원 정보 수정 중 오류가 발생했습니다.",
				"[DB Error] update  실패: " + e.getMessage(),
				500
			);
		}
	}

	@Override
	public void deleteById(Long id) {
		User user = User.builder().id(id).build();
		user.markDeleted();

		String sql = "UPDATE users SET deleted_at = ?, updated_at = ? WHERE id = ? AND deleted_at IS NULL";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setObject(1, user.getDeletedAt());
			ps.setObject(2, user.getUpdatedAt());
			ps.setLong(3, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new CustomException(
				"회원 삭제 처리 중 오류가 발생했습니다.",
				"[DB Error] deleteById 실패: " + e.getMessage(),
				500
			);
		}
	}

	@Override
	public Optional<User> findByNameAndPhone(String name, String phone) {
		String sql = "SELECT * FROM users WHERE name = ? AND phone = ? AND deleted_at IS NULL";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, name);
			ps.setString(2, phone);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return Optional.of(mapRow(rs));
			}
			return Optional.empty();
		} catch (SQLException e) {
			throw new CustomException(
				"회원 조회(name, phone) 중 오류가 발생했습니다.",
				"[DB Error] findByNameAndPhone 실패: " + e.getMessage(),
				500
			);
		}
	}

	@Override
	public Optional<User> findByEmailAndPhone(String email, String phone) {
		String sql = "SELECT * FROM users WHERE email = ? AND phone = ? AND deleted_at IS NULL";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, email);
			ps.setString(2, phone);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return Optional.of(mapRow(rs));
			}
			return Optional.empty();
		} catch (SQLException e) {
			throw new CustomException(
				"회원 조회(email, phone) 중 오류가 발생했습니다.",
				"[DB Error] findByEmailAndPhone 실패: " + e.getMessage(),
				500
			);
		}
	}

	@Override
	public void updatePasswordById(Long id, String password) {
		String sql = "UPDATE users SET password = ? WHERE id = ? AND deleted_at IS NULL";
		try (Connection conn = DBConnection.open();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, password);
			ps.setLong(2, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new CustomException(
				"비밀번호 수정 중 오류가 발생했습니다.",
				"[DB Error] updatePasswordById 실패: " + e.getMessage(),
				500
			);
		}
	}

	private User mapRow(ResultSet rs) throws SQLException {
		return User.builder()
			.id(rs.getLong("id"))
			.email(rs.getString("email"))
			.name(rs.getString("name"))
			.password(rs.getString("password"))
			.phone(rs.getString("phone"))
			.createdAt(rs.getObject("created_at", LocalDateTime.class))
			.updatedAt(rs.getObject("updated_at", LocalDateTime.class))
			.deletedAt(rs.getObject("deleted_at", LocalDateTime.class))
			.build();
	}
}
