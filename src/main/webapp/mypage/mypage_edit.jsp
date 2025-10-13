<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">

<div class="mypage-wrapper in">

    <%@ include file="mypage_sidebar.jsp" %>

    <!-- 🔸 메인 콘텐츠 -->
    <div class="mypage-content">
        <h2>회원정보 수정</h2>
        <p class="desc">고객님의 정보를 안전하게 관리하세요.</p>

        <form action="mypage_edit_action.jsp" method="post" class="edit-form">
            <div class="form-group">
                <label for="userName">이름</label>
                <div class="input-wrap"><input type="text" id="userName" name="userName" value="홍길동" required></div>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <div class="input-wrap"><input type="email" id="email" name="email" value="tyk0707@naver.com" autocomplete="off" required></div>
            </div>

            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <div class="input-wrap"><input type="text" id="phone" name="phone" value="010-1234-5678" inputmode="numeric" autocomplete="tel"></div>
            </div>

            <div class="form-group">
                <label for="birth">생년월일</label>
                <div class="input-wrap"><input type="date" id="birth" name="birth" value="1990-01-01"></div>
            </div>

            <div class="form-group">
                <label for="address">주소</label>
                <div class="input-wrap"><input type="text" id="address" name="address" placeholder="주소를 입력하세요" autocomplete="off"></div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">저장하기</button>
                <button type="reset" class="btn btn-secondary">취소</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../footer.jsp" %>

<script>
    // 사이드메뉴 화살표 회전용 클래스 토글
    document.querySelectorAll(".menu-item").forEach(item => {
        const t = item.querySelector(".menu-title");
        const s = item.querySelector(".submenu");
        t.addEventListener("click", () => { s.classList.toggle("open"); item.classList.toggle("open"); });
    });

    // 휴대폰 번호 자동 하이픈 (id="phone")
    (function(){
        const $phone = document.getElementById('phone');
        if(!$phone) return;
        $phone.setAttribute('inputmode','numeric');
        $phone.setAttribute('autocomplete','tel');
        $phone.addEventListener('input', e => {
            let v = e.target.value.replace(/[^0-9]/g,'').slice(0,11);
            if(v.length > 7)       v = v.replace(/(\d{3})(\d{4})(\d{0,4}).*/, '$1-$2-$3');
            else if(v.length > 3)  v = v.replace(/(\d{3})(\d{0,4}).*/, '$1-$2');
            e.target.value = v;
        });
    })();
</script>
