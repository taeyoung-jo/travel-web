<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="mypage-sidebar">
    <h2><a href="../mypage.jsp">마이페이지</a></h2>
    <ul class="menu">
        <li class="menu-item">
            <div class="menu-title">예약 / 취소내역 <img src="../../image/arrow-bottom.png" alt="arrow"></div>
            <ul class="submenu open">
                <li><a href="../mypage_reservation.jsp">예약/ 취소내역</a></li>
                <li><a href="../mypage_find-reserv.jsp">예약번호로 찾기</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <div class="menu-title">관심상품 <img src="../../image/arrow-bottom.png" alt="arrow"></div>
            <ul class="submenu">
                <li><a href="#">찜한 상품</a></li>
                <li><a href="#">최근 본 상품</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <div class="menu-title">개인정보 <img src="../../image/arrow-bottom.png" alt="arrow"></div>
            <ul class="submenu">
                <li><a href="<c:url value='mypage_edit.jsp'/>">회원정보 수정</a></li>
                <li><a href="<c:url value='mypage_password.jsp'/>">비밀번호 변경</a></li>
                <li><a href="#">회원 탈퇴</a></li>
            </ul>
        </li>
    </ul>
</aside>
