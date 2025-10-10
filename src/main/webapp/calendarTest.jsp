<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 예약</title>
    <link rel="stylesheet" href="css/calendar.css">
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
