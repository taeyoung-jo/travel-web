<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== 헤더 ===== -->
<%--<style>--%>
<%--    @import url('https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Black+Han+Sans&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap');--%>

<%--    * {--%>
<%--        margin: 0;--%>
<%--        padding: 0;--%>
<%--        box-sizing: border-box;--%>
<%--    }--%>

<%--    a {--%>
<%--        text-decoration: none;--%>
<%--        color: inherit;--%>
<%--    }--%>

<%--    ul, ol {--%>
<%--        list-style: none;--%>
<%--    }--%>

<%--    img {--%>
<%--        max-width: none;--%>
<%--    }--%>

<%--    body {--%>
<%--        font-family: "Noto Sans", sans-serif;--%>
<%--        font-optical-sizing: auto;--%>
<%--        font-weight: 400;--%>
<%--        font-style: normal;--%>
<%--        color: #040404;--%>
<%--        --main: #FFCC35;--%>
<%--    }--%>

<%--    .main_color {--%>
<%--        color: var(--main);--%>
<%--    }--%>

<%--    .in {--%>
<%--        max-width: 1200px;--%>
<%--        margin: 0 auto;--%>
<%--    }--%>

<%--    .header-top {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        justify-content: space-between;--%>
<%--        padding: 15px 0px;--%>
<%--        background: #fff;--%>
<%--        margin-bottom: 10px;--%>
<%--    }--%>

<%--    .left-group {--%>
<%--        display: flex;--%>
<%--        width: 650px;--%>
<%--    }--%>

<%--    .logo {--%>
<%--        display: flex;--%>
<%--        font-size: 28px;--%>
<%--        font-family: "Black Han Sans", sans-serif;--%>
<%--        font-weight: 400;--%>
<%--        font-style: normal;--%>
<%--        color: #333;--%>
<%--        align-items: flex-end;--%>
<%--        width: 250px;--%>
<%--    }--%>

<%--    .logo img {--%>
<%--        width: 45px;--%>
<%--        height: 45px;--%>
<%--        margin-right: 6px;--%>
<%--    }--%>

<%--    .sm_top {--%>
<%--        font-size: 12px;--%>
<%--        display: flex;--%>
<%--        justify-content: end;--%>
<%--        margin: 10px 0;--%>
<%--    }--%>

<%--    .sm_top > a {--%>
<%--        margin-left: 10px;--%>
<%--    }--%>

<%--    .search-box {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        border: 2px solid #ffcc00;--%>
<%--        border-radius: 30px;--%>
<%--        padding: 5px 15px;--%>
<%--        width: 100%;--%>
<%--    }--%>

<%--    .search-box input {--%>
<%--        border: none;--%>
<%--        outline: none;--%>
<%--        flex: 1;--%>
<%--        padding: 6px;--%>
<%--        font-size: 14px;--%>
<%--        width: 100%;--%>
<%--    }--%>

<%--    .search-box button {--%>
<%--        background: none;--%>
<%--        border: none;--%>
<%--        cursor: pointer;--%>
<%--        font-size: 18px;--%>
<%--        color: #555;--%>
<%--    }--%>

<%--    .user-menu {--%>
<%--        font-size: 13px;--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        gap: 12px;--%>
<%--        color: #555;--%>
<%--        justify-content: end;--%>
<%--        width: 150px;--%>
<%--    }--%>

<%--    .user-menu a {--%>
<%--        color: #555;--%>
<%--    }--%>

<%--    .time-icon > img {--%>
<%--        width: 24px;--%>
<%--    }--%>

<%--    .user-icon > img {--%>
<%--        width: 27px;--%>
<%--    }--%>

<%--    .wish-icon > img {--%>
<%--        width: 22px--%>
<%--    }--%>

<%--    .search-icon > img {--%>
<%--        width: 18px--%>
<%--    }--%>

<%--    .nav-bar {--%>
<%--        width: 100%;--%>
<%--        border-bottom: 1px solid #cfcfcf;--%>
<%--    }--%>

<%--    .gnb {--%>
<%--        display: flex;--%>
<%--        position: relative;--%>
<%--        justify-content: space-between;--%>
<%--        z-index: 3;--%>
<%--        width: 900px;--%>
<%--        margin: 20px auto;--%>
<%--        font-size: 14px;--%>
<%--    }--%>

<%--    .d1:hover {--%>
<%--        color: #ffc40e;--%>
<%--        text-shadow: 1px 0px 0 #ffc40e;--%>
<%--    }--%>
<%--</style>--%>
<link rel="stylesheet" href="css/header.css">

<div class="in">
    <div class="sm_top">
        <a href="login.jsp">로그인</a>
        <a href="signup.jsp">회원가입</a>
        <a href="mypage_reservation.jsp">예약확인/결제</a>
    </div>
    <div class="header-top">
        <div class="left-group">
            <a href="index.jsp">
                <div class="logo">
                    <img src="./image/logo_2.png" alt="로고">
                    <span class="main_color">여행</span>가자
                </div>
            </a>
            <div class="search-box">
                <input type="text" placeholder="30만원대로 떠나는 가성비 보라카이!">
                <button class="search-icon"><img src="./image/search.png"></button>
            </div>
        </div>

        <div class="user-menu">
            <a href="#" class="user-icon tooltip"><img src="./image/user.png" alt="마이페이지"> <span class="tooltip-text">마이페이지</span></a>
            <a href="#" class="time-icon tooltip"><img src="./image/time.png" alt="최근 본 내역"> <span class="tooltip-text">최근 본 내역</span></a>
            <a href="#" class="wish-icon tooltip"><img src="./image/wishlist.png" alt="찜 한 내역" > <span class="tooltip-text">찜 한 내역</span></a>
        </div>
    </div>
</div>

<nav class="nav-bar">
    <ul class="gnb">
        <li class="d1"><a href="#">유럽</a></li>
        <li class="d1"><a href="#">동남아</a></li>
        <li class="d1"><a href="#">일본</a></li>
        <li class="d1"><a href="#">중국</a></li>
        <li class="d1"><a href="#">대만/홍콩/마카오</a></li>
        <li class="d1"><a href="#">호주/뉴질랜드</a></li>
        <li class="d1"><a href="#">괌/사이판</a></li>
        <li class="d1"><a href="#">미주/캐나다/하와이</a></li>
    </ul>
</nav>
