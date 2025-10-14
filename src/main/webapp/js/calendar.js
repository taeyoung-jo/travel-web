// ------------------- 더미데이터 -------------------
const DUMMY = (() => {
    const titles = [pkgName];
    const airlines = ["제주항공", "이스타항공", "대한항공", "아시아나"];
    const data = [];
    const today = new Date();
    const addDays = (d, n) => {
        const x = new Date(d);
        x.setDate(x.getDate() + n);
        return x;
    };
    const pad = (n) => n.toString().padStart(2, "0");
    const fmt = (d) => d.getFullYear() + "-" + pad(d.getMonth() + 1) + "-" + pad(d.getDate());

    for (let i = 0; i < 60; i++) {
        const d = addDays(today, i);
        const cnt = Math.floor(Math.random() * 3);
        for (let k = 0; k < cnt; k++) {
            const airline = airlines[Math.floor(Math.random() * airlines.length)];
            const price = 599000 + Math.floor(Math.random() * 250000 / 1000) * 1000;
            data.push({
                id: fmt(d) + "-" + k,
                packageId: "PKG-JP-OSK-3D2N",
                title: titles[0],
                date: fmt(d),
                nights: 2,
                days: 3,
                airline,
                flightNo: airline === "제주항공" ? "7C" + (800 + Math.floor(Math.random() * 100)) :
                    airline === "이스타항공" ? "ZE" + (200 + Math.floor(Math.random() * 100)) :
                        airline === "대한항공" ? "KE" + (600 + Math.floor(Math.random() * 100)) : "OZ" + (100 + Math.floor(Math.random() * 100)),
                depart: "09:15",
                arrive: "19:55",
                price,
                soldOut: Math.random() < 0.22
            });
        }
    }
    return data;
})();

const state = {
    year: new Date().getFullYear(),
    month: new Date().getMonth(),
    selectedDate: null,
    monthData: DUMMY,
    filters: {airlines: new Set(["제주항공", "이스타항공", "대한항공", "아시아나"]), onlyAvailable: true},
    sortBy: "dateAsc"
};

const pad = (n) => n.toString().padStart(2, "0");
const ymd = (y, m, d) => y + "-" + pad(m + 1) + "-" + pad(d);

const calBody = document.getElementById("calBody");
const ymLabel = document.getElementById("ymLabel");

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
    while (row.length > 0 && row.length < 7) {
        row.push({
            y: state.month === 11 ? state.year + 1 : state.year,
            m: (state.month + 1) % 12,
            d: add++,
            other: true
        });
    }
    if (row.length) rows.push(row);

    calBody.innerHTML = "";
    const byDate = new Map();
    state.monthData.forEach(it => {
        const e = byDate.get(it.date) || {min: Infinity, soldAll: true};
        e.min = Math.min(e.min, it.price);
        e.soldAll = e.soldAll && it.soldOut;
        byDate.set(it.date, e);
    });

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
                dot.style.position = "absolute";
                dot.style.top = "6px";
                dot.style.left = "8px";
                dot.style.width = "8px";
                dot.style.height = "8px";
                dot.style.borderRadius = "999px";
                dot.style.background = info.soldAll ? "var(--danger)" : "var(--ok)";
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
        case"dateAsc":
        default:
            out.sort((a, b) => a.date.localeCompare(b.date));
            break;
    }
    return out;
}

function renderList() {
    const list = document.getElementById("list");
    const label = document.getElementById("selectedDateLabel");
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
    list.innerHTML = items.map(it => '<div class="item"><div><h4>' + it.title + '</h4><div class="meta"><span class="tag">' + it.airline + '</span><span class="tag">' + it.flightNo + '</span><span>' + it.depart + ' → ' + it.arrive + '</span><span>' + it.nights + '박 ' + it.days + '일</span>' + (it.soldOut ? '<span class="sold">예약마감</span>' : '') + '</div></div><div class="price">' + it.price.toLocaleString('ko-KR') + '원~</div></div>').join('');
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

document.querySelectorAll(".flt-air").forEach(cb => {
    cb.addEventListener("change", () => {
        const chip = cb.closest(".chip");
        chip.classList.toggle("checked", cb.checked);
        state.filters.airlines = new Set(Array.from(document.querySelectorAll(".flt-air:checked")).map(i => i.value));
        renderList();
    });
});
const fltOnlyAvailable = document.getElementById("fltOnlyAvailable");
fltOnlyAvailable.addEventListener("change", e => {
    fltOnlyAvailable.closest(".chip").classList.toggle("checked", e.target.checked);
    state.filters.onlyAvailable = e.target.checked;
    renderList();
});
document.getElementById("sortBy").addEventListener("change", e => {
    state.sortBy = e.target.value;
    renderList();
});

// 카드 클릭 시 상세페이지로 이동
function renderList() {
    const list = document.getElementById("list");
    const label = document.getElementById("selectedDateLabel");

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

    list.innerHTML = ""; // 기존 내용 비우기
    items.forEach(it => {
        const el = renderScheduleItem(it);
        list.appendChild(el);
    });
}

function renderScheduleItem(it) {
    const div = document.createElement("div");
    div.className = "item";
    div.innerHTML = `
        <div>
            <h4>${it.title}</h4>
            <div class="meta">
                <span class="tag">${it.airline}</span>
                <span class="tag">${it.flightNo}</span>
                <span>${it.depart} → ${it.arrive}</span>
                <span>${it.nights}박 ${it.days}일</span>
                ${it.soldOut ? '<span class="sold">예약마감</span>' : ''}
            </div>
        </div>
        <div class="price">${it.price.toLocaleString('ko-KR')}원~</div>
    `;

    div.addEventListener("click", () => {
        if (it.soldOut) {
            alert("예약마감된 상품입니다.");
            return; // 페이지 이동 막기
        }

        // 예약 가능한 경우만 이동
        location.href = `detailPackage.jsp?pkg=${encodeURIComponent(it.packageId)}`;
    });

    return div;
}
