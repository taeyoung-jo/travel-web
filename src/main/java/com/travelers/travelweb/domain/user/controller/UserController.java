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
import com.travelers.travelweb.global.util.PhoneUtil;

@WebServlet("/users")
public class UserController extends HttpServlet {

	private UserService userService;

	@Override
	public void init() throws ServletException {
		this.userService = new UserService(new JdbcUserRepository());
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String action = req.getParameter("action");

		if(action == null) {
			action = "loginForm";  // 기본 페이지를 로그인 페이지로
		}

		if (action.equals("loginForm")) {
			req.getRequestDispatcher("/user/login.jsp").forward(req, resp);
		} else if (action.equals("registerForm")) {
			req.getRequestDispatcher("/user/register.jsp").forward(req, resp);
		} else if (action.equals("myInfo")) {
			myInfo(req, resp);
		}
	}

@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		req.setCharacterEncoding("utf-8");
		String action = req.getParameter("action");

		if (action.equals("register")) {
			register(req, resp);
		} else if (action.equals("login")) {
			login(req, resp);
		} else if (action.equals("update")) {
			update(req, resp);
		} else if (action.equals("delete")) {
			HttpSession session = req.getSession(false);
			if (session != null) {
				User loginUser = (User) session.getAttribute("loginUser");
				if (loginUser != null) {
					userService.removeById(loginUser.getId());
					session.invalidate();
				}
			}
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
		} else if (action.equals("logout")) {
			HttpSession session = req.getSession(false);
			if (session != null) {
				session.invalidate();
			}
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
		}
	}

	private void myInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException ,IOException {
		HttpSession session = req.getSession(false);
		// 로그인 안 됨
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}
		User loginUser = (User) session.getAttribute("loginUser");
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
		req.getRequestDispatcher(req.getContextPath() + "/user/myInfo.jsp").forward(req, resp);
	}

	private void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String phone = PhoneUtil.inputPhoneNumber(req.getParameter("phone"));

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
			resp.getWriter().write("회원가입 실패: 다시 시도해 주세요.");
		}
	}

	private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		Optional<User> userOpt = userService.login(email, password);
		if (userOpt.isPresent()) {
			HttpSession session = req.getSession();
			session.setAttribute("loginUser", userOpt.get());
			resp.sendRedirect(req.getContextPath() + "/user/home.jsp"); // 로그인 성공 시 홈페이지 이동
		} else {
			resp.getWriter().write("로그인 실패: 이메일 또는 비밀번호를 확인하세요.");
		}
	}

	private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");

		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String phone = req.getParameter("phone");

		// 수정할 User 객체 생성 (null 또는 빈 값은 Repository에서 자동 무시)
		User updatedUser = User.builder()
			.id(loginUser.getId()) // 로그인된 사용자 기준으로 수정
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
			resp.getWriter().write("회원정보 수정 실패: 다시 시도해 주세요.");
			req.getRequestDispatcher("/user/myInfo.jsp").forward(req, resp);
		}
	}
}