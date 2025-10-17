<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/css/login.css'/>">

<div class="login-container">
    <div class="logo">
        <a href="<c:url value='/index.jsp'/>">
            <img src="../image/logo_2.png" alt="여행가자 로고">
            <h1>여행가자</h1>
            <h3>로그인</h3>
        </a>
    </div>

    <%--    로그인--%>
    <form action="${pageContext.request.contextPath}/users?action=login" method="post" class="login-form">

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>

        <!-- 저장된 이메일 쿠키 값 바인딩 -->
        <input type="text" name="email" placeholder="이메일"
               value="${cookie.savedEmail.value}" required>

        <div class="password-box">
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="button" class="show-pw">비밀번호 표시</button>
        </div>

        <div class="save-id">
            <!-- 체크 상태 유지 및 서버로 값 전달 위해 name 추가 -->
            <input type="checkbox" id="saveId" name="saveId"
                ${cookie.savedEmail.value ne null ? 'checked' : ''}>
            <label for="saveId">아이디 저장</label>
        </div>

        <button type="submit" class="login-btn">로그인</button>

        <div class="links">
            <a href="../find_account.jsp">아이디/비밀번호 찾기</a>
            <span>|</span>
            <a href="signup.jsp">회원가입</a>
        </div>

        <div class="social-login">
            <button type="button" class="naver">N</button>
            <button type="button" class="kakao">K</button>
            <button type="button" class="apple"></button>
        </div>

        <p class="info-text">
            여행가자 회원으로 가입하시면 포인트적립(일부 상품 제외) <br>
            회원전용혜택 제공 등 더 많은 서비스를 이용하실 수 있습니다.
        </p>
    </form>

    <%--    푸터--%>
    <footer class="login-footer">
        <p>© Let's Go tour. All Rights Reserved.</p>
    </footer>
</div>

<script>
    document.querySelector('.show-pw').addEventListener('click', function () {
        const pwField = document.querySelector('input[name="password"]');
        if (pwField.type === 'password') {
            pwField.type = 'text';
            this.textContent = '숨기기';
        } else {
            pwField.type = 'password';
            this.textContent = '비밀번호 표시';
        }
    });
</script>
