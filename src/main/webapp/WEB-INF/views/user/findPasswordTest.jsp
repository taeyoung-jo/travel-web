<%--
  Created by IntelliJ IDEA.
  User: wd
  Date: 2025-10-13
  Time: 오후 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>비밀번호 찾기</title></head>
<body>

<h2>비밀번호 찾기</h2>
<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="findPassword">
    <label>이메일: <input type="email" name="email"></label><br>
    <label>전화번호: <input type="text" name="phone"></label><br>
    <button type="submit">다음</button>
</form>
<hr>

<a href="${pageContext.request.contextPath}/users?action=loginForm">
    <button type="button">로그인</button>
</a>

</body>
</html>