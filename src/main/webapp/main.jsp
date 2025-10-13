<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pack.PackageRepository" %>
<%@ page import="pack.Package" %>
<%
    PackageRepository repo = new PackageRepository();
    List<Package> shortDistancePackages = repo.getAllPackages().subList(0, 7); // 근거리 7개
    List<Package> bestPackage = repo.getAllPackages().subList(7, 11); // 베스트판매 4개
    List<Package> populAll = repo.getAllPackages().subList(10, 14); // 인기급상승 4개
    String[] labels = {"label1.png", "label2.png", "label3.png", "label4.png"};
    String[][] badges = {{"100% 출발"}, {"담당자 추천", "선착순 특가"}, {"선착순 특가"}, {"100% 출발"}};
    // 각 배지마다 클래스명 지정 (배지 순서대로)
    String[][] badgeClasses = {
            {"badge-start"},
            {"badge-recommend", "badge-limited"},
            {"badge-limited"},
            {"badge-start"}
    };
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
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


<!-- 베스트 판매 4 -->
<section class="section in">
    <div class="best-pack">
        <h3>패키지 판매 Best 4</h3>
        <div class="best-pa">
            <% for (int idx = 0; idx < bestPackage.size(); idx++) {
                Package pkg = bestPackage.get(idx);
                String[] badgeSet = badges[idx % badges.length];
                String[] badgeCls = badgeClasses[idx % badgeClasses.length];
            %>
            <div class="packa">
                <div class="img-wrap">
                    <img src="/image/package/<%= labels[idx % labels.length] %>" alt="label-img" class="label-img">
                    <img src="<%= request.getContextPath() + "/" + pkg.getImageUrl() %>"
                         alt="<%= pkg.getPackageName() %>" class="pack-img">
                </div>
                <div class="info">
                    <div class="pa-bege">
                        <% for (int b = 0; b < badgeSet.length; b++) { %>
                        <span class="badge <%= badgeCls[b] %>"><%= badgeSet[b] %></span>
                        <% } %>
                    </div>
                    <strong><%= pkg.getPackageName() %>
                    </strong>
                    <div class="destination">
                        <%= pkg.getDeparture() %> → <%= pkg.getDestination() %>
                    </div>
                    <div class="price">
                        <%= java.text.NumberFormat.getInstance().format(pkg.getPrice()) %>원
                    </div>
                    <div class="pack-arrow">
                        <button id="packNextBtn" class="slide-btn"></button>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</section>

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

<%--인기 급상승--%>
<section class="section in">
    <div class="population">
        <h3>인기 급상승!</h3>
        <h3>New 여행</h3>
        <div class="popul-all">
            <% for (Package pkg : populAll) { %>
            <div class="popul-one">
                <a href="#">
                    <div class="popul-over"></div>
                    <img src="<%= request.getContextPath() + "/" + pkg.getImageUrl() %>"
                         alt="<%= pkg.getPackageName() %>">
                    <div class="popul-txt"><%= pkg.getPackageName() %>
                    </div>
                </a>
            </div>
            <% } %>
        </div>
    </div>
</section>
<%--여행 후기--%>
<section class="section" id="main-review">
    <div class="main-review in">
        <div class="review-info">
            <h2>여행 후기가 들려주는 <br> 진짜 경험</h2>
            <p>사진보다 더 진솔한 고객들의 여행 후기를 확인해보세요.</p>
            <div class="cloude"></div>
        </div>
        <div class="review-card">
            <div class="review-box">
                <a href="#">
                    <img src="/image/review-tokyo.jpg">
                    <div class="review-txt">
                        <p>⭐⭐⭐⭐⭐</p>
                        <p>일정이 알차고 가이드님 설명이 재밌어서 하루하루가 즐거웠어요! 자유시간도 적당히 있어서 쇼핑이랑 맛집투어 둘 다 만족했어요 🍣</p>
                        <h5>도쿄 벚꽃 여행 3일</h5>
                    </div>
                </a>
            </div>
            <div class="review-box">
                <a href="#">
                    <img src="/image/review-swiss.jpg">
                    <div class="review-txt">
                        <p>⭐⭐⭐⭐⭐</p>
                        <p>알프스 풍경이 진짜 그림 같았어요… 평생 기억에 남을 여행이에요. 일정이 타이트했지만 효율적으로 짜여 있어서 여러 도시를 다 볼 수 있었어요!</p>
                        <h5>스위스 알프스 하이킹 6일</h5>
                    </div>
                </a>
            </div>
            <div class="review-box">
                <a href="#">
                    <img src="/image/reveiw-daeman.jpg">
                    <div class="review-txt">
                        <p>⭐⭐⭐⭐⭐</p>
                        <p>야시장 먹거리들이 최고였어요! 대만식 버블티도 현지에서 먹으니 더 맛있었어요 🧋 날씨도 좋고 사람들도 친절해서 여행 내내 기분이 좋았어요</p>
                        <h5>타이베이 미식 여행 3일</h5>
                    </div>
                </a>
            </div>
        </div>
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
