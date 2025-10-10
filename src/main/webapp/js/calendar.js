let departureDate = null;
let returnDate = null;
let selecting = "departure";

// 기준 월
let currentYear = new Date().getFullYear();
let currentMonth = new Date().getMonth() + 1;

function toggleCalendar() {
    const cal = document.getElementById("calendarPopup");
    cal.style.display = (cal.style.display === "none" || cal.style.display === "") ? "block" : "none";
    renderCalendars();
}

function changeMonth(offset) {
    currentMonth += offset;
    if (currentMonth > 12) { currentMonth = 1; currentYear++; }
    if (currentMonth < 1) { currentMonth = 12; currentYear--; }
    renderCalendars();
}

function renderCalendars() {
    const container = document.getElementById("calendarContainer");
    if (!container) return;
    container.innerHTML = "";

    for (let m = 0; m < 2; m++) {
        let year = currentYear;
        let month = currentMonth + m;
        if (month > 12) { month -= 12; year += 1; }

        const firstDay = new Date(year, month - 1, 1);
        const startDay = firstDay.getDay(); // 0=일
        const daysInMonth = new Date(year, month, 0).getDate();

        let table = "<table class='calendar'>";
        table += "<caption>" + year + "." + String(month).padStart(2, '0') + "</caption>";
        table += "<tr><th class='sunday'>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th class='saturday'>토</th></tr><tr>";

        for (let i = 0; i < startDay; i++) table += "<td></td>";

        for (let day = 1; day <= daysInMonth; day++) {
            const dow = (startDay + day - 1) % 7;
            const cls = (dow === 0 ? "sunday" : (dow === 6 ? "saturday" : ""));
            table += "<td class='" + cls + "' onclick='selectDate(" + year + "," + month + "," + day + ", this)'>" + day + "</td>";
            if (dow === 6 && day !== daysInMonth) table += "</tr><tr>";
        }

        table += "</tr></table>";
        container.innerHTML += table;
    }
}

function selectDate(year, month, day, cell) {
    const date = year + "-" + String(month).padStart(2, '0') + "-" + String(day).padStart(2, '0');
    if (selecting === "departure") {
        departureDate = date;
        document.getElementById("tripDate").value = "가는날: " + date;
        clearSelection();
        cell.classList.add("selected");
        selecting = "return";
    } else {
        returnDate = date;
        document.getElementById("tripDate").value += " / 오는날: " + date;
        cell.classList.add("selected");
        selecting = "departure";
    }
}

function clearSelection() {
    document.querySelectorAll(".calendar td").forEach(td => td.classList.remove("selected"));
}
