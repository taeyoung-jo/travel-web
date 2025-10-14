<%@ page import="reservation.ReservationRepository,reservation.Reservation,java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp" %>

<%
    ReservationRepository repo = new ReservationRepository();
    List<Reservation> recentReservations = repo.getRecentReservations(1); // 1개월 내역
%>

<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">


<div class="mypage-wrapper in">

    <%@ include file="mypage_sidebar.jsp" %>

    <!-- 🔸 메인 콘텐츠 -->
    <div class="mypage-content">
        <h2>안녕하세요, <span>홍길동</span>님!</h2>
        <div class="mypage-iconwrap">
            <div class="user-bar bar-wrap">
                <div><img src="/image/user.png" alt="usericon"></div>
                <a href="#">개인정보 수정</a>
            </div>
            <div class="reserv-bar bar-wrap">
                <div>
                    <img src="/image/reserv.png" alt="usericon">
                </div>
                <a href="mypage_reservation.jsp">예약내역 확인</a>
            </div>
            <div class="wish-bar bar-wrap">
                <div><img src="/image/full_wishlist.png" alt="usericon"></div>
                <a href="#">찜 한 상품</a>
            </div>
        </div>
        <div class="recently-reserv">
            <div class="left-reserv">
                <h3>최근 예약내역</h3>
            </div>
            <div class="right-reserv">
                <a href="mypage_find-reserv.jsp">예약 찾기</a>
                <a href="mypage_reservation.jsp">전체 보기</a>
            </div>
        </div>
        <div class="recently-table">
            <% if(recentReservations == null || recentReservations.isEmpty()) { %>
            <p class="empty">최근 1개월 예약 내역이 없습니다.</p>
            <% } else { %>
            <table border="1" cellpadding="8" cellspacing="0" style="width:100%; border-collapse:collapse; margin-top:10px;">
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
                <% for(Reservation r : recentReservations) { %>
                <tr>
                    <td><%= r.getId() %></td>
                    <td><%= r.getOrderDate() %></td>
                    <td><%= r.getName() %></td>
                    <td><%= r.getDepartDate() %></td>
                    <td><%= r.getPeople() %>명</td>
                    <td><%= String.format("%,d", r.getTotalPrice()) %>원</td>
                    <td><%= r.getStatus() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>
            <ol>
                <li>[항공] 노랑풍선 비회원, 네이버, 카약, 스카이스캐너를 통해 예약하신 내역은 비회원 예약조회에서 확인이 가능합니다.</li>
                <li>[항공] 지마켓, 11번가, 티몬, 위메프, SSG 등 제휴사에서 예약하신 예약내역은 해당 제휴사 마이페이지에서 확인 부탁드립니다.</li>
                <li>해당 예약내역은 노랑풍선 페이지에서 확인이 불가능합니다.</li>
            </ol>
        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>

<script>
    // 메뉴 열고 닫기 + 서브 메뉴 active
    document.querySelectorAll(".menu-item").forEach(item => {
        const title = item.querySelector(".menu-title");
        const submenu = item.querySelector(".submenu");

        title.addEventListener("click", () => {
            submenu.classList.toggle("open");
        });

        submenu.querySelectorAll("a").forEach(link => {
            link.addEventListener("click", (e) => {
                submenu.querySelectorAll("a").forEach(a => a.classList.remove("active"));
                e.target.classList.add("active");
            });
        });
    });


</script>
