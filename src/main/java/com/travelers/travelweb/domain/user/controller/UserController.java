package com.travelers.travelweb.domain.user.controller;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.domain.user.dto.response.UserResponse;
import com.travelers.travelweb.domain.user.repository.JdbcUserRepository;
import com.travelers.travelweb.domain.user.service.UserService;

@WebServlet("/users")
public class UserController extends HttpServlet {

	private UserService userService;

	@Override
	public void init() throws ServletException {
		this.userService = new UserService(new JdbcUserRepository());
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		if (action == null)
			action = "loginForm";  // 기본 페이지를 로그인 페이지로

		switch (action) {
			case "loginForm":
				req.getRequestDispatcher("/WEB-INF/views/user/loginTest.jsp").forward(req, resp);
				break;
			case "registerForm":
				req.getRequestDispatcher("/WEB-INF/views/user/registerTest.jsp").forward(req, resp);
				break;
			case "showMyInfo":
				showMyInfo(req, resp);
				break;
			case "findIdForm":
				req.getRequestDispatcher("/WEB-INF/views/user/findIdTest.jsp").forward(req, resp);
				break;
			case "findPasswordForm":
				req.getRequestDispatcher("/WEB-INF/views/user/findPasswordTest.jsp").forward(req, resp);
				break;
			case "resetPasswordForm":
				req.getRequestDispatcher("/WEB-INF/views/user/resetPasswordTest.jsp").forward(req, resp);
				break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String action = req.getParameter("action");

		switch (action) {
			case "register":
				register(req, resp);
				break;
			case "login":
				login(req, resp);
				break;
			case "updateUser":
				updateUser(req, resp);
				break;
			case "deleteUser":
				deleteUser(req, resp);
				break;
			case "logout":
				logout(req, resp);
				break;
			case "findId":
				findId(req, resp);
				break;
			case "findPassword":
				findPassword(req, resp);
				break;
			case "resetPassword":
				resetPassword(req, resp);
				break;
		}
	}

	private void showMyInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		// 로그인 안 됨
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}
		User loginUser = (User)session.getAttribute("loginUser");
		Long userId = loginUser.getId();

		// DB에서 회원 정보 조회
		Optional<User> userOpt = userService.getById(userId);
		if (!userOpt.isPresent()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "사용자를 찾을 수 없습니다.");
			return;
		}
		User user = userOpt.get();

		UserResponse userResp = UserResponse.builder()
			.id(user.getId())
			.email(user.getEmail())
			.name(user.getName())
			.phone(user.getPhone())
			.build();

		req.setAttribute("loginUser", userResp);
		req.getRequestDispatcher("/WEB-INF/views/user/showMyInfoTest.jsp").forward(req, resp);
	}

	private void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String phone = req.getParameter("phone");

		User user = User.builder()
			.email(email)
			.name(name)
			.password(password)
			.phone(phone)
			.build();

		try {
			userService.register(user);
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
		} catch (RuntimeException e) {
			e.printStackTrace();
			resp.getWriter().write("회원가입 실패: 다시 시도해 주세요.");
		}
	}

	private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		Optional<User> userOpt = userService.login(email, password);
		if (userOpt.isPresent()) {
			HttpSession session = req.getSession();
			session.setAttribute("loginUser", userOpt.get());
			req.getRequestDispatcher("/WEB-INF/views/user/homeTest.jsp").forward(req, resp);  // 로그인 성공 시 홈으로 이동
		} else {
			resp.getWriter().write("로그인 실패: 이메일 또는 비밀번호를 확인하세요.");
		}
	}

	private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}

		User loginUser = (User)session.getAttribute("loginUser");

		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String phone = req.getParameter("phone");

		// 수정할 User 객체 생성 (null 또는 빈 값은 Repository에서 자동 무시)
		User updatedUser = User.builder()
			.id(loginUser.getId()) // id는 로그인된 사용자 기준으로 수정
			.email(email)
			.name(name)
			.password(password)
			.phone(phone)
			.build();

		try {
			userService.update(updatedUser);

			// DB에서 최신 정보 다시 가져와 세션 갱신
			Optional<User> refreshed = userService.getById(loginUser.getId());
			refreshed.ifPresent(u -> session.setAttribute("loginUser", u));

			resp.sendRedirect(req.getContextPath() + "/users?action=myInfo");
		} catch (RuntimeException e) {
			e.printStackTrace();
			resp.getWriter().write("회원정보 수정 실패: 다시 시도해 주세요.");
			req.getRequestDispatcher("/WEB-INF/views/user/showMyInfoTest.jsp").forward(req, resp);
		}
	}

	private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			User loginUser = (User)session.getAttribute("loginUser");
			if (loginUser != null) {
				userService.removeById(loginUser.getId());
				session.invalidate();
			}
		}
		resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
	}

	private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
	}

	private void findId(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");

		Optional<User> userOpt = userService.getByNameAndPhone(name, phone);
		if (userOpt.isPresent()) {
			req.setAttribute("email", userOpt.get().getEmail());
			req.getRequestDispatcher("/WEB-INF/views/user/findIdResultTest.jsp").forward(req, resp);
		} else {
			resp.getWriter().write("일치하는 사용자가 없습니다.");
		}
	}

	private void findPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		// 이메일 + 폰번호 입력 후 새 비밀번호 입력 페이지로 이동
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");

		Optional<User> userOpt = userService.getByEmailAndPhone(email, phone);
		if (userOpt.isPresent()) {
			// 성공하면 새 비밀번호 입력 폼으로 이동
			req.setAttribute("email", email);
			req.setAttribute("phone", phone);
			req.getRequestDispatcher("/WEB-INF/views/user/resetPasswordTest.jsp").forward(req, resp);
		} else {
			resp.getWriter().write("일치하는 사용자가 없습니다.");
		}
	}

	private void resetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String newPassword = req.getParameter("newPassword");

		Optional<User> userOpt = userService.getByEmailAndPhone(email, phone);
		if (userOpt.isPresent()) {
			userService.updatePassword(userOpt.get().getId(), newPassword);

			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
		} else {
			resp.getWriter().write("일치하는 사용자가 없습니다.");
		}
	}
}