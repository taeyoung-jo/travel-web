
<%@ page import="pack.PackageService" %>
<%@ page import="pack.Package" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%
    PackageService service = new PackageService();
    Package pkg = null;
    String pkgIdStr = request.getParameter("pkg");
    if (pkgIdStr != null && !pkgIdStr.isEmpty()) {
        int pkgId = Integer.parseInt(pkgIdStr); // String → int
        pkg = service.getPackageById(pkgId);    // int 전달
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/detailPackage.css">
    <title></title>
</head>
<body>
<div class="in">
    <section class="package-data">
        <% if (pkg != null) { %>
        <div class="package-img">
            <img src="<%= pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>">
        </div>
        <div class="package-txt">
            <div class="data-top">
                <p class="pa-be">해외 패키지</p>
                <p class="pa-star"><span>★</span><%= pkg.getRating() %> / 5</p>
            </div>
            <h2><%= pkg.getPackageName() %>
            </h2>
            <h3>#<%= pkg.getPackageName() %>여행 #<%= pkg.getPackageName() %>관광지 #<%= pkg.getDestination() %> 투어
            </h3>
            <h5><%= pkg.getDeparture() %> ➜ <%= pkg.getDestination() %>
            </h5>
            <p>성인 1명</p>
            <div class="icon-price">
                <div class="icon">
                    <div class="wishlist-ic"><img src="/image/wishlist.png" alt="wish"></div>
                    <div class="share-ic"><img src="./image/share.png" alt="share"></div>
                </div>
                <p><%= String.format("%,.0f", pkg.getPrice()) %><span>원</span></p>
            </div>
            <div>
                <ul class="icon-wrap">
                    <li>
                        <span></span>
                        <span>7박 9일</span>
                    </li>
                    <li>
                        <span></span>
                        <span>에어프레미아</span>
                    </li>
                    <li>
                        <span></span>
                        <span>가이드포함</span>
                    </li>
                    <li>
                        <span></span>
                        <span>특별약관</span>
                    </li>
                    <li>
                        <span></span>
                        <span>싱글차지</span>
                    </li>
                </ul>
            </div>
        </div>
        <% } %>
        <%-- 예약 버튼 --%>
    </section>
    <section>
        <div class="package-riview">
            <span>★</span>
            <%= (pkg != null) ? pkg.getRating() : "패키지 상세" %>실제 여행객 13명의 리뷰 보기 <img src="./image/arrow.png" alt="">
            <div class="review-box">
                <div>
                    <p class="star-rr"><span>★★★★★</span>5</p>
                    <h4>일정이 알차고 가이드님이 친절해서 정말 즐거운 여행이었어요! 다음에도 꼭 이용하고 싶어요.</h4>
                    <div class="span-flex">
                        <p>김*수</p>
                        <p class="star-cal">2025-07-29</p></div>
                </div>
                <div>
                    <p class="star-rr"><span>★★★★★</span>5</p>
                    <h4>처음으로 패키지여행을 선택했는데 일정이 정말 체계적이었어요.
                        이동시간도 효율적으로 짜여 있어서 피로하지 않았고,
                        가이드님 설명이 재밌어서 여행 내내 웃으면서 다녔습니다.</h4>
                    <div class="span-flex">
                        <p>이*진</p>
                        <p class="star-cal">2025-06-01</p></div>
                </div>
                <div>
                    <p class="star-rr"><span>★★★★★</span>5</p>
                    <h4>가족끼리 다녀왔는데 모두 행복한 추억을 만들고 왔어요, 강력 추천합니다!</h4>
                    <div class="span-flex">
                        <p>천*준</p>
                        <p class="star-cal">2025-05-16</p></div>
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="detail-page">
            <div class="de-img"><img src="./image/detail_page.jpg" alt="detail"></div>
            <div class="de-side-ba">
                <div class="de-slide-1">
                    <div><p>출발</p>
                        <p>2025.10.19 (일) 12:20</p></div>
                    <div><p>도착</p>
                        <p>2025.10.27 (월) 14:40</p></div>
                    <div><p>교통</p>
                        <p>아시아나항공</p></div>
                </div>
                <div class="de-slide-2">
                    <div><p>인원수</p>
                        <div class="counter">
                            <button class="minus">-</button>
                            <span class="num" id="adultCount">0</span>
                            <button class="plus">+</button>
                        </div>
                    </div>
                </div>
                <div class="de-price"><%= String.format("%,.0f", pkg.getPrice()) %> <span>원</span></div>
                <div>
                    <form action="reservation_confirm.jsp" method="get">
                        <input type="hidden" name="pkgId" value="<%= pkg.getId() %>">
                        <button class="de-button" type="submit">예약하기</button>
                    </form>
                </div>
            </div>
        </div>
    </section>


</div>
<%--    &lt;%&ndash;값 가져오기 테스트&ndash;%&gt;--%>
<%--    <% if (pkg != null) { %>--%>
<%--    <h2><%= pkg.getPackageName() %>--%>
<%--    </h2>--%>
<%--    <p>출발지: <%= pkg.getDeparture() %>--%>
<%--    </p>--%>
<%--    <p>목적지: <%= pkg.getDestination() %>--%>
<%--    </p>--%>
<%--    <p>국가: <%= pkg.getCountry() %>--%>
<%--    </p>--%>
<%--    <p>가격: <%= String.format("%,.0f", pkg.getPrice()) %>원</p>--%>
<%--    <p>별점: <%= pkg.getRating() %> / 5</p>--%>
<%--    <img src="<%= pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>">--%>
<%--    <% } %>--%>
<%--    &lt;%&ndash; 예약 버튼 &ndash;%&gt;--%>
<%--    <form action="pakage-reservConfirm.jsp" method="get">--%>
<%--        <input type="hidden" name="pkgId" value="<%= pkg.getId() %>">--%>
<%--        <button type="submit">예약하기</button>--%>
<%--    </form>--%>
<%--<title><%= (pkg != null) ? pkg.getPackageName() : "패키지 상세" %>--%>
<%--</title>--%>
</body>
</html>

<%@ include file="footer.jsp" %>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        function setupCounter(id) {
            const container = document.getElementById(id);
            const minusBtn = container.parentElement.querySelector(".minus");
            const plusBtn = container.parentElement.querySelector(".plus");

            minusBtn.addEventListener("click", () => {
                let value = parseInt(container.textContent);
                if (value > 0) container.textContent = value - 1;
            });

            plusBtn.addEventListener("click", () => {
                let value = parseInt(container.textContent);
                container.textContent = value + 1;
            });
        }

        setupCounter("adultCount");
    });
</script>
