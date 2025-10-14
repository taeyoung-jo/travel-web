<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pack.PackageService" %>
<%@ page import="pack.Package" %>
<%@ include file="header.jsp" %>

<%
    PackageService service = new PackageService();
    Package pkg = null;
    String pkgIdStr = request.getParameter("pkgId");

    if (pkgIdStr != null && pkgIdStr.matches("\\d+")) { // 숫자 체크
        int pkgId = Integer.parseInt(pkgIdStr);
        pkg = service.getPackageById(pkgId);
    }
%>

<html>
<head>
    <title><%= (pkg != null) ? pkg.getPackageName() : "패키지 상세" %>
    </title>
</head>
<body>
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
<% } else { %>
<p>패키지를 찾을 수 없습니다.</p>
<% } %>
</body>
</html>
<%@ include file="footer.jsp" %>
