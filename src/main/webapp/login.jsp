<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<link rel="stylesheet" href="css/login.css">

<div class="login-container">
    <div class="logo">
        <img src="images/logo_yellowballoon.png" alt="노랑풍선 로고">
        <h1>노랑풍선</h1>
    </div>

    <form action="login.do" method="post" class="login-form">
        <input type="text" name="userid" placeholder="이메일 주소 혹은 아이디" required>

        <div class="password-box">
            <input type="password" name="password" placeholder="비밀번호 확인" required>
            <button type="button" class="show-pw">비밀번호 표시</button>
        </div>

        <div class="save-id">
            <input type="checkbox" id="saveId">
            <label for="saveId">아이디 저장</label>
        </div>

        <button type="submit" class="login-btn">로그인</button>

        <div class="links">
            <a href="find_account.jsp">아이디/비밀번호 찾기</a>
            <span>|</span>
            <a href="signup.jsp">회원가입</a>
        </div>

        <div class="social-login">
            <button type="button" class="naver">N</button>
            <button type="button" class="kakao">K</button>
            <button type="button" class="apple"></button>
        </div>

        <p class="info-text">
            노랑풍선 회원으로 가입하시면 포인트적립(일부 상품 제외), 회원전용혜택 제공 등 더 많은 서비스를 이용하실 수 있습니다.
        </p>
    </form>

    <footer class="login-footer">
        <p>© Yellow Balloon tour. All Rights Reserved.</p>
    </footer>
</div>

<script>
    document.querySelector('.show-pw').addEventListener('click', function() {
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
