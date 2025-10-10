// ==========================
// 🟡 메인 슬라이드 (Swiper)
// ==========================
window.addEventListener('load', () => {
    const swiper = new Swiper(".mySwiper", {
        slidesPerView: 1.5,
        centeredSlides: true,
        loop: true,
        initialSlide: 0,         // 항상 첫 슬라이드부터 시작
        spaceBetween: 0,
        loopedSlides: 6,         // 실제 슬라이드 개수
        loopFillGroupWithBlank: false,
        speed: 800,
        autoplay: {
            delay: 4000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
    });
});

// ==========================
// 🟡 카드 슬라이드 버튼 이동
// ==========================
function scrollCards(dir) {
    const slider = document.getElementById("cardSlider");
    if (!slider) return;
    const scrollAmount = 300;
    slider.scrollBy({ left: dir * scrollAmount, behavior: 'smooth' });
}

// ==========================
// 🟡 카테고리 드래그 슬라이더
// ==========================
window.addEventListener('DOMContentLoaded', () => {
    const catSlider = document.getElementById("categorySlider");
    if (!catSlider) return;

    let isDragging = false;
    let startX = 0;
    let scrollStart = 0;

    catSlider.addEventListener("mousedown", (e) => {
        if (e.button !== 0) return; // 왼쪽 버튼만 허용
        isDragging = true;
        startX = e.pageX - catSlider.offsetLeft;
        scrollStart = catSlider.scrollLeft;

        // 텍스트 선택 방지 & 커서 변경
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
    const stopDrag = () => {
        isDragging = false;
        catSlider.style.userSelect = "";
        catSlider.style.cursor = "";
    };

    catSlider.addEventListener("mouseup", stopDrag);
    catSlider.addEventListener("mouseleave", stopDrag);
});
