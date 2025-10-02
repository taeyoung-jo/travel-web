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

		if (action.equals("loginForm")) {
			req.getRequestDispatcher("travel-web/user/login.jsp").forward(req, resp);
		} else if (action.equals("registerForm")) {
			req.getRequestDispatcher("travel-web/user/register.jsp").forward(req, resp);
		} else if (action.equals("logout")) {
			HttpSession session = req.getSession(false);
			if (session != null) {
				session.invalidate();
			}
			resp.sendRedirect("/users?action=loginForm");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if (action.equals("register")) {
			register(req, resp);
		} else if (action.equals("login")) {
			login(req, resp);
		}
	}

	private void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		int phone = Integer.parseInt(req.getParameter("phone"));

		User user = User.builder()
			.email(email)
			.name(name)
			.password(password)
			.phone(phone)
			.build();

		try {
			userService.register(user);
			resp.sendRedirect("/users?action=loginForm");
		} catch (RuntimeException e) {
			resp.getWriter().write("회원가입 실패: " + e.getMessage());
		}
	}

	private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		Optional<User> userOpt = userService.login(email, password);
		if (userOpt.isPresent()) {
			HttpSession session = req.getSession();
			session.setAttribute("loginUser", userOpt.get());
			resp.sendRedirect("/home.jsp"); // 로그인 성공 시 홈페이지 이동
		} else {
			resp.getWriter().write("로그인 실패: 이메일 또는 비밀번호를 확인하세요.");
		}
	}
}