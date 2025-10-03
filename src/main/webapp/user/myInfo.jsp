<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>myInfo</title>
</head>
<body>
<h2>내 정보 조회</h2>
<p>DB_ID: ${loginUser.id}</p>
<p>Email: ${loginUser.email}</p>
<p>Name: ${loginUser.name}</p>
<p>Phone: ${loginUser.phone}</p>

<a href="/users?action=updateForm">회원정보 수정</a>
<hr>
<h2>회원정보 수정</h2>
<form action="/users" method="post">
    <input type="hidden" name="action" value="update">
    이메일: <input type="text" name="email"><br>
    이름: <input type="text" name="name"><br>
    비밀번호: <input type="password" name="password"><br>
    전화번호: <input type="text" name="phone"><br>
    <button type="submit">수정</button>
</form>
</body>
</html>
