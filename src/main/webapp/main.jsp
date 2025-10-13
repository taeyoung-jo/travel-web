<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pack.PackageRepository" %>
<%@ page import="pack.Package" %>
<%
    PackageRepository repo = new PackageRepository();
    List<Package> shortDistancePackages = repo.getAllPackages().subList(0, 7); // 근거리 7개
%>

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

<!-- 단거리 여행지 -->
<section class="section in">
    <div class="short-loc location">
        <h3>가볍게 떠나는 근거리 힐링 여행</h3>
        <p>짧은 시간 동안 떠나도 충분히 즐길 수 있는 가벼운 근거리 여행을 만나보세요.</p>

        <div class="cards" id="shortPackageSlider">
            <% for (Package pkg : shortDistancePackages) { %>
            <div class="card">
                <img src="<%= request.getContextPath() + "/" + pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>">
                <div class="info">
                    <strong><%= pkg.getPackageName() %>
                    </strong>
                    <div class="destination">
                        <%= pkg.getDeparture() %> → <%= pkg.getDestination() %>
                    </div>
                    <div class="price-btnwrap">
                        <div class="price">
                            <%= java.text.NumberFormat.getInstance().format(pkg.getPrice()) %>원
                        </div>
                        <div class="price-btn">
                            <a href="#">자세히 보기</a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <!-- 슬라이드 버튼 -->
        <div class="slide-controls">
            <button id="shortPrevBtn" class="slide-btn"></button>
            <button id="shortNextBtn" class="slide-btn"></button>
        </div>
    </div>
</section>
<!-- 장거리 여행지 -->
<section class="section in">
    <div class="short-loc location">

    </div>
</section>


<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="js/main_img.js"></script>
<script src="js/calendar.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // 메인 Swiper 슬라이더
        const swiper = new Swiper(".mySwiper", {
            slidesPerView: 1.5,
            centeredSlides: true,
            loop: true,
            spaceBetween: 0,
            speed: 800,
            autoplay: {delay: 4000, disableOnInteraction: false},

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
        document.getElementById("prevSlide").addEventListener("click", () => {
            swiper.slidePrev();
        });
        document.getElementById("nextSlide").addEventListener("click", () => {
            swiper.slideNext();
        });

        // 단거리 여행지
        const shortSlider = document.getElementById("shortPackageSlider");
        const btnPrev = document.getElementById("shortPrevBtn");
        const btnNext = document.getElementById("shortNextBtn");

        if (shortSlider && btnPrev && btnNext) {
            btnPrev.addEventListener("click", () => shortSlider.scrollBy({left: -300, behavior: 'smooth'}));
            btnNext.addEventListener("click", () => shortSlider.scrollBy({left: 300, behavior: 'smooth'}));

            let isDragging = false;
            let startX = 0;
            let scrollStart = 0;

            shortSlider.addEventListener("mousedown", (e) => {
                isDragging = true;
                startX = e.pageX - shortSlider.offsetLeft;
                scrollStart = shortSlider.scrollLeft;
                shortSlider.style.cursor = "grabbing";
                shortSlider.style.userSelect = "none";
            });

            shortSlider.addEventListener("mousemove", (e) => {
                if (!isDragging) return;
                const x = e.pageX - shortSlider.offsetLeft;
                shortSlider.scrollLeft = scrollStart - (x - startX);
            });

            const stopDrag = () => {
                isDragging = false;
                shortSlider.style.cursor = "";
                shortSlider.style.userSelect = "";
            };

            shortSlider.addEventListener("mouseup", stopDrag);
            shortSlider.addEventListener("mouseleave", stopDrag);
        }

    });
</script>
