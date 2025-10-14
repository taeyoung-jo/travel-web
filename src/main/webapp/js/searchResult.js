document.querySelectorAll('.detail-btn').forEach(btn => {
    btn.addEventListener('click', (e) => {
        e.stopPropagation(); // 카드 클릭 이벤트 방지
        const pkgId = btn.dataset.pkgId;
        const pkgName = btn.closest('.product-card').querySelector('.product-title').textContent;
        openCalendarModal(pkgId, pkgName);
    });
});

// 카드 클릭 → 상세페이지
document.querySelectorAll('.product-card').forEach(card => {
    card.addEventListener('click', () => {
        const pkgId = card.dataset.pkgId;
        location.href = `detailPackage.jsp?pkg=${encodeURIComponent(pkgId)}`;
    });
});

// 모달 열기
function openCalendarModal(pkgId, pkgName) {
    document.getElementById('modalOverlay').style.display = 'block';
    document.getElementById('calendarModal').style.display = 'block';
    document.querySelector('#calendarModal .title').textContent = `<${pkgName}> 출발일 보기`;

    initCalendar(pkgId, pkgName); // pkgId와 pkgName 전달
}

// 모달 닫기
document.getElementById('closeModal').addEventListener('click', () => {
    document.getElementById('modalOverlay').style.display = 'none';
    document.getElementById('calendarModal').style.display = 'none';
});

// 캘린더 + 일정
function initCalendar(pkgId, pkgName) {
    // 더미 데이터 생성
    const airlines = ["제주항공", "이스타항공", "대한항공", "아시아나"];
    const data = [];
    const today = new Date();
    const pad = n => n.toString().padStart(2, "0");
    const fmt = d => d.getFullYear() + "-" + pad(d.getMonth() + 1) + "-" + pad(d.getDate());

    for (let i = 0; i < 60; i++) {
        const d = new Date(today);
        d.setDate(d.getDate() + i);
        const cnt = Math.floor(Math.random() * 3);
        for (let k = 0; k < cnt; k++) {
            const airline = airlines[Math.floor(Math.random() * airlines.length)];
            data.push({
                id: fmt(d) + "-" + k,
                packageId: pkgId,
                title: pkgName,
                date: fmt(d),
                nights: 2,
                days: 3,
                airline,
                flightNo: airline === "제주항공" ? "7C" + (800 + Math.floor(Math.random() * 100)) :
                    airline === "이스타항공" ? "ZE" + (200 + Math.floor(Math.random() * 100)) :
                        airline === "대한항공" ? "KE" + (600 + Math.floor(Math.random() * 100)) : "OZ" + (100 + Math.floor(Math.random() * 100)),
                depart: "09:15",
                arrive: "19:55",
                price: 599000 + Math.floor(Math.random() * 250000 / 1000) * 1000,
                soldOut: Math.random() < 0.22
            });
        }
    }

    const state = {
        year: today.getFullYear(),
        month: today.getMonth(),
        selectedDate: null,
        monthData: data,
        filters: {airlines: new Set(airlines), onlyAvailable: true},
        sortBy: "dateAsc"
    };

    const calBody = document.getElementById("calBody");
    const ymLabel = document.getElementById("ymLabel");
    const list = document.getElementById("list");
    const label = document.getElementById("selectedDateLabel");

    function ymd(y, m, d) {
        return y + "-" + pad(m + 1) + "-" + pad(d);
    }

    function renderCalendar() {
        ymLabel.textContent = state.year + "." + pad(state.month + 1);
        const first = new Date(state.year, state.month, 1);
        const startIdx = first.getDay();
        const lastDay = new Date(state.year, state.month + 1, 0).getDate();
        const prevLast = new Date(state.year, state.month, 0).getDate();
        const rows = [];
        let row = [];
        for (let i = 0; i < startIdx; i++) row.push({
            y: state.month === 0 ? state.year - 1 : state.year,
            m: (state.month + 11) % 12,
            d: prevLast - startIdx + 1 + i,
            other: true
        });
        for (let d = 1; d <= lastDay; d++) {
            row.push({y: state.year, m: state.month, d});
            if (row.length === 7) {
                rows.push(row);
                row = [];
            }
        }
        let add = 1;
        while (row.length > 0 && row.length < 7) row.push({
            y: state.month === 11 ? state.year + 1 : state.year,
            m: (state.month + 1) % 12,
            d: add++,
            other: true
        });
        if (row.length) rows.push(row);

        const byDate = new Map();
        state.monthData.forEach(it => {
            const e = byDate.get(it.date) || {min: Infinity, soldAll: true};
            e.min = Math.min(e.min, it.price);
            e.soldAll = e.soldAll && it.soldOut;
            byDate.set(it.date, e);
        });

        calBody.innerHTML = "";
        rows.forEach(r => {
            const tr = document.createElement("tr");
            r.forEach(c => {
                const td = document.createElement("td");
                if (c.other) td.classList.add("is-other");
                const dateStr = ymd(c.y, c.m, c.d);
                if (c.other === undefined && dateStr === state.selectedDate) td.classList.add("is-selected");
                if (!c.other && byDate.has(dateStr)) {
                    const info = byDate.get(dateStr);
                    const priceDiv = document.createElement("div");
                    priceDiv.className = "price";
                    priceDiv.textContent = info.min.toLocaleString('ko-KR') + "원~";
                    td.appendChild(priceDiv);
                    const dot = document.createElement("span");
                    dot.style.cssText = "position:absolute;top:6px;left:8px;width:8px;height:8px;border-radius:999px;background:" + (info.soldAll ? "red" : "green");
                    td.appendChild(dot);
                }
                const dayEl = document.createElement("div");
                dayEl.className = "day";
                dayEl.textContent = c.d;
                td.appendChild(dayEl);
                td.addEventListener("click", () => {
                    state.selectedDate = dateStr;
                    renderCalendar();
                    renderList();
                });
                tr.appendChild(td);
            });
            calBody.appendChild(tr);
        });
    }

    function applyFilters(items) {
        let out = items.filter(x => state.filters.airlines.has(x.airline));
        if (state.filters.onlyAvailable) out = out.filter(x => !x.soldOut);
        switch (state.sortBy) {
            case"priceAsc":
                out.sort((a, b) => a.price - b.price);
                break;
            case"priceDesc":
                out.sort((a, b) => b.price - a.price);
                break;
            default:
                out.sort((a, b) => a.date.localeCompare(b.date));
        }
        return out;
    }

    function renderList() {
        if (!state.selectedDate) {
            label.textContent = "날짜를 선택해주세요.";
            list.innerHTML = '<div class="empty">왼쪽 달력에서 날짜 선택</div>';
            return;
        }
        label.textContent = "선택한 날짜: " + state.selectedDate;
        const dayItems = state.monthData.filter(x => x.date === state.selectedDate);
        const items = applyFilters(dayItems);
        if (items.length === 0) {
            list.innerHTML = '<div class="empty">조건에 맞는 일정이 없습니다.</div>';
            return;
        }
        list.innerHTML = "";
        items.forEach(it => {
            const div = document.createElement("div");
            div.className = "item";
            div.innerHTML = `<div><h4>${it.title}</h4><div class="meta"><span class="tag">${it.airline}</span><span class="tag">${it.flightNo}</span><span>${it.depart} → ${it.arrive}</span><span>${it.nights}박 ${it.days}일</span>${it.soldOut ? '<span class="sold">예약마감</span>' : ''}</div></div><div class="price">${it.price.toLocaleString('ko-KR')}원~</div>`;
            div.addEventListener("click", () => {
                if (it.soldOut) {
                    alert("예약마감된 상품입니다.");
                    return;
                }
                location.href = `detailPackage.jsp?pkg=${encodeURIComponent(it.packageId)}`;
            });
            list.appendChild(div);
        });
    }

    renderCalendar();
    renderList();

    document.getElementById("prevMonth").addEventListener("click", () => {
        state.month--;
        if (state.month < 0) {
            state.month = 11;
            state.year--;
        }
        renderCalendar();
        renderList();
    });
    document.getElementById("nextMonth").addEventListener("click", () => {
        state.month++;
        if (state.month > 11) {
            state.month = 0;
            state.year++;
        }
        renderCalendar();
        renderList();
    });

    document.querySelectorAll(".flt-air").forEach(cb => cb.addEventListener("change", () => {
        cb.closest(".chip").classList.toggle("checked", cb.checked);
        state.filters.airlines = new Set(Array.from(document.querySelectorAll(".flt-air:checked")).map(i => i.value));
        renderList();
    }));
    document.getElementById("fltOnlyAvailable").addEventListener("change", e => {
        e.target.closest(".chip").classList.toggle("checked", e.target.checked);
        state.filters.onlyAvailable = e.target.checked;
        renderList();
    });
    document.getElementById("sortBy").addEventListener("change", e => {
        state.sortBy = e.target.value;
        renderList();
    });
}
