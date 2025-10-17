package com.travelers.travelweb.domain.user.controller;

import java.io.IOException;

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

		// 로그인 상태 확인
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}
		User loginUser = (User)session.getAttribute("loginUser");
		Long userId = loginUser.getId();

		// DB에서 회원 정보 조회 (CustomException 발생 시 Filter에서 처리)
		User user = userService.getById(userId).orElseThrow();

		UserResponse userResp = UserResponse.builder()
			.id(user.getId())
			.email(user.getEmail())
			.name(user.getName())
			.phone(user.getPhone())
			.build();

		req.setAttribute("loginUser", userResp);
		req.getRequestDispatcher("/WEB-INF/views/user/showMyInfoTest.jsp").forward(req, resp);
	}

    private void register(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		User user = User.builder()
			.email(req.getParameter("email"))
			.name(req.getParameter("name"))
			.password(req.getParameter("password"))
			.phone(req.getParameter("phone"))
			.build();

		userService.register(user); // CustomException 발생 시 Filter에서 처리
		resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");

	}

	private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		User user = userService.login(email, password).orElseThrow(); // CustomException → Filter 처리
		HttpSession session = req.getSession();
		session.setAttribute("loginUser", user);
		resp.sendRedirect(req.getContextPath() + "/home");  // 로그인 성공 시 홈으로 이동
	}

	private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}

		User loginUser = (User)session.getAttribute("loginUser");

		User updatedUser = User.builder()
			.id(loginUser.getId())
			.email(req.getParameter("email"))
			.name(req.getParameter("name"))
			.password(req.getParameter("password"))
			.phone(req.getParameter("phone"))
			.build();

		userService.update(updatedUser);  // CustomException → Filter 처리
		resp.sendRedirect(req.getContextPath() + "/users?action=showMyInfo");  // 성공 시 내 정보 페이지로 이동
	}

	private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);

		// 로그인 상태 확인
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}
		User loginUser = (User)session.getAttribute("loginUser");
		userService.removeById(loginUser.getId()); // DB에서 사용자 삭제 & CustomException → Filter 처리
		session.invalidate();  // 세션 무효화
		resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");  // 삭제되면 로그인 페이지로
	}

	private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);

		if (session != null) {
			session.invalidate();  // 세션이 존재하면 무효화(로그아웃)
		}
		resp.sendRedirect(req.getContextPath() + "/users?action=loginForm"); // 로그아웃 후 로그인 페이지로 이동
	}

	private void findId(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");

		User user = userService.getByNameAndPhone(name, phone).orElseThrow(); // CustomException → Filter 처리
		req.setAttribute("email", user.getEmail());
		req.getRequestDispatcher("/WEB-INF/views/user/findIdResultTest.jsp").forward(req, resp);
	}

	/**
	 * 비밀번호 찾기 기능
	 * 사용자에게 이메일 폰번호를 입력 받고,
	 * DB에 해당 데이터가 있으면, 새 비밀번호 설정 페이지로 이동
	 */
	private void findPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");

		User user = userService.getByEmailAndPhone(email, phone).orElseThrow(); // CustomException → Filter 처리

		req.setAttribute("email", email);  // 성공 시: 새 비밀번호 입력 폼으로 이동
		req.setAttribute("phone", phone);
		req.getRequestDispatcher("/WEB-INF/views/user/resetPasswordTest.jsp").forward(req, resp);
	}

	private void resetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String newPassword = req.getParameter("newPassword");

		User user = userService.getByEmailAndPhone(email, phone).orElseThrow(); // CustomException → Filter 처리
		userService.updatePassword(user.getId(), newPassword); // 새 비밀번호 업데이트 & CustomException → Filter 처리
		resp.sendRedirect(req.getContextPath() + "/users?action=loginForm"); // 새비밀번호 설정 후 로그인 페이지로

	}
}