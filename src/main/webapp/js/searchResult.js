// 필터 아코디언 기능
document.addEventListener("DOMContentLoaded", () => {
    const filterButtons = document.querySelectorAll(".filter-btn");

    filterButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            const list = btn.nextElementSibling;
            list.classList.toggle("open");
            list.style.display = list.classList.contains("open") ? "block" : "none";
        });
    });
});
