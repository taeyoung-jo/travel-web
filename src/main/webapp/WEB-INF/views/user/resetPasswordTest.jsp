<%--
  Created by IntelliJ IDEA.
  User: wd
  Date: 2025-10-13
  Time: 오후 12:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>비밀번호 재설정</title></head>
<body>

<h2>새 비밀번호 입력</h2>
<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="resetPassword">
    <input type="hidden" name="email" value="${email}">
    <input type="hidden" name="phone" value="${phone}">
    <label>새 비밀번호: <input type="password" name="newPassword"></label><br>
    <button type="submit">비밀번호 변경</button>
</form>
<hr>

<a href="${pageContext.request.contextPath}/users?action=loginForm">
    <button type="button">로그인</button>
</a>

</body>
</html>
