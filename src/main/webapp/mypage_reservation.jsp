<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ include file="header.jsp" %>

<link rel="stylesheet" href="css/mypage_reservation.css">

<div class="mypage-wrapper">
    <!-- 🔸 좌측 메뉴 -->
    <aside class="mypage-sidebar">
        <h3>마이페이지</h3>
        <ul>
            <li class="active">
                <a href="#">예약/취소내역</a>
                <ul class="sub">
                    <li class="selected"><a href="#">예약내역</a></li>
                    <li><a href="#">취소내역</a></li>
                </ul>
            </li>
            <li><a href="#">내 예약 찾기</a></li>
            <li><a href="#">관심 상품</a></li>
            <li><a href="#">개인정보</a></li>
        </ul>
    </aside>

    <!-- 🔸 메인 콘텐츠 -->
    <section class="mypage-content">
        <h2>예약/취소내역</h2>

        <!-- 상단 탭 -->
        <div class="tab-container">
            <button class="tab active">패키지여행</button>
            <button class="tab">자유여행</button>
        </div>

        <!-- 검색 필터 -->
        <div class="search-box-wrap">
            <div class="period">
                <button class="period-btn">예약일</button>
                <button class="period-btn">1개월</button>
                <button class="period-btn">3개월</button>
                <button class="period-btn active">전체</button>
                <input type="date"> ~ <input type="date">
                <button class="search-btn">검색</button>
            </div>
            <p class="notice">· 도착일 기준 5년 전 예약 내역까지 확인 가능합니다.</p>
        </div>

        <!-- 예약 내역 테이블 -->
        <table class="reservation-table">
            <thead>
            <tr>
                <th>예약번호</th>
                <th>예약일</th>
                <th>상품명</th>
                <th>출발일</th>
                <th>인원</th>
                <th>총금액</th>
                <th>납금액</th>
                <th>진행상황</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="8" class="empty">예약하신 내역이 없습니다.</td>
            </tr>
            </tbody>
        </table>
    </section>
</div>

<%@ include file="footer.jsp" %>
