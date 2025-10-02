<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행사 달력 UI</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { display: flex; gap: 20px; }
        .calendar-container { width: 300px; }
        .schedule-container { flex: 1; }
        .filters { margin-bottom: 10px; }
        .filters label { margin-right: 10px; }
        .schedule-item { border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; border-radius: 6px; }
        .status { padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-right: 5px; }
        .예약가능 { background-color: #ffd966; color: #333; }
        .예약마감 { background-color: #ccc; color: #fff; }
        .출발확정 { background-color: #7cb342; color: #fff; }
    </style>
</head>
<body>

<h2>출발일 보기</h2>

<div class="container">
    <div class="calendar-container">
        <input type="text" id="calendar">
    </div>

    <div class="schedule-container">
        <div class="filters">
            <label><input type="checkbox" id="air_asiana" checked> 아시아나항공</label>
            <label><input type="checkbox" id="status_available" checked> 예약가능</label>
            <label><input type="checkbox" id="status_full" checked> 예약마감</label>
            <label><input type="checkbox" id="status_confirm" checked> 출발확정</label>
        </div>
        <div id="schedule-list">
            <!-- JSP에서 서버 데이터 초기 렌더링 -->
            <c:forEach var="s" items="${schedules}">
                <div class="schedule-item">
                    <span class="status ${s.status}">${s.status}</span> ${s.name} <br>
                    ✈ ${s.airline} / 💰 ${s.price}
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    // JSP에서 초기 데이터를 JS 변수로 변환
    const schedules = [
        <c:forEach var="s" items="${schedules}" varStatus="loop">
        {
            date: '${s.date}',
            name: '${s.name}',
            airline: '${s.airline}',
            status: '${s.status}',
            price: '${s.price}'
        }<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];

    const scheduleList = document.getElementById('schedule-list');

    function renderSchedules(selectedDate) {
        const airlineFilter = document.getElementById('air_asiana').checked ? '아시아나항공' : null;
        const statusAvailable = document.getElementById('status_available').checked;
        const statusFull = document.getElementById('status_full').checked;
        const statusConfirm = document.getElementById('status_confirm').checked;

        scheduleList.innerHTML = '';

        const filtered = schedules.filter(s => {
            const matchDate = selectedDate ? s.date === selectedDate : true;
            const matchAirline = airlineFilter ? s.airline === airlineFilter : true;
            const matchStatus = (statusAvailable && s.status==='예약가능') ||
                (statusFull && s.status==='예약마감') ||
                (statusConfirm && s.status==='출발확정');
            return matchDate && matchAirline && matchStatus;
        });

        if(filtered.length === 0) {
            scheduleList.innerHTML = '<p>선택한 날짜의 일정이 없습니다.</p>';
            return;
        }

        filtered.forEach(s => {
            const div = document.createElement('div');
            div.classList.add('schedule-item');
            div.innerHTML = `<span class="status ${s.status}">${s.status}</span> ${s.name} <br>
                       ✈ ${s.airline} / 💰 ${s.price}`;
            scheduleList.appendChild(div);
        });
    }

    flatpickr("#calendar", {
        inline: true,
        onChange: function(selectedDates, dateStr) {
            renderSchedules(dateStr);
        }
    });

    document.querySelectorAll('.filters input').forEach(input => {
        input.addEventListener('change', () => {
            const selectedDate = document.querySelector('#calendar').value;
            renderSchedules(selectedDate);
        });
    });

    renderSchedules();
</script>

</body>
</html>
