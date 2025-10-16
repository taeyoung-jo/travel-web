
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/css/index.css'/>">

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행가자 메인</title>
</head>
<body>

<!-- ✅ 헤더 include -->
<jsp:include page="header.jsp" />

<!-- ✅ 메인 콘텐츠 include -->
<jsp:include page="main.jsp" />

<!-- ✅ 푸터 include -->
<jsp:include page="footer.jsp" />

</body>
</html>


