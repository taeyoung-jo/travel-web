<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="pack.*" %>
<%@ page import="java.util.*" %>
<%@ page import="pack.Package" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색결과 | 노랑풍선</title>
    <link rel="stylesheet" href="css/searchResult.css">
</head>
<body>

<%
    // 검색어와 정렬 옵션 가져오기
    String keyword = request.getParameter("q");
    String sortBy = request.getParameter("sort");
    if (keyword == null)
        keyword = "";
    keyword = keyword.trim();

    PackageService service = new PackageService();
    List<Package> searchResults = service.searchPackages(keyword, sortBy);

    // 필터링 파라미터
    String[] departures = request.getParameterValues("departure");
    String[] durations = request.getParameterValues("duration");
    String[] prices = request.getParameterValues("price");

    // 체크박스 필터 적용
    if (departures != null || durations != null || prices != null) {
        List<Package> filtered = new ArrayList<>();
        for (Package p : searchResults) {
            boolean ok = true;
            if (departures != null) {
                ok = Arrays.asList(departures).contains(p.getDeparture());
            }
            if (ok && durations != null) {
                String pkgName = p.getPackageName(); // 예: "도쿄 벚꽃 여행 3일"
                boolean match = false;
                for (String d : durations) {
                    if (d.equals("2~3일") && pkgName.matches(".*[2-3]일.*"))
                        match = true;
                    if (d.equals("4~6일") && pkgName.matches(".*[4-6]일.*"))
                        match = true;
                    if (d.equals("7일 이상") && pkgName.matches(".*[7-9][0-9]*일.*"))
                        match = true;
                }
                ok = match;
            }
            if (ok && prices != null) {
                boolean match = false;
                for (String pRange : prices) {
                    int priceVal = (int)p.getPrice();
                    if (pRange.equals("100만원 이하") && priceVal <= 1000000)
                        match = true;
                    if (pRange.equals("100~200만원") && priceVal > 1000000 && priceVal <= 2000000)
                        match = true;
                    if (pRange.equals("200만원 이상") && priceVal > 2000000)
                        match = true;
                }
                ok = match;
            }
            if (ok)
                filtered.add(p);
        }
        searchResults = filtered;
    }
%>

<div class="searchTop-wrap in">
    <div class="searchTop">
        <h3>검색결과</h3>
        <p>|</p>
        <h5>"<%= keyword %>"</h5>
        <p>총 <span><%= searchResults.size() %></span>개의 패키지</p>
    </div>
    <!-- 정렬 옵션 -->
    <div class="sort-options">
        <a href="?q=<%= keyword %>" <%= (sortBy == null || sortBy.isEmpty()) ? "class='active'" : "" %>>기본순</a> |
        <a href="?q=<%= keyword %>&sort=ratingDesc" <%= "ratingDesc".equals(sortBy) ? "class='active'" : "" %>>별점순</a> |
        <a href="?q=<%= keyword %>&sort=priceAsc" <%= "priceAsc".equals(sortBy) ? "class='active'" : "" %>>낮은가격순</a> |
        <a href="?q=<%= keyword %>&sort=priceDesc" <%= "priceDesc".equals(sortBy) ? "class='active'" : "" %>>높은가격순</a>
    </div>
</div>
<div class="result-container">


    <!-- 왼쪽 필터 -->
    <aside class="filter">
        <h3>필터</h3>
        <form method="get">
            <input type="hidden" name="q" value="<%= keyword %>">

            <div class="filter-section">
                <button type="button" class="filter-btn">출발지<img src="image/arrow-bottom.png" alt="arrow"></button>
                <ul class="filter-list <%= (departures != null) ? "show" : "" %>">
                    <li><label><input type="checkbox" name="departure" value="김포"
                        <%= (departures != null && Arrays.asList(departures).contains("김포")) ? "checked" : "" %>>
                        김포공항</label></li>
                    <li><label><input type="checkbox" name="departure" value="인천"
                        <%= (departures != null && Arrays.asList(departures).contains("인천")) ? "checked" : "" %>>
                        인천공항</label></li>
                </ul>
            </div>

            <div class="filter-section">
                <button type="button" class="filter-btn">여행기간<img src="image/arrow-bottom.png" alt="arrow"></button>
                <ul class="filter-list <%= (durations != null) ? "show" : "" %>">
                    <li><label><input type="checkbox" name="duration" value="2~3일"
                        <%= (durations != null && Arrays.asList(durations).contains("2~3일")) ? "checked" : "" %>>
                        2~3일</label></li>
                    <li><label><input type="checkbox" name="duration" value="4~6일"
                        <%= (durations != null && Arrays.asList(durations).contains("4~6일")) ? "checked" : "" %>>
                        4~6일</label></li>
                    <li><label><input type="checkbox" name="duration" value="7일 이상"
                        <%= (durations != null && Arrays.asList(durations).contains("7일 이상")) ? "checked" : "" %>> 7일 이상</label>
                    </li>
                </ul>
            </div>

            <div class="filter-section">
                <button type="button" class="filter-btn">상품가격<img src="image/arrow-bottom.png" alt="arrow"></button>
                <ul class="filter-list <%= (prices != null) ? "show" : "" %>">
                    <li><label><input type="checkbox" name="price" value="100만원 이하"
                        <%= (prices != null && Arrays.asList(prices).contains("100만원 이하")) ? "checked" : "" %>> 100만원 이하</label>
                    </li>
                    <li><label><input type="checkbox" name="price" value="100~200만원"
                        <%= (prices != null && Arrays.asList(prices).contains("100~200만원")) ? "checked" : "" %>>
                        100~200만원</label></li>
                    <li><label><input type="checkbox" name="price" value="200만원 이상"
                        <%= (prices != null && Arrays.asList(prices).contains("200만원 이상")) ? "checked" : "" %>> 200만원 이상</label>
                    </li>
                </ul>
            </div>

            <button type="submit" class="btn-primary"
                    style="margin-top:10px;width:100%;background:#f5c000;color:#111;border:none;border-radius:6px;padding:8px 0;cursor:pointer;">
                적용
            </button>
        </form>
    </aside>


    <!-- 오른쪽 상품 리스트 -->
    <section class="result-list">

        <%
            if (searchResults.isEmpty()) {
        %>
        <div class="no-search">검색 결과가 없습니다.</div>
        <%
        } else {
            for (Package pkg : searchResults) {
        %>
        <div class="product-card"
             data-pkg-id="<%= pkg.getId() %>"
             data-pkg-name="<%= pkg.getPackageName() %>">
            <div class="product-thumb">
                <img src="<%= request.getContextPath() + "/" + pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>">
            </div>
            <div class="product-info">
                <div class="pakage-top">
                    <p class="tag_rect pkg">해외패키지</p>
                    <p class="product-rating"><span>★</span> <%= pkg.getRating() %> / 5</p>
                </div>

                <h3 class="product-title"><%= pkg.getPackageName() %>
                </h3>
                <p class="product-path">패키지 ✈ <%= pkg.getDeparture() %> ➜ <%= pkg.getDestination() %>
                </p>
                <div class="product-price">
                    <p class="price"><%= String.format("%,d", (int)pkg.getPrice()) %>원~</p>
                    <button class="detail-btn" data-pkg-id="<%= pkg.getId() %>">
                        출발일 보기
                    </button>
                </div>
            </div>

        </div>
        <%
                }
            }
        %>
    </section>
</div>
<div id="modalOverlay" class="modal-overlay"></div>

<div id="calendarModal" class="calendar-modal">
    <button id="closeModal" class="close-btn">✖</button>
    <div id="calendarContainer">
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
                                <th>일</th>
                                <th>월</th>
                                <th>화</th>
                                <th>수</th>
                                <th>목</th>
                                <th>금</th>
                                <th>토</th>
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
    </div>
</div>
</body>
</html>

<%@ include file="footer.jsp" %>
<script src="js/searchResult.js"></script>
