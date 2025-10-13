<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="./css/header.css">

<div class="in">
    <div class="sm_top">
        <a href="login.jsp">로그인</a>
        <a href="signup.jsp">회원가입</a>
        <a href="mypage_reservation.jsp">예약확인/결제</a>
    </div>
    <div class="header-top">
        <div class="left-group">
            <a href="../webapp/index.jsp">
            <div class="logo">
                <img src="../image/logo_2.png" alt="로고">
                <span class="main_color">여행</span>가자
            </div>
            </a>
            <div class="search-box">
                <input type="text" placeholder="30만원대로 떠나는 가성비 보라카이!">
                <a href="./search/search_list.jsp">
                    <button class="search-icon">
                        <img src="../image/search.png">
                    </button>
                </a>
            </div>
        </div>

        <div class="user-menu">
            <a href="<c:url value='/mypage/mypage.jsp'/>" class="user-icon tooltip">
                <img src="../image/user.png" alt="마이페이지">
                <span class="tooltip-text">마이페이지</span></a>
            <a href="#" class="time-icon tooltip">
                <img src="../image/time.png" alt="최근 본 내역">
                <span class="tooltip-text">최근 본 내역</span></a>
            <a href="#" class="wish-icon tooltip">
                <img src="../image/wishlist.png" alt="찜 한 내역">
                <span class="tooltip-text">찜 한 내역</span></a>
        </div>
    </div>
</div>

<nav class="nav-bar">
	<ul class="gnb">
		<li class="d1" data-menu="europe"><a href="#">유럽</a></li>
		<li class="d1" data-menu="southeast"><a href="#">동남아</a></li>
		<li class="d1" data-menu="japan"><a href="#">일본</a></li>
		<li class="d1" data-menu="china"><a href="#">중국</a></li>
		<li class="d1" data-menu="taiwan"><a href="#">대만/홍콩/마카오</a></li>
		<li class="d1" data-menu="australia"><a href="#">호주/뉴질랜드</a></li>
		<li class="d1" data-menu="guam"><a href="#">괌/사이판</a></li>
		<li class="d1" data-menu="america"><a href="#">미주/캐나다/하와이</a></li>
	</ul>

	<div class="nav-mega">
		<!-- 유럽 -->
		<div class="mega-menu in" id="europe">
			<div class="menu-column">
				<h4>서유럽</h4>
				<a href="#">파리</a>
				<a href="#">런던</a>
				<a href="#">바르셀로나</a>
				<a href="#">마드리드</a>
				<a href="#">리스본</a>
				<a href="#">암스테르담</a>
			</div>
			<div class="menu-column">
				<h4>동유럽</h4>
				<a href="#">프라하</a>
				<a href="#">부다페스트</a>
				<a href="#">비엔나</a>
				<a href="#">크라코프</a>
				<a href="#">소피아</a>
				<a href="#">자그레브</a>
			</div>
		</div>

		<!-- 동남아 -->
		<div class="mega-menu in" id="southeast">
			<div class="menu-column">
				<h4>주요 도시</h4>
				<a href="#">방콕</a>
				<a href="#">치앙마이</a>
				<a href="#">호치민</a>
				<a href="#">하노이</a>
				<a href="#">싱가포르</a>
			</div>
			<div class="menu-column">
				<h4>섬 지역</h4>
				<a href="#">발리</a>
				<a href="#">롬복</a>
				<a href="#">푸켓</a>
				<a href="#">세부</a>
				<a href="#">보라카이</a>
				<a href="#">코사무이</a>
			</div>
		</div>

		<!-- 일본 -->
		<div class="mega-menu in" id="japan">
			<div class="menu-column">
				<h4>주요 도시</h4>
				<a href="#">도쿄</a>
				<a href="#">오사카</a>
				<a href="#">교토</a>
				<a href="#">후쿠오카</a>
				<a href="#">삿포로</a>
				<a href="#">오키나와</a>
			</div>
		</div>

		<!-- 중국 -->
		<div class="mega-menu in" id="china">
			<div class="menu-column">
				<h4>중국 주요 도시</h4>
				<a href="#">베이징</a>
				<a href="#">상하이</a>
				<a href="#">광저우</a>
				<a href="#">선전</a>
				<a href="#">청두</a>
				<a href="#">시안</a>
			</div>
		</div>

		<!-- 대만/홍콩/마카오 -->
		<div class="mega-menu in" id="taiwan">
			<div class="menu-column">
				<h4>대만</h4>
				<a href="#">타이베이</a>
				<a href="#">가오슝</a>
				<a href="#">타이중</a>
				<a href="#">타이난</a>
			</div>
			<div class="menu-column">
				<h4>홍콩/마카오</h4>
				<a href="#">홍콩</a>
				<a href="#">마카오</a>
			</div>
		</div>

		<!-- 호주/뉴질랜드 -->
		<div class="mega-menu in" id="australia">
			<div class="menu-column">
				<h4>호주</h4>
				<a href="#">시드니</a>
				<a href="#">멜버른</a>
				<a href="#">브리즈번</a>
				<a href="#">퍼스</a>
			</div>
			<div class="menu-column">
				<h4>뉴질랜드</h4>
				<a href="#">오클랜드</a>
				<a href="#">웰링턴</a>
				<a href="#">퀸스타운</a>
			</div>
		</div>

		<!-- 괌/사이판 -->
		<div class="mega-menu in" id="guam">
			<div class="menu-column">
				<h4>괌/사이판</h4>
				<a href="#">괌</a>
				<a href="#">사이판</a>
			</div>
		</div>

		<!-- 미주/캐나다/하와이 -->
		<div class="mega-menu in" id="america">
			<div class="menu-column">
				<h4>미국</h4>
				<a href="#">로스앤젤레스</a>
				<a href="#">뉴욕</a>
				<a href="#">샌프란시스코</a>
				<a href="#">라스베가스</a>
			</div>
			<div class="menu-column">
				<h4>캐나다/하와이</h4>
				<a href="#">밴쿠버</a>
				<a href="#">토론토</a>
				<a href="#">하와이</a>
			</div>
		</div>
	</div>
	<div class="overlay"></div>
</nav>

<script>
    const gnbItems = document.querySelectorAll('.gnb .d1');
    const megaMenus = document.querySelectorAll('.mega-menu');
    const navMega = document.querySelector('.nav-mega');
    const overlay = document.querySelector('.overlay');

    gnbItems.forEach(item => {
        item.addEventListener('mouseenter', () => {
            const menuId = item.dataset.menu;
            megaMenus.forEach(menu => menu.classList.toggle('active', menu.id === menuId));
            const activeMenu = document.getElementById(menuId);
            navMega.style.height = activeMenu.scrollHeight + "px";

            overlay.style.visibility = 'visible';
            overlay.style.opacity = '1';
        });
    });

    // nav-bar 또는 overlay 영역 밖으로 마우스 벗어나면 닫기
    overlay.addEventListener('mouseenter', () => {
        // overlay 위로 올라가도 닫히게
        navMega.style.height = '0';
        megaMenus.forEach(menu => menu.classList.remove('active'));
        overlay.style.opacity = '0';
        overlay.style.visibility = 'hidden';
    });

    document.querySelector('.nav-bar').addEventListener('mouseleave', () => {
        navMega.style.height = '0';
        megaMenus.forEach(menu => menu.classList.remove('active'));
        overlay.style.opacity = '0';
        overlay.style.visibility = 'hidden';
    });

</script>

