<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
<link rel="stylesheet" href="css/calendar.css">
<link rel="stylesheet" href="css/main.css">
<%--<script src="js/calendar.js"></script>--%>
<%--수정--%>
<!-- main slide부분 -->
<div id="main-slide" class="swiper mySwiper">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
            <a href="#">
                <img src="/image/main_slide1.jpg" alt="슬라이드1">
                <div class="visual_img"></div>
                <div class="visual_txt"></div>
            </a>
        </div>
        <div class="swiper-slide">
            <a href="#">
                <img src="/image/main_slide2.jpg" alt="슬라이드2">
                <div class="visual_img"></div>
                <div class="visual_txt"></div>
            </a>
        </div>
        <div class="swiper-slide">
            <a href="#">
                <img src="/image/main_slide3.jpg" alt="슬라이드3">
                <div class="visual_img"></div>
                <div class="visual_txt"></div>
            </a>
        </div>
        <div class="swiper-slide">
            <a href="#">
                <img src="/image/main_slide4.jpg" alt="슬라이드4">
                <div class="visual_img"></div>
                <div class="visual_txt"></div>
            </a>
        </div>
        <div class="swiper-slide">
            <a href="#">
                <img src="/image/main_slide1.jpg" alt="슬라이드1">
                <div class="visual_img"></div>
                <div class="visual_txt"></div>
            </a>
        </div>
        <div class="swiper-slide">
            <a href="#">
                <img src="/image/main_slide2.jpg" alt="슬라이드2">
                <div class="visual_img"></div>
                <div class="visual_txt"></div>
            </a>
        </div>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
</div>

<!-- 검색 배너 -->
<section class="hero">
    <div class="hero-wrap in">
    <div class="hero-title">
        <h4>고객님,<span class="hero-span">어떤 여행을 꿈꾸시나요?</span></h4>
    </div>
    <div class="hero-text">
        <form class="hero-form" action="calendarTest.jsp" method="get">
            <input type="text" placeholder="여행지 입력" >

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
    </div>
</section>

<!-- 카테고리 -->
<section class="section">
    <h2>Categories <small style="color:#888;">어디로 떠날까요?</small></h2>
    <div class="categories" id="categorySlider">
        <% for (int i = 0; i < 100; i++) { %>
        <div class="cat"><img src="image/test.jpg">
            <p>유럽</p></div>
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
        <% for (int i = 0; i < 8; i++) { %>
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
    /*.menu-tabs {*/
    /*    display:flex; border-bottom:1px solid #ddd; justify-content:center;*/
    /*    background:#fff; font-weight:bold;*/
    /*}*/
    /*.menu-tabs div { padding:15px 30px; cursor:pointer; }*/
    /*.menu-tabs div:hover, .menu-tabs .active { color:#ffcc00; border-bottom:2px solid #ffcc00; }*/

    /* 메인 슬라이드 컨테이너 */
    .swiper {
        width: 100%;
        height: 420px;   /* 이미지 원본 세로 크기 */
        margin: 40px auto; /* 가운데 정렬 */
        position: relative;
        border-radius: 16px;
        overflow: hidden;
    }

    .swiper-slide img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 16px;
    }

    .swiper-slide {
        transition: transform 0.6s ease;
        margin-right: 20px;
    }

    .swiper-slide-active {
        transform: scale(1.03);
    }

    /* 화살표 위치 */
    .swiper-button-prev,
    .swiper-button-next {
        color: #fff;
        top: 50%;
        transform: translateY(-50%);
    }

    .swiper-pagination-bullet {
        background: #fff;
        opacity: 0.8;
    }
    .in{max-width: 1200px; margin: 0 auto; --main:#FFCC35;}
    .hero { display:flex; justify-content:space-between; align-items:center;padding: 50px 0; background-color: #fff8ec;}
    .hero-wrap{}
    .hero-title>h4{font-weight: 400; font-size: 22px;}
    .hero-title .hero-span{display: block; font-weight: 700; margin-top: 10px;}
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
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
    <!-- ===== JS ===== -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="js/main_img.js" defer></script>
    <script src="js/calendar.js" defer></script>

    <script defer>
        document.addEventListener("DOMContentLoaded", () => {

            // ✅ Swiper 슬라이더
            const swiper = new Swiper(".mySwiper", {
                slidesPerView: 1.5,
                centeredSlides: true,
                loop: true,
                spaceBetween: 0,
                speed: 800,
                autoplay: {delay: 4000, disableOnInteraction: false},
                pagination: {el: ".swiper-pagination", clickable: true},
                navigation: {nextEl: ".swiper-button-next", prevEl: ".swiper-button-prev"},
            });

            // ✅ 카드 버튼 이동
            window.scrollCards = function (dir) {
                const slider = document.getElementById("cardSlider");
                slider.scrollBy({left: dir * 300, behavior: 'smooth'});
            };

            // ✅ 카테고리 드래그
            const catSlider = document.getElementById("categorySlider");
            let isDragging = false, startX = 0, scrollStart = 0;

            catSlider.addEventListener("mousedown", (e) => {
                if (e.button !== 0) return;
                isDragging = true;
                startX = e.pageX - catSlider.offsetLeft;
                scrollStart = catSlider.scrollLeft;
                catSlider.style.userSelect = "none";
                catSlider.style.cursor = "grabbing";
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

