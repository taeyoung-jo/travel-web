<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<link rel="stylesheet" href="css/calendar.css">

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>출발일 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<!-- body 안: 페이지 본문 -->
<div class="wrap">
    <h2 class="title">출발일 보기</h2>

    <div class="grid">
        <!-- 왼쪽: 달력 카드 -->
        <section class="card">
            <div class="body cal">
                <div class="cal-head">
                    <button id="prevMonth" class="nav-btn" type="button">‹</button>
                    <div class="ym"><span id="ymLabel">0000.00</span></div>
                    <button id="nextMonth" class="nav-btn" type="button">›</button>
                </div>

                <table class="calendar">
                    <thead>
                    <tr>
                        <th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
                    </tr>
                    </thead>
                    <tbody id="calBody"><!-- JS가 채움 --></tbody>
                </table>

                <div class="legend">
                    <span><i class="dot dot-ok"></i>예약가능</span>
                    <span><i class="dot dot-sold"></i>예약마감</span>
                </div>
            </div>
        </section>

        <!-- 오른쪽: 일정 선택 카드 -->
        <section class="card">
            <header>일정 선택</header>
            <div class="body">
                <!-- 필터 -->
                <div class="filters">
                    <label class="chip checked">
                        <input type="checkbox" class="flt-air" value="제주항공" checked> 제주항공
                    </label>
                    <label class="chip checked">
                        <input type="checkbox" class="flt-air" value="이스타항공" checked> 이스타항공
                    </label>
                    <label class="chip checked">
                        <input type="checkbox" class="flt-air" value="대한항공" checked> 대한항공
                    </label>
                    <label class="chip checked">
                        <input type="checkbox" class="flt-air" value="아시아나" checked> 아시아나
                    </label>
                    <label class="chip checked">
                        <input type="checkbox" id="fltOnlyAvailable" checked> 예약가능만
                    </label>

                    <select id="sortBy" class="select" style="margin-left:auto">
                        <option value="dateAsc" selected>출발 빠른순</option>
                        <option value="priceAsc">가격 낮은순</option>
                        <option value="priceDesc">가격 높은순</option>
                    </select>
                </div>

                <div class="muted" id="selectedDateLabel">날짜를 선택해주세요.</div>

                <!-- 일정 리스트 -->
                <div id="list" class="list"><!-- JS가 채움 --></div>
            </div>
        </section>
    </div>
</div>

<!-- body 끝나기 직전에: defer 로 반드시 늦게 로드 -->
<script src="js/calendar.js" defer></script>

</body>
</html>
