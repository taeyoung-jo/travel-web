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
<form action="/users" method="post">
    <input type="hidden" name="action" value="register">
    이메일: <input type="text" name="email"><br>
    이름: <input type="text" name="name"><br>
    비밀번호: <input type="password" name="password"><br>
    전화번호: <input type="text" name="phone"><br>
    <button type="submit">회원가입</button>
</form>

<a href="/users?action=loginForm">
    <button type="button">로그인</button>
</a>
</body>
</html>
