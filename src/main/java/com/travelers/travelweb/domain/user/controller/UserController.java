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
		req.setCharacterEncoding("utf-8");
		String action = req.getParameter("action");

		if(action == null) {
			action = "loginForm";  // 기본 페이지를 로그인 페이지로
		}

		if (action.equals("loginForm")) {
			req.getRequestDispatcher(req.getContextPath() + "/user/login.jsp").forward(req, resp);
		} else if (action.equals("registerForm")) {
			req.getRequestDispatcher(req.getContextPath() + "/user/register.jsp").forward(req, resp);
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
			resp.sendRedirect("/users?action=loginForm");
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
		String phone = inputPhoneNumber(req.getParameter("phone"));

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
			resp.sendRedirect(req.getContextPath() + "/user/home.jsp"); // 로그인 성공 시 홈페이지 이동
		} else {
			resp.getWriter().write("로그인 실패: 이메일 또는 비밀번호를 확인하세요.");
		}
	}

	private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		// 기존 데이터를 수정하는 방식이 아니라,
		// 입력받은 수정 정보로 새 데이터를 만들고, 기존 데이터는 삭제.
		// 새 데이터 계정으로 로그인 된 "내 정보 조회" 화면 출력
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=loginForm");
			return;
		}
		User oldUser = (User) session.getAttribute("loginUser");

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String phone = inputPhoneNumber(req.getParameter("phone"));

		// name,email,password,phone 중 입력이 비어 있는 칸은 기존 값 유지
		if (name == null || name.isBlank()) name = oldUser.getName();
		if (email == null || email.isBlank()) email = oldUser.getEmail();
		if (password == null || password.isBlank()) password = oldUser.getPassword();
		if (phone == null || phone.isBlank()) {
			phone = oldUser.getPhone();
		} else {
			phone = inputPhoneNumber(phone);  // 폰번호 형식으로 변환
		}

		// name,email,password,phone 중 변경이 전혀 없을 경우 (기존 데이터 그대로 유지)
		boolean noChange =
			name.equals(oldUser.getName()) &&
				email.equals(oldUser.getEmail()) &&
				password.equals(oldUser.getPassword()) &&
				phone.equals(oldUser.getPhone());
		if (noChange) {
			req.setAttribute("message", "변경된 내용이 없습니다.");
			req.getRequestDispatcher("/user/myInfo.jsp").forward(req, resp);
			return;
		}

		User newUser = User.builder()
			.name(name)
			.email(email)
			.password(password)
			.phone(phone)
			.build();

		userService.removeById(oldUser.getId());
		userService.register(newUser);

		session.setAttribute("loginUser", newUser);
		req.getRequestDispatcher("/user/myInfo.jsp").forward(req, resp);
	}

	public static String inputPhoneNumber(String PhoneNumber) {
		// 폰번호 패턴 (010-1234-5678 형태)
		String phonePattern = "^\\d{3}-\\d{4}-\\d{4}$";

		while (true) {
			String input = PhoneNumber.trim();

			// 하이픈이 없는 경우 자동으로 하이픈 추가
			if (input.matches("^\\d{11}$")) {
				// 예: 01012345678 → 010-1234-5678
				input = input.substring(0, 3) + "-" + input.substring(3, 7) + "-" + input.substring(7);
			}

			if (input.matches(phonePattern)) {
				return input;
			} else {
				System.out.println("잘못된 전화번호 형식입니다. 예: 010-1234-5678");
			}
		}
	}
}