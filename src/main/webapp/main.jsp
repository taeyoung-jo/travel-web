<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 상단 탭 -->
<div class="menu-tabs">
    <div class="active">해외패키지</div>
    <div>항공</div>
    <div>호텔</div>
</div>

<!-- 검색 배너 -->
<section class="hero">
    <div class="hero-text">
        <h1>Visit The Most <br><span>Beautiful Places</span><br>In The World</h1>
        <form class="hero-form" action="calendarTest.jsp" method="get">
            <input type="text" placeholder="Location" value="일본">

            <!-- ✅ 달력 팝업으로 연결 -->
            <div class="calendar-btn" onclick="window.location.href='calendarTest.jsp'">여행일정</div>

            <select>
                <option>1명</option>
                <option>2명</option>
                <option>3명</option>
            </select>
            <button type="submit">Search</button>
        </form>
    </div>
    <div class="hero-img">
        <img src="image/test.jpg" alt="여행 배너">
    </div>
</section>

<!-- 카테고리 -->
<section class="section">
    <h2>Categories <small style="color:#888;">어디로 떠날까요?</small></h2>
    <div class="categories" id="categorySlider">
        <% for(int i=0; i<100; i++){ %>
        <div class="cat"><img src="image/test.jpg"><p>유럽</p></div>
        <% } %>
    </div>
</section>

<!-- 인기 여행상품 -->
<section class="section">
    <h2 style="display:flex; justify-content:space-between; align-items:center;">
        <span>Popular Destinations</span>
        <span>
            <button class="slide-btn" onclick="scrollCards(-1)">&#9664;</button>
            <button class="slide-btn" onclick="scrollCards(1)">&#9654;</button>
        </span>
    </h2>
    <p style="color:#666; font-size:14px;">최근 많은 분이 유행한 여행지입니다</p>
    <div class="cards" id="cardSlider">
        <% for(int i=0; i<8; i++){ %>
        <div class="card">
            <img src="image/test.jpg">
            <div class="info">
                <strong>[신혼특가]</strong>
                이집트 일주 10일 #피라미드 #쿠푸왕
                <div class="price">3,199,000원~</div>
            </div>
        </div>
        <% } %>
    </div>
</section>

<style>
    .menu-tabs {
        display:flex; border-bottom:1px solid #ddd; justify-content:center;
        background:#fff; font-weight:bold;
    }
    .menu-tabs div { padding:15px 30px; cursor:pointer; }
    .menu-tabs div:hover, .menu-tabs .active { color:#ffcc00; border-bottom:2px solid #ffcc00; }

    .hero { display:flex; justify-content:space-between; align-items:center; padding:50px 80px; background:#fafafa; }
    .hero-text { max-width:50%; }
    .hero-text h1 { font-size:36px; margin:0 0 20px; line-height:1.3; }
    .hero-text h1 span { color:#ff9900; }
    .hero-form { display:flex; gap:10px; margin-top:20px; align-items:center; }
    .hero-form input, .hero-form select { padding:12px; border:1px solid #ccc; border-radius:4px; font-size:14px; }
    .hero-form button { background:#333; color:#fff; border:none; border-radius:4px; padding:12px 20px; cursor:pointer; }
    .calendar-btn { padding:12px 20px; border:1px solid #ccc; border-radius:4px; background:#fff; cursor:pointer; }
    .hero-img img { width:350px; border-radius:20px; }

    .section { padding:40px 80px; }
    .section h2 { margin-bottom:15px; font-size:20px; }
    .categories {
        display:flex; gap:20px; overflow-x:auto;
        scroll-behavior:smooth;
        -ms-overflow-style:none; scrollbar-width:none;
    }
    .categories::-webkit-scrollbar { display:none; }
    .categories .cat { text-align:center; flex:0 0 auto; }
    .categories img { width:120px; height:120px; border-radius:60px; object-fit:cover; }

    .cards { display:flex; gap:20px; overflow-x:auto; scroll-behavior:smooth;
        -ms-overflow-style:none; scrollbar-width:none; }
    .cards::-webkit-scrollbar { display:none; }
    .card { width:250px; flex:0 0 auto; background:#fff; border:1px solid #eee; border-radius:8px; box-shadow:0 2px 4px rgba(0,0,0,0.1); }
    .card img { width:100%; height:150px; object-fit:cover; }
    .card .info { padding:15px; font-size:14px; }
    .card .price { font-weight:bold; margin-top:10px; font-size:16px; }

    .slide-btn { border:none; background:#ffcc00; padding:6px 12px; margin-left:5px; border-radius:50%; cursor:pointer; font-size:18px; }
</style>

<script>
    // 카드 버튼 이동 (기존 그대로)
    function scrollCards(dir) {
        const slider = document.getElementById("cardSlider");
        const scrollAmount = 300;
        slider.scrollBy({ left: dir * scrollAmount, behavior: 'smooth' });
    }

    // 카테고리 드래그 슬라이더 (수정 버전)
    const catSlider = document.getElementById("categorySlider");
    let isDragging = false;
    let startX = 0;
    let scrollStart = 0;

    catSlider.addEventListener("mousedown", (e) => {
        // 왼쪽 버튼만 드래그 허용
        if (e.button !== 0) return;

        isDragging = true;
        startX = e.pageX - catSlider.offsetLeft;
        scrollStart = catSlider.scrollLeft;

        // 선택 방지 (텍스트가 선택되는 걸 막기)
        catSlider.style.userSelect = "none";
        catSlider.style.cursor = "grabbing";  // (원하면 이 부분 지워도 돼)
    });

    catSlider.addEventListener("mousemove", (e) => {
        if (!isDragging) return;
        e.preventDefault();

        const x = e.pageX - catSlider.offsetLeft;
        const walk = x - startX;
        catSlider.scrollLeft = scrollStart - walk;
    });

    // 드래그 종료
    function stopDrag() {
        isDragging = false;
        // 해제
        catSlider.style.userSelect = "";
        catSlider.style.cursor = "";  // 원래 커서로 복귀
    }

    catSlider.addEventListener("mouseup", stopDrag);
    catSlider.addEventListener("mouseleave", stopDrag);
</script>

