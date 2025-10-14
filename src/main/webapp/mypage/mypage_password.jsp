<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경 | 마이페이지</title>

    <!-- 프로젝트 기준 경로에 맞게 조정하세요 -->
    <link rel="stylesheet" href="/css/mypage.css">

    <!-- 이 페이지 전용 추가 스타일(급하면 내부에 두고, 정리 시 CSS 파일로 옮기세요) -->
    <style>
        /* 페이지 폭 & 정렬 */
        .mypage-wrapper.in { max-width: 1200px; margin: 40px auto; padding: 0 16px; }

        /* 상단 타이틀 */
        .content-head { border-bottom: 3px solid #111; margin-bottom: 24px; }
        .content-head h2 { font-size: 28px; font-weight: 700; margin: 0 0 16px; }

        /* 카드(폼) */
        .card { background:#fff; border:1px solid #e5e5e5; border-radius: 8px; }
        .card.outlined { border-color:#e5e5e5; }
        .pw-card { padding: 28px; }

        /* 2열 폼 그리드 */
        .grid2 { display:grid; grid-template-columns: 220px 1fr; gap: 16px 20px; align-items: center; }

        /* 라벨 */
        .pw-form .row > label { font-size:15px; color:#222; }

        /* 입력 그룹 */
        .input-group { display:flex; align-items:center; gap:10px; }
        .input-group input[type="password"],
        .input-group input[type="text"]{
            width:100%; height:40px; padding:0 12px;
            border:1px solid #d9d9d9; border-radius:6px; font-size:14px;
        }
        .input-group input:focus{ outline:none; border-color:#111; }

        /* 우측 작은 액션(비번 표시 토글) */
        .right-actions { display:flex; gap:6px; }
        .link-toggle{
            height:40px; padding:0 12px; border:1px solid #d9d9d9;
            background:#f8f8f8; border-radius:6px; font-size:13px; cursor:pointer;
        }

        /* 안내문 */
        .hint-rules { grid-column: 2 / 3; color:#e53935; line-height:1.6; font-size:13px; margin-top:4px; }

        /* 하단 버튼 */
        .actions { grid-column: 2 / 3; margin-top:10px; }
        .btn-primary{
            display:inline-block; min-width:180px; height:48px; padding:0 24px;
            border:none; border-radius:8px; font-size:16px; font-weight:700; cursor:pointer;
            background:#f5a700; color:#111;
        }
        .btn-primary:disabled{ opacity:.5; cursor:not-allowed; }

        /* 반응형 */
        @media (max-width: 900px){
            .grid2 { grid-template-columns: 1fr; }
            .hint-rules, .actions { grid-column: 1 / -1; }
        }
    </style>
</head>
<body>

<div class="mypage-wrapper in">

    <%-- 사이드바 --%>
    <%@ include file="mypage_sidebar.jsp" %>

    <%-- 컨텐츠 --%>
    <div class="mypage-content" style="flex:1;">
        <div class="content-head">
            <h2>비밀번호 변경</h2>
        </div>

        <div class="card pw-card outlined">
            <form class="pw-form grid2" method="post" action="/mypage/password" novalidate>
                <%-- 현재 비밀번호 --%>
                <div class="row"><label for="currPw">현재 비밀번호</label></div>
                <div class="field">
                    <div class="input-group">
                        <input type="password" id="currPw" name="currPw" placeholder="현재 비밀번호를 입력하세요." required>
                        <div class="right-actions">
                            <button type="button" class="link-toggle" data-target="currPw">비밀번호 표시</button>
                        </div>
                    </div>
                </div>

                <%-- 새 비밀번호 --%>
                <div class="row"><label for="newPw">새로운 비밀번호</label></div>
                <div class="field">
                    <div class="input-group">
                        <input type="password" id="newPw" name="newPw" placeholder="새로운 비밀번호를 입력하세요." required>
                        <div class="right-actions">
                            <button type="button" class="link-toggle" data-target="newPw">표시</button>
                        </div>
                    </div>
                </div>

                <%-- 새 비밀번호 확인 --%>
                <div class="row"><label for="newPw2">비밀번호 확인</label></div>
                <div class="field">
                    <div class="input-group">
                        <input type="password" id="newPw2" name="newPw2" placeholder="확인을 위해 한 번 더 입력하세요." required>
                        <div class="right-actions">
                            <button type="button" class="link-toggle" data-target="newPw2">표시</button>
                        </div>
                    </div>
                </div>

                <%-- 규칙 안내 --%>
                <p class="hint-rules">
                    * 영문(대/소문자), 숫자, 특수문자 중 2가지 이상을 조합하여 최소 10자리 이상
                    또는 영문(대/소문자), 숫자, 특수문자 중 3가지 이상을 조합하여 최소 8자리 이상으로 사용하실 수 있습니다.
                </p>

                <%-- 제출 버튼 --%>
                <div class="actions">
                    <button type="submit" class="btn-primary" id="submitBtn" disabled>변경하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    (function(){
        // 비밀번호 표시 토글
        document.querySelectorAll('.link-toggle').forEach(function(btn){
            btn.addEventListener('click', function(){
                var id = this.getAttribute('data-target');
                var input = document.getElementById(id);
                if(!input) return;
                var isPw = input.type === 'password';
                input.type = isPw ? 'text' : 'password';
                this.textContent = isPw ? '숨기기' : '표시';
                input.focus();
            });
        });

        // 간단한 유효성 검사 & 버튼 활성화
        const curr = document.getElementById('currPw');
        const n1   = document.getElementById('newPw');
        const n2   = document.getElementById('newPw2');
        const sbm  = document.getElementById('submitBtn');

        function strongEnough(pw){
            if(!pw) return false;
            const has2of3 =
                (/[A-Za-z]/.test(pw) && /\d/.test(pw)) ||
                (/[A-Za-z]/.test(pw) && /[^A-Za-z0-9]/.test(pw)) ||
                (/\d/.test(pw) && /[^A-Za-z0-9]/.test(pw));
            return (pw.length >= 10 && has2of3) || (pw.length >= 8 &&
                /[A-Z]/.test(pw) && /[a-z]/.test(pw) && (/\d/.test(pw) || /[^A-Za-z0-9]/.test(pw)));
        }

        function validate(){
            const ok = curr.value.length > 0 && strongEnough(n1.value) && n1.value === n2.value;
            sbm.disabled = !ok;
        }

        [curr, n1, n2].forEach(el => el.addEventListener('input', validate));
        validate();

        // 실제 제출 전 최종 체크 (백엔드 검증은 별도 수행)
        document.querySelector('.pw-form').addEventListener('submit', function(e){
            if(n1.value !== n2.value){
                e.preventDefault();
                alert('새 비밀번호와 확인이 일치하지 않습니다.');
                n2.focus();
            }
        });
    })();
</script>
</body>
</html>
