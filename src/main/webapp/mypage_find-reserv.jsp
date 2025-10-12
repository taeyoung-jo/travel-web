<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ page import="reservation.Reservation, reservation.ReservationRepository, java.util.List" %>

<%
	ReservationRepository repo = new ReservationRepository();
	String reservationNo = request.getParameter("reservationNo");
	Reservation foundReservation = null;

	// 검색한 경우에만 DAO 조회
	if(reservationNo != null && !reservationNo.trim().isEmpty()) {
		reservationNo = reservationNo.trim();
		List<Reservation> allReservations = repo.getAllReservations();
		for(Reservation r : allReservations) {
			if(reservationNo.equals(r.getId())) {
				foundReservation = r;
				break;
			}
		}
	}
%>

<link rel="stylesheet" href="css/mypage_find-reserv.css">

<div class="mypage-wrapper in">
	<!-- 🔸 좌측 메뉴 -->
	<aside class="mypage-sidebar">
		<h2><a href="mypage.jsp">마이페이지</a></h2>
		<ul class="menu">
			<li class="menu-item">
				<div class="menu-title">예약 / 취소내역 <img src="./image/arrow-bottom.png" alt="arrow"></div>
				<ul class="submenu open">
					<li><a href="mypage_reservation.jsp">예약/ 취소내역</a></li>
					<li><a href="mypage_find-reserv.jsp" class="active">예약번호로 찾기</a></li>
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

	<!-- 메인 콘텐츠 -->
	<div class="mypage-content">
		<h2>예약번호로 찾기</h2>

		<form method="get" action="mypage_find-reserv.jsp">
			<table class="reservation-search-table" border="1" cellpadding="8" cellspacing="0">
				<tbody>
				<tr>
					<td>이름</td>
					<td>홍길동</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>2000.00.00</td>
				</tr>
				<tr>
					<td>예약번호</td>
					<td>
						<input type="text" name="reservationNo" placeholder="예)R20251012001" value="<%= reservationNo != null ? reservationNo : "" %>">
					</td>
				</tr>
				</tbody>
			</table>
			<button type="submit" class="find-btn">검색하기</button>
		</form>

		<%-- 검색 후에만 결과 테이블 표시 --%>
		<% if(reservationNo != null) { %>
		<table class="reservation-search-result-table" border="1" cellpadding="8" cellspacing="0" style="width:100%; border-collapse:collapse; margin-top:20px;">
			<thead>
			<tr>
				<th>예약번호</th>
				<th>예약일</th>
				<th>상품명</th>
				<th>출발일</th>
				<th>인원</th>
				<th>총금액</th>
				<th>진행상황</th>
			</tr>
			</thead>
			<tbody>
			<% if(reservationNo.trim().isEmpty()) { %>
			<tr><td colspan="7" class="empty">예약번호를 입력하세요.</td></tr>
			<% } else if(foundReservation == null) { %>
			<tr><td colspan="7" class="empty">예약내역을 찾을 수 없습니다.</td></tr>
			<% } else { %>
			<tr>
				<td><%= foundReservation.getId() %></td>
				<td><%= foundReservation.getOrderDate() %></td>
				<td><%= foundReservation.getName() %></td>
				<td><%= foundReservation.getDepartDate() %></td>
				<td><%= foundReservation.getPeople() %>명</td>
				<td><%= String.format("%,d", foundReservation.getTotalPrice()) %>원</td>
				<td><%= foundReservation.getStatus() %></td>
			</tr>
			<% } %>
			</tbody>
		</table>
		<% } %>

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