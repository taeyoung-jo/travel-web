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
    <title><%= (pkg != null) ? pkg.getPackageName() : "패키지 상세" %>
    </title>
</head>
<body>
<%--값 가져오기 테스트--%>
<% if (pkg != null) { %>
<h2><%= pkg.getPackageName() %>
</h2>
<p>출발지: <%= pkg.getDeparture() %>
</p>
<p>목적지: <%= pkg.getDestination() %>
</p>
<p>국가: <%= pkg.getCountry() %>
</p>
<p>가격: <%= String.format("%,.0f", pkg.getPrice()) %>원</p>
<p>별점: <%= pkg.getRating() %> / 5</p>
<img src="<%= pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>">
<% } %>
</body>
</html>

<%@ include file="footer.jsp" %>
