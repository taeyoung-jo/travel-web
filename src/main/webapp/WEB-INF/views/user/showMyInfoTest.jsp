<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>myInfo</title>
</head>
<body>
<h3>${loginUser.name}님, 반갑습니다.</h3>
<hr>

<h2>내 정보 조회</h2>
<p>DB_ID: ${loginUser.id}</p>
<p>Email: ${loginUser.email}</p>
<p>Name: ${loginUser.name}</p>
<p>Phone: ${loginUser.phone}</p>
<hr>

<form action="${pageContext.request.contextPath}/users?action=logout" method="post">
    <button type="submit">로그아웃</button>
</form>
<hr>

<h2>회원정보 수정</h2>
<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="updateUser">
    <label>이메일: <input type="text" name="email"></label><br>
    <label>이름: <input type="text" name="name"></label><br>
    <label>비밀번호: <input type="password" name="password"></label><br>
    <label>폰번호: <input type="text" name="phone"></label><br>
    <button type="submit">수정</button>
</form>
<hr>

<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="deleteUser">
    <button type="submit">회원탈퇴</button>
</form>
<hr>

<a href="${pageContext.request.contextPath}/home">
    <button type="button">홈으로</button>
</a>
</body>
</html>
