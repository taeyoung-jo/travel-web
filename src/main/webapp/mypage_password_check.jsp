<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="css/mypage_password_check.css">

<div class="mypage-wrapper">
    <!-- 좌측 마이페이지 메뉴 -->
    <aside class="mypage-sidebar">
        <h3>마이페이지</h3>
        <ul>
            <li><a href="#">예약내역</a></li>
            <li><a href="#">관심상품</a></li>
            <li class="active"><a href="#">개인정보 수정</a></li>
            <li><a href="#">회원탈퇴</a></li>
        </ul>
    </aside>

    <!-- 메인 컨텐츠 -->
    <section class="mypage-content">
        <h2>비밀번호 인증</h2>
        <div class="password-box">
            <div class="lock-icon">🔒</div>
            <p class="desc">고객님의 소중한 정보를 보호하기 위해<br>비밀번호를 다시 확인합니다.</p>

            <form action="mypage_check.do" method="post" class="password-form">
                <div class="input-row">
                    <label>아이디</label>
                    <input type="text" name="userid" value="borisu@gmail.net" readonly>
                </div>

                <div class="input-row">
                    <label>비밀번호</label>
                    <input type="password" name="password" placeholder="비밀번호를 입력하세요.">
                    <a href="#" class="show-pw">비밀번호 표시</a>
                </div>

                <button type="submit" class="confirm-btn">확인</button>
            </form>
        </div>
    </section>
</div>

<%@ include file="footer.jsp" %>
