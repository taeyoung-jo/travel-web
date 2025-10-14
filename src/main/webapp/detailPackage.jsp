
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
        <%--값 가져오기 테스트--%>
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
            <div class=""></div>
        </div>
    </section>

    <form action="pakage-reservConfirm.jsp" method="get">
        <input type="hidden" name="pkgId" value="<%= pkg.getId() %>">
        <button type="submit">예약하기</button>
    </form>
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
