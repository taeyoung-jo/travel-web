document.addEventListener("DOMContentLoaded", () => {

    // ✅ 탭 전환
    const tabs = document.querySelectorAll(".tab");
    const contents = document.querySelectorAll(".tab-content");

    tabs.forEach(tab => {
        tab.addEventListener("click", () => {
            tabs.forEach(t => t.classList.remove("active"));
            contents.forEach(c => c.classList.remove("active"));

            tab.classList.add("active");
            document.getElementById(tab.dataset.tab).classList.add("active");
        });
    });

    // ✅ 인원 수 증감
    const minus = document.querySelector(".minus");
    const plus = document.querySelector(".plus");
    const countInput = document.querySelector(".counter input");
    const totalPrice = document.getElementById("totalPrice");

    const unitPrice = 135000;

    function updateTotal() {
        const count = parseInt(countInput.value) || 1;
        totalPrice.textContent = (unitPrice * count).toLocaleString() + "원";
    }

    minus.addEventListener("click", () => {
        let value = parseInt(countInput.value);
        if (value > 1) countInput.value = value - 1;
        updateTotal();
    });

    plus.addEventListener("click", () => {
        let value = parseInt(countInput.value);
        countInput.value = value + 1;
        updateTotal();
    });
});
