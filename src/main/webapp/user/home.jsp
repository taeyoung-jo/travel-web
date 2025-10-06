<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<h1>Home : 로그인 성공 후 페이지</h1>
<h3>${loginUser.name}님, 반갑습니다.</h3>
<hr>
<form action="/users?action=logout" method="post">
    <button type="submit">로그아웃</button>
</form>

<a href="/users?action=myInfo">
    <button type="button">내 정보 조회</button>
</a>
</body>
</html>
