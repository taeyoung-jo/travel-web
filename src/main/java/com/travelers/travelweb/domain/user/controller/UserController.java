package com.travelers.travelweb.domain.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.domain.user.dto.response.UserResponse;
import com.travelers.travelweb.domain.user.repository.JdbcUserRepository;
import com.travelers.travelweb.domain.user.service.UserService;
import com.travelers.travelweb.global.exception.CustomException;

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

		// 기본 페이지를 로그인 페이지로
		if (action == null)
			action = "login";

		switch (action) {
			case "login":
				req.getRequestDispatcher("/user/login.jsp").forward(req, resp);
				break;

			case "logout":
				// 로그아웃 처리
				HttpSession session = req.getSession(false);
				if (session != null)
					session.invalidate(); // 세션 무효화
				resp.sendRedirect(req.getContextPath() + "/users?action=login");
				break;
			case "testUser":  // 새 액션 이름 // test용 추가
				testUser(req, resp);
				break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String action = req.getParameter("action");
		req.setCharacterEncoding("UTF-8");

		if (action == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=login");
			return;
		}

		switch (action) {
			case "register":
				register(req, resp);
				break;
			case "login":
				login(req, resp);
				break;
		}
	}

	// 로그인 //
	private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String saveId = req.getParameter("saveId"); // on/null

		// ✅ 더미 유저 데이터 (DB 대신 사용) //
		// User dummyUser = new User();
		// dummyUser.setId(1L);
		// dummyUser.setName("홍길동");
		// dummyUser.setEmail("test@example.com");
		// dummyUser.setPassword("1234");

		try {
			// ✅ 실제 DB 검증: UserService가
			// 1) 빈값/이메일 형식 검증
			// 2) repository.findByEmail(...)
			// 3) PasswordUtil.check(입력 비번 vs DB 해시) 수행
			User user = userService.login(email, password).orElseThrow(); // PasswordUtil.check 포함

			// ✅ 로그인 성공: 세션 저장
			HttpSession session = req.getSession();
			session.setAttribute("loginUser", user);

			// ✅ 아이디 저장 쿠키
			Cookie c = ("on".equalsIgnoreCase(saveId))
				? new Cookie("savedEmail", user.getEmail())
				: new Cookie("savedEmail", "");
			c.setPath(req.getContextPath());
			c.setMaxAge(("on".equalsIgnoreCase(saveId)) ? 60 * 60 * 24 * 30 : 0);
			resp.addCookie(c);

			// 홈으로 이동 (중복 redirect 제거)
			resp.sendRedirect(req.getContextPath() + "/index.jsp");
			return;
					
		} catch (CustomException ce) {
			// 서비스에서 온 사용자 메시지를 그대로 노출
			req.setAttribute("error", ce.getUserMessage());
			req.getRequestDispatcher("/user/login.jsp").forward(req, resp);
			return;
		} catch (Exception e) {
			// 예기치 못한 오류
			req.setAttribute("error", "로그인 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			req.getRequestDispatcher("/user/login.jsp").forward(req, resp);
			return;
		}

	}

	// 마이페이지 //
	private void showMyInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);

		// 로그인 상태 확인
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=login");
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

	//    test용 추가
	private void testUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = userService.getById(4L).orElse(null);

		if (user == null) {
			System.out.println("서비스에서 사용자 조회 실패");
			resp.getWriter().println("사용자 정보가 없습니다.");
			return;
		}

		System.out.println("서비스에서 사용자 조회 성공: " + user.getEmail());
		req.setAttribute("user", user);
		req.getRequestDispatcher("/WEB-INF/views/user/userTest.jsp").forward(req, resp);
	}

	// 회원가입 //
	private void register(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		User user = User.builder()
			.email(req.getParameter("email"))
			.name(req.getParameter("name"))
			.password(req.getParameter("password"))
			.phone(req.getParameter("phone"))
			.build();

		userService.register(user); // CustomException 발생 시 Filter에서 처리
		resp.sendRedirect(req.getContextPath() + "/users?action=login");

	}

	// 사용자 업데이트 //
	private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=login");
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

	// 사용자 삭제 //
	private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);

		// 로그인 상태 확인
		if (session == null || session.getAttribute("loginUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/users?action=login");
			return;
		}
		User loginUser = (User)session.getAttribute("loginUser");
		userService.removeById(loginUser.getId()); // DB에서 사용자 삭제 & CustomException → Filter 처리
		session.invalidate();  // 세션 무효화
		resp.sendRedirect(req.getContextPath() + "/users?action=login");  // 삭제되면 로그인 페이지로
	}

	// 로그아웃 //
	private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		HttpSession session = req.getSession(false);

		if (session != null) {
			session.invalidate();  // 세션이 존재하면 무효화(로그아웃)
		}
		resp.sendRedirect(req.getContextPath() + "/users?action=login"); // 로그아웃 후 로그인 페이지로 이동
	}

	// 아이디 찾기 //
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
	private void findPassword(HttpServletRequest req, HttpServletResponse resp) throws
		IOException, ServletException {
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");

		User user = userService.getByEmailAndPhone(email, phone).orElseThrow(); // CustomException → Filter 처리

		req.setAttribute("email", email);  // 성공 시: 새 비밀번호 입력 폼으로 이동
		req.setAttribute("phone", phone);
		req.getRequestDispatcher("/WEB-INF/views/user/resetPasswordTest.jsp").forward(req, resp);
	}

	// 비밀번호 초기화 //
	private void resetPassword(HttpServletRequest req, HttpServletResponse resp) throws
		IOException, ServletException {
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String newPassword = req.getParameter("newPassword");

		User user = userService.getByEmailAndPhone(email, phone).orElseThrow(); // CustomException → Filter 처리
		userService.updatePassword(user.getId(), newPassword); // 새 비밀번호 업데이트 & CustomException → Filter 처리
		resp.sendRedirect(req.getContextPath() + "/users?action=login"); // 새비밀번호 설정 후 로그인 페이지로

	}

}
