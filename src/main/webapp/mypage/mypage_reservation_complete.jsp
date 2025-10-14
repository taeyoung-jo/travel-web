<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<link rel="stylesheet" href="<c:url value='/css/header.css'/>">--%>
<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">
<%--<link rel="stylesheet" href="<c:url value='/css/footer.css'/>">--%>

<%@ include file="../header.jsp" %>

<div class="mypage-wrapper in">

    <!-- ✅ sidebar -->
    <%@ include file="mypage_sidebar.jsp" %>

    <!-- ✅ content -->
    <div class="mypage-content">
        <h2>예약완료</h2>
        <div class="reservation-complete">
            <h3><strong>김혜민</strong> 고객님, 예약이 완료되었습니다.</h3>

            <div class="print-btn">
                <button onclick="window.print()">인쇄하기</button>
            </div>

            <table class="recently-table">
                <tr>
                    <th>예약번호</th>
                    <td>RB2025092411234</td>
                    <th>예약일</th>
                    <td>2025.09.24 (수) 17:33</td>
                </tr>
                <tr>
                    <th>상품명</th>
                    <td colspan="3">이탈리아 일주 9일 TW #낭만이 가득한 이탈리아 #친체레레 #피사 #남부 #베로나 #10대특식 #바티칸 #전일정4성호텔</td>
                </tr>
                <tr>
                    <th>예약유형</th>
                    <td>일반예약</td>
                    <th>예약금</th>
                    <td>별도안내</td>
                </tr>
                <tr>
                    <th>이용교통</th>
                    <td colspan="3"><img src="../image/airline.png" alt="항공사"
                                         style="width:18px; vertical-align:middle;"> 대한항공
                    </td>
                </tr>
                <tr>
                    <th>일정</th>
                    <td colspan="3" class="schedule">
                        <p><a href="#">TW405</a> 한국출발 2025.11.19 (수) 10:30 → 현지도착 2025.11.19 (수) 16:25</p>
                        <p><a href="#">TW406</a> 현지출발 2025.11.26 (수) 19:00 → 한국도착 2025.11.27 (목) 14:50</p>
                    </td>
                </tr>
                <tr>
                    <th>여행기간</th>
                    <td colspan="3">7박 9일</td>
                </tr>
            </table>

            <div class="contact-info">
                <p>담당자 <strong>유럽4팀</strong> | 대표번호 <a href="tel:0220227285">02-2022-7285</a></p>
            </div>
        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>
