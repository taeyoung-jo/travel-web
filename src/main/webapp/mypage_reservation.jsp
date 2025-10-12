<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ page import="reservation.Reservation, reservation.ReservationRepository, java.util.List" %>

<%
	ReservationRepository repo = new ReservationRepository();

	// 탭, 기간 파라미터
	String activeTab = request.getParameter("tab") != null ? request.getParameter("tab") : "reservation";
	int months = 1;
	try {
		String monthParam = request.getParameter("months");
		if(monthParam != null && !monthParam.isEmpty()) months = Integer.parseInt(monthParam);
	} catch(Exception e) { months = 1; }

	List<Reservation> reservationList = null;
	List<Reservation> cancelList = null;

	if("cancel".equals(activeTab)) {
		cancelList = repo.getRecentCancellations(months); // ✅ 취소내역도 최근 N개월 필터 적용
	} else {
		reservationList = repo.getRecentReservations(months);
	}
%>

<link rel="stylesheet" href="css/mypage_reservation.css">

<div class="mypage-wrapper in">
	<!-- 🔸 좌측 메뉴 -->
	<aside class="mypage-sidebar">
		<h2><a href="mypage.jsp">마이페이지</a></h2>
		<ul class="menu">
			<li class="menu-item">
				<div class="menu-title">예약 / 취소내역 <img src="./image/arrow-bottom.png" alt="arrow"></div>
				<ul class="submenu open">
					<li><a href="mypage_reservation.jsp" class="active">예약/ 취소내역</a></li>
					<li><a href="mypage_find-reserv.jsp">예약번호로 찾기</a></li>
				</ul>
			</li>
			<li class="menu-item">
				<div class="menu-title">관심상품 <img src="./image/arrow-bottom.png" alt="arrow"></div>
				<ul class="submenu">
					<li><a href="#">찜한 상품</a></li>
					<li><a href="#">최근 본 상품</a></li>
				</ul>
			</li> <li class="menu-item">
			<div class="menu-title">개인정보 <img src="./image/arrow-bottom.png" alt="arrow"></div>
			<ul class="submenu">
				<li><a href="#">회원정보 수정</a></li>
				<li><a href="#">비밀번호 변경</a></li>
				<li><a href="#">회원 탈퇴</a></li>
			</ul>
		</li>
		</ul>
	</aside>

	<div class="mypage-content">
		<h2>예약/취소내역</h2>

		<!-- 탭 -->
		<div class="tab-container">
			<a href="?tab=reservation&months=1" class="tab <%= "reservation".equals(activeTab) ? "active" : "" %>">예약내역</a>
			<a href="?tab=cancel&months=1" class="tab <%= "cancel".equals(activeTab) ? "active" : "" %>">취소내역</a>
		</div>

		<!-- 검색 필터 (예약/취소 모두 표시) -->
		<div class="search-box-wrap">
			<a href="?tab=<%=activeTab%>&months=1" class="period-btn <%= months==1?"active":"" %>">1개월</a>
			<a href="?tab=<%=activeTab%>&months=3" class="period-btn <%= months==3?"active":"" %>">3개월</a>
			<a href="?tab=<%=activeTab%>&months=6" class="period-btn <%= months==6?"active":"" %>">6개월</a>
		</div>

		<!-- 테이블 -->
		<table class="reservation-table">
			<thead>
			<tr>
				<% if("reservation".equals(activeTab)) { %>
				<th>예약번호</th><th>예약일</th><th>상품명</th><th>출발일</th><th>인원</th><th>총금액</th><th>진행상황</th>
				<% } else { %>
				<th>취소번호</th><th>취소일</th><th>상품명</th><th>출발일</th><th>인원</th><th>환불금액</th><th>상태</th>
				<% } %>
			</tr>
			</thead>
			<tbody>
			<% if("reservation".equals(activeTab)) {
				if(reservationList==null || reservationList.isEmpty()) { %>
			<tr><td colspan="7" class="empty">예약하신 내역이 없습니다.</td></tr>
			<% } else {
				for(Reservation r : reservationList) { %>
			<tr>
				<td><%= r.getId() %></td>
				<td><%= r.getOrderDate() %></td>
				<td><%= r.getName() %></td>
				<td><%= r.getDepartDate() %></td>
				<td><%= r.getPeople() %>명</td>
				<td><%= String.format("%,d", r.getTotalPrice()) %>원</td>
				<td><%= r.getStatus() %></td>
			</tr>
			<% } }
			} else {
				if(cancelList==null || cancelList.isEmpty()) { %>
			<tr><td colspan="7" class="empty">취소하신 내역이 없습니다.</td></tr>
			<% } else {
				for(Reservation c : cancelList) { %>
			<tr>
				<td><%= c.getId() %></td>
				<td><%= c.getOrderDate() %></td>
				<td><%= c.getName() %></td>
				<td><%= c.getDepartDate() %></td>
				<td><%= c.getPeople() %>명</td>
				<td><%= String.format("%,d", c.getTotalPrice()) %>원</td>
				<td><%= c.getStatus() %></td>
			</tr>
			<% } }
			} %>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="footer.jsp" %>
<script>
    // ---------------- 메뉴 열고 닫기 + 서브 메뉴 active ----------------
    document.querySelectorAll(".menu-item").forEach(item => {
        const title = item.querySelector(".menu-title");
        const submenu = item.querySelector(".submenu");

        title.addEventListener("click", () => {
            // 현재 메뉴 열고 닫기
            submenu.classList.toggle("open");
        });

        // 서브 메뉴 링크 클릭 시 active 적용
        submenu.querySelectorAll("a").forEach(link => {
            link.addEventListener("click", (e) => {
                // 같은 서브메뉴 안에서만 active 적용
                submenu.querySelectorAll("a").forEach(a => a.classList.remove("active"));
                e.target.classList.add("active");
            });
        });
    });
</script>