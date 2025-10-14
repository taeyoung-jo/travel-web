<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
<%--         pageEncoding="UTF-8" isELIgnored="false" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="ko">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>여행사 달력 UI</title>--%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">--%>
<%--    <style>--%>
<%--        body { font-family: Arial, sans-serif; margin: 20px; }--%>
<%--        .container { display: flex; gap: 20px; }--%>
<%--        .calendar-container { width: 300px; }--%>
<%--        .schedule-container { flex: 1; }--%>
<%--        .filters { margin-bottom: 10px; }--%>
<%--        .filters label { margin-right: 10px; }--%>
<%--        .schedule-item { border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; border-radius: 6px; }--%>
<%--        .status { padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-right: 5px; }--%>
<%--        .예약가능 { background-color: #ffd966; color: #333; }--%>
<%--        .예약마감 { background-color: #ccc; color: #fff; }--%>
<%--        .출발확정 { background-color: #7cb342; color: #fff; }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>

<%--<h2>출발일 보기</h2>--%>

<%--<div class="container">--%>
<%--    <div class="calendar-container">--%>
<%--        <input type="text" id="calendar">--%>
<%--    </div>--%>

<%--    <div class="schedule-container">--%>
<%--        <div class="filters">--%>
<%--            <label><input type="checkbox" id="air_asiana" checked> 아시아나항공</label>--%>
<%--            <label><input type="checkbox" id="status_available" checked> 예약가능</label>--%>
<%--            <label><input type="checkbox" id="status_full" checked> 예약마감</label>--%>
<%--            <label><input type="checkbox" id="status_confirm" checked> 출발확정</label>--%>
<%--        </div>--%>
<%--        <div id="schedule-list">--%>
<%--            <!-- JSP에서 서버 데이터 초기 렌더링 -->--%>
<%--            <c:forEach var="s" items="${schedules}">--%>
<%--                <div class="schedule-item">--%>
<%--                    <span class="status ${s.status}">${s.status}</span> ${s.name} <br>--%>
<%--                    ✈ ${s.airline} / 💰 ${s.price}--%>
<%--                </div>--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>--%>
<%--<script>--%>
<%--    // JSP에서 초기 데이터를 JS 변수로 변환--%>
<%--    const schedules = [--%>
<%--        <c:forEach var="s" items="${schedules}" varStatus="loop">--%>
<%--        {--%>
<%--            date: '${s.date}',--%>
<%--            name: '${s.name}',--%>
<%--            airline: '${s.airline}',--%>
<%--            status: '${s.status}',--%>
<%--            price: '${s.price}'--%>
<%--        }<c:if test="${!loop.last}">,</c:if>--%>
<%--        </c:forEach>--%>
<%--    ];--%>

<%--    const scheduleList = document.getElementById('schedule-list');--%>

<%--    function renderSchedules(selectedDate) {--%>
<%--        const airlineFilter = document.getElementById('air_asiana').checked ? '아시아나항공' : null;--%>
<%--        const statusAvailable = document.getElementById('status_available').checked;--%>
<%--        const statusFull = document.getElementById('status_full').checked;--%>
<%--        const statusConfirm = document.getElementById('status_confirm').checked;--%>

<%--        scheduleList.innerHTML = '';--%>

<%--        const filtered = schedules.filter(s => {--%>
<%--            const matchDate = selectedDate ? s.date === selectedDate : true;--%>
<%--            const matchAirline = airlineFilter ? s.airline === airlineFilter : true;--%>
<%--            const matchStatus = (statusAvailable && s.status==='예약가능') ||--%>
<%--                (statusFull && s.status==='예약마감') ||--%>
<%--                (statusConfirm && s.status==='출발확정');--%>
<%--            return matchDate && matchAirline && matchStatus;--%>
<%--        });--%>

<%--        if(filtered.length === 0) {--%>
<%--            scheduleList.innerHTML = '<p>선택한 날짜의 일정이 없습니다.</p>';--%>
<%--            return;--%>
<%--        }--%>

<%--        filtered.forEach(s => {--%>
<%--            const div = document.createElement('div');--%>
<%--            div.classList.add('schedule-item');--%>
<%--            div.innerHTML = `<span class="status ${s.status}">${s.status}</span> ${s.name} <br>--%>
<%--                       ✈ ${s.airline} / 💰 ${s.price}`;--%>
<%--            scheduleList.appendChild(div);--%>
<%--        });--%>
<%--    }--%>

<%--    flatpickr("#calendar", {--%>
<%--        inline: true,--%>
<%--        onChange: function(selectedDates, dateStr) {--%>
<%--            renderSchedules(dateStr);--%>
<%--        }--%>
<%--    });--%>

<%--    document.querySelectorAll('.filters input').forEach(input => {--%>
<%--        input.addEventListener('change', () => {--%>
<%--            const selectedDate = document.querySelector('#calendar').value;--%>
<%--            renderSchedules(selectedDate);--%>
<%--        });--%>
<%--    });--%>

<%--    renderSchedules();--%>
<%--</script>--%>

<%--</body>--%>
<%--</html>--%>


<%--두번째--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 예약</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f5f5; margin:0; }
        .search-bar { display:flex; gap:10px; background:#fff; padding:15px; margin:20px auto; width:90%; max-width:1000px; box-shadow:0 2px 6px rgba(0,0,0,0.15); }
        input, select { padding:8px 12px; border:1px solid #ccc; border-radius:4px; }
        .calendar-btn { cursor:pointer; border:1px solid #ccc; padding:8px 12px; border-radius:4px; background:#fff; }
        .search-btn { background:#ffcc00; border:none; padding:10px 20px; border-radius:4px; cursor:pointer; font-weight:bold; }
        .calendar-popup { display:none; background:#fff; padding:20px; box-shadow:0 2px 8px rgba(0,0,0,0.2); border-radius:4px; width:90%; max-width:700px; margin:0 auto; }
        .calendar-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; }
        .calendar-container { display:flex; gap:30px; justify-content:center; }
        .calendar { border-collapse:collapse; width:320px; }
        .calendar caption { font-size:18px; font-weight:bold; padding:10px 0; }
        .calendar th, .calendar td { border:1px solid #eee; text-align:center; height:50px; cursor:pointer; }
        .calendar th { background:#fafafa; }
        .sunday { color:red; }
        .saturday { color:blue; }
        .selected { background:#ffcc00; font-weight:bold; }
        .nav-btn { cursor:pointer; font-size:20px; padding:0 10px; user-select:none; }
    </style>
    <script>
        let departureDate = null;
        let returnDate = null;
        let selecting = "departure";

        // 기준 월
        let currentYear = 2025;
        let currentMonth = 10;

        function toggleCalendar() {
            let cal = document.getElementById("calendarPopup");
            cal.style.display = (cal.style.display === "none" || cal.style.display === "") ? "block" : "none";
            renderCalendars();
        }

        function changeMonth(offset) {
            currentMonth += offset;
            if(currentMonth > 12) { currentMonth = 1; currentYear++; }
            if(currentMonth < 1) { currentMonth = 12; currentYear--; }
            renderCalendars();
        }

        function renderCalendars() {
            let container = document.getElementById("calendarContainer");
            container.innerHTML = "";

            for(let m=0; m<2; m++) {
                let year = currentYear;
                let month = currentMonth + m;
                if(month > 12) { month -= 12; year += 1; }

                let firstDay = new Date(year, month-1, 1);
                let startDay = firstDay.getDay(); // 0=일
                let daysInMonth = new Date(year, month, 0).getDate();

                let table = "<table class='calendar'>";
                table += "<caption>" + year + "." + String(month).padStart(2,'0') + "</caption>";
                table += "<tr><th class='sunday'>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th class='saturday'>토</th></tr><tr>";

                for(let i=0; i<startDay; i++) table += "<td></td>";

                for(let day=1; day<=daysInMonth; day++) {
                    let dow = (startDay + day - 1) % 7;
                    let cls = (dow==0?"sunday":(dow==6?"saturday":""));
                    table += "<td class='"+cls+"' onclick='selectDate("+year+","+month+","+day+", this)'>"+day+"</td>";
                    if(dow==6 && day!=daysInMonth) table += "</tr><tr>";
                }
                table += "</tr></table>";
                container.innerHTML += table;
            }
        }

        function selectDate(year, month, day, cell) {
            let date = year + "-" + String(month).padStart(2,'0') + "-" + String(day).padStart(2,'0');
            if(selecting === "departure") {
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
    </script>
</head>
<body>

<div class="search-bar">
    <select><option>왕복</option><option>편도</option></select>
    <input type="text" placeholder="출발지" value="인천/김포">
    <input type="text" placeholder="도착지">
    <div class="calendar-btn" onclick="toggleCalendar()" id="tripDate">여행일정</div>
    <select><option>성인 1명</option><option>성인 2명</option></select>
    <button class="search-btn">검색</button>
</div>

<div id="calendarPopup" class="calendar-popup">
    <div class="calendar-header">
        <span class="nav-btn" onclick="changeMonth(-1)">&#9664;</span>
        <div style="flex:1;text-align:center;">달력</div>
        <span class="nav-btn" onclick="changeMonth(1)">&#9654;</span>
    </div>
    <div id="calendarContainer" class="calendar-container"></div>
</div>

</body>
</html>
