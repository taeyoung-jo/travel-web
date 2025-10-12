<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== CSS ===== -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
<link rel="stylesheet" href="css/calendar.css">
<link rel="stylesheet" href="css/main.css">
<%--<script src="js/calendar.js"></script>--%>

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

	<div class="slide-counter">
		<button id="prevSlide" class="counter-btn">&lt;</button>
		<span id="currentSlide">1</span> | <span id="totalSlides">6</span>
		<button id="nextSlide" class="counter-btn">&gt;</button>
	</div>
</div>

<!-- 카테고리 -->
<section class="section">
	<h2>Categories <small style="color:#888;">어디로 떠날까요?</small></h2>
	<div class="categories" id="categorySlider">
		<% for (int i = 0; i < 100; i++) { %>
		<div class="cat">
			<img src="image/test.jpg">
			<p>유럽</p>
		</div>
		<% } %>
	</div>
</section>

<!-- 인기 여행상품 -->
<section class="section">
	<h2 style="display:flex; justify-content:space-between; align-items:center;">
		<h2>Popular Destinations</h2>
		<div class="section-head">
			<!-- 🔸 버튼을 왼쪽으로 이동 -->
			<div class="slide-controls">
				<button class="slide-btn" onclick="scrollCards(-1)">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
						<polyline points="15 18 9 12 15 6"></polyline>
					</svg>
				</button>
				<button class="slide-btn" onclick="scrollCards(1)">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
						<polyline points="9 18 15 12 9 6"></polyline>
					</svg>
				</button>
			</div>
		</div>
	</h2>

	<!-- 카드 슬라이더 -->
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

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="js/main_img.js"></script>
<script src="js/calendar.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // ✅ Swiper 슬라이더
        const swiper = new Swiper(".mySwiper", {
            slidesPerView: 1.5,
            centeredSlides: true,
            loop: true,
            spaceBetween: 0,
            speed: 800,
            autoplay: { delay: 4000, disableOnInteraction: false },

            on: {
                init: function () {
                    const realCount = document.querySelectorAll('.swiper-wrapper > .swiper-slide:not(.swiper-slide-duplicate)').length;
                    document.getElementById('totalSlides').textContent = realCount;
                    document.getElementById('currentSlide').textContent = 1; // 초기값
                },
                slideChange: function () {
                    const realCount = document.querySelectorAll('.swiper-wrapper > .swiper-slide:not(.swiper-slide-duplicate)').length;
                    let index = this.realIndex + 1;

                    // loop 때문에 realIndex가 클론 슬라이드 인덱스를 포함할 수 있어서 보정
                    if (index > realCount) index = index - realCount;
                    if (index < 1) index = realCount + index;

                    document.getElementById('currentSlide').textContent = index;
                }
            }
        });

// 버튼
        document.getElementById("prevSlide").addEventListener("click", () => { swiper.slidePrev(); });
        document.getElementById("nextSlide").addEventListener("click", () => { swiper.slideNext(); });

        // ✅ 카드 버튼 이동
        window.scrollCards = function (dir) {
            const slider = document.getElementById("cardSlider");
            slider.scrollBy({ left: dir * 300, behavior: 'smooth' });
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

        function stopDrag() {
            isDragging = false;
            catSlider.style.userSelect = "";
            catSlider.style.cursor = "";
        }

        catSlider.addEventListener("mouseup", stopDrag);
        catSlider.addEventListener("mouseleave", stopDrag);
    });
</script>
