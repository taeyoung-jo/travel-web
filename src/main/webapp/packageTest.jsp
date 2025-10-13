<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="pack.PackageRepository" %>
<%@ page import="pack.Package" %>

<html>
<head>
    <title>패키지 더미데이터 테스트</title>
    <style>
        table {
            width: 90%;
            border-collapse: collapse;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #aaa;
            padding: 8px 12px;
            text-align: center;
        }

        img {
            width: 120px;
            height: 80px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">패키지 더미데이터 테스트</h2>

<%
    PackageRepository dao = new PackageRepository();
    List<Package> packages = dao.getAllPackages();
%>

<table>
    <tr>
        <th>ID</th>
        <th>패키지명</th>
        <th>출발지</th>
        <th>도착지</th>
        <th>출발일</th>
        <th>일수</th>
        <th>가격</th>
        <th>이미지</th>
    </tr>

    <% for (Package pkg : packages) { %>
    <tr>
        <td><%= pkg.getPackageId() %>
        </td>
        <td><%= pkg.getPackageName() %>
        </td>
        <td><%= pkg.getDeparture() %>
        </td>
        <td><%= pkg.getDestination() %>
        </td>
        <td><%= pkg.getDepartureDate() %>
        </td>
        <td><%= pkg.getDays() %>
        </td>
        <td><%= pkg.getPrice() %>
        </td>
        <td>
            <% if (pkg.getImageUrl() != null && !pkg.getImageUrl().isEmpty()) { %>
            <img src="<%= pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>">
            <% } else { %>
            이미지 없음
            <% } %>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>
