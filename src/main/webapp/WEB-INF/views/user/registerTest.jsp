<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>

<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="register">
    <label>이메일: <input type="text" name="email"></label><br>
    <label>이름: <input type="text" name="name"></label><br>
    <label>비밀번호: <input type="password" name="password"></label><br>
    <label>폰번호: <input type="text" name="phone"></label><br>
    <button type="submit">회원가입</button>
</form>
<hr>

<a href="${pageContext.request.contextPath}/users?action=loginForm">
    <button type="button">로그인</button>
</a>

</body>
</html>
