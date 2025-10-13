<%--
  Created by IntelliJ IDEA.
  User: wd
  Date: 2025-10-13
  Time: 오후 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>아이디 찾기 결과</title></head>
<body>

<h2>찾은 아이디</h2>
<p>회원님의 이메일: <strong>${email}</strong></p>
<hr>

<a href="${pageContext.request.contextPath}/users?action=loginForm">
    <button type="button">로그인</button>
</a>

</body>
</html>
