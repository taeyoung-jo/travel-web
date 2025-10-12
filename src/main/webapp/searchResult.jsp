<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색결과 | 노랑풍선</title>
    <link rel="stylesheet" href="css/searchResult.css">
    <script src="js/searchResult.js" defer></script>
</head>
<body>

<jsp:include page="header.jsp" />


<!-- 상단 배너 -->
<section class="result-hero">
    <img src="image/main_slide1.jpg" alt="파리">
    <div class="result-hero-text">
        <h1>프랑스</h1>
    </div>
</section>

<div class="result-container">
    <!-- 왼쪽 필터 -->
    <aside class="filter">
        <h3>필터</h3>
        <div class="filter-section">
            <button class="filter-btn">여행 스타일</button>
            <ul class="filter-list">
                <li><label><input type="checkbox"> 패키지 여행</label></li>
                <li><label><input type="checkbox"> 자유 여행</label></li>
                <li><label><input type="checkbox"> 크루즈</label></li>
            </ul>
        </div>

        <div class="filter-section">
            <button class="filter-btn">여행기간</button>
            <ul class="filter-list">
                <li><label><input type="checkbox"> 3~5일</label></li>
                <li><label><input type="checkbox"> 6~8일</label></li>
                <li><label><input type="checkbox"> 9일 이상</label></li>
            </ul>
        </div>

        <div class="filter-section">
            <button class="filter-btn">상품가격</button>
            <ul class="filter-list">
                <li><label><input type="checkbox"> 100만원 이하</label></li>
                <li><label><input type="checkbox"> 100~200만원</label></li>
                <li><label><input type="checkbox"> 200만원 이상</label></li>
            </ul>
        </div>
    </aside>

    <!-- 오른쪽 상품 리스트 -->
    <section class="result-list">
        <%
            // 예시 데이터 반복 출력
            for (int i = 0; i < 4; i++) {
        %>
        <div class="product-card">
            <div class="product-thumb">
                <img src="image/main_slide1.jpg" alt="상품 이미지">
            </div>
            <div class="product-info">
                <p class="product-path">패키지 ✈ 서울/인천출발 ➜ 유럽</p>
                <h3 class="product-title">파리와 노르망디 일주 7일 #베르사유 궁전</h3>
                <p class="product-sub">파리 근교·도심 핵심 투어</p>
            </div>
            <div class="product-price">
                <p class="price">2,390,000원~</p>
                <button class="detail-btn">상품 상세보기</button>
            </div>
        </div>
        <% } %>
    </section>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
