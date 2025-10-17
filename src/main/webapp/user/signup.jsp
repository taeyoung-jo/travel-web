<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/css/signup.css'/>">

<div class="signup-container">
    <!-- 로고 -->
    <div class="logo">
        <img src="../image/logo_2.png" alt="여행가자 로고">
        <h1>여행가자</h1>
        <p class="subtitle">쉽고 빠르게 회원이 되어보세요!</p>
    </div>

    <!-- 혜택 아이콘 -->
    <div class="benefit-box">
        <div class="benefit">
            <img src="../image/test.jpg" alt="포인트 적립">
            <h3>여행가자 포인트<br>적립 · 사용</h3>
        </div>
        <div class="benefit">
            <img src="../image/test.jpg" alt="쿠폰 제공">
            <h3>다양한 할인 혜택<br>쿠폰 제공</h3>
        </div>
        <div class="benefit">
            <img src="../image/test.jpg" alt="이벤트 알림">
            <h3>특가 · 이벤트<br>정보알림 서비스</h3>
        </div>
    </div>

    <!-- 이메일 가입 -->
    <button class="btn email" onclick="location.href='signup_form.jsp'">이메일로 회원가입</button>

    <div class="divider">
        <span>또는</span>
    </div>

    <!-- 소셜 가입 버튼 -->
    <div class="social-buttons">
        <button class="btn kakao">카카오로 시작하기</button>
        <button class="btn naver">네이버로 시작하기</button>
        <button class="btn apple">애플로 시작하기</button>
    </div>

    <footer class="signup-footer">
        <p>© Let's go tour. All Rights Reserved.</p>
    </footer>
</div>
