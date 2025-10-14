<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>

<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="login">
    이메일: <input type="text" name="email"><br>
    비밀번호: <input type="password" name="password"><br>
    <button type="submit">로그인</button>
</form>
<hr>

<a href="${pageContext.request.contextPath}/users?action=registerForm">
    <button type="button">회원가입</button>
</a>
<hr>

<a href="${pageContext.request.contextPath}/users?action=findIdForm">
    <button type="button">아이디 찾기</button>
</a>
<hr>

<a href="${pageContext.request.contextPath}/users?action=findPasswordForm">
    <button type="button">비밀번호 찾기</button>
</a>

</body>
</html>
