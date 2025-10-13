<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">

<div class="mypage-wrapper in">
    <%@ include file="mypage_sidebar.jsp" %>

    <div class="mypage-content">
        <div class="content-head">
            <h2>비밀번호 변경</h2>
        </div>

        <div class="card pw-card outlined">
            <form id="pwForm" class="pw-form grid2" method="post" novalidate>
                <!-- 현재 비밀번호 -->
                <div class="row">
                    <label for="currPw">현재 비밀번호</label>
                    <div class="field">
                        <div class="input-group">
                            <input type="password" id="currPw" name="currPw" placeholder="현재 비밀번호를 입력하세요." required>
                            <span class="input-icon">🔒</span>
                            <div class="right-actions">
                                <button type="button" class="link-toggle" data-target="currPw">표시</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 새 비밀번호 -->
                <div class="row">
                    <label for="newPw">새로운 비밀번호</label>
                    <div class="field">
                        <div class="input-group">
                            <input type="password" id="newPw" name="newPw" placeholder="새로운 비밀번호를 입력하세요." required>
                            <span class="input-icon">ℹ️</span>
                            <div class="right-actions">
                                <button type="button" class="link-toggle" data-target="newPw">표시</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 새 비밀번호 확인 -->
                <div class="row">
                    <label for="newPw2">비밀번호 확인</label>
                    <div class="field">
                        <div class="input-group">
                            <input type="password" id="newPw2" name="newPw2" placeholder="확인을 위해 한 번 더 입력하세요." required>
                            <span class="input-icon">✔️</span>
                            <div class="right-actions">
                                <button type="button" class="link-toggle" data-target="newPw2">표시</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 안내문 -->
                <p class="hint">
                    * 영문(대/소문자), 숫자, 특수문자 중 2가지 이상을 조합하여 <b>최소 10자리 이상</b> 또는<br>
                    영문(대/소문자), 숫자, 특수문자 <b>3가지 조합 시 최소 8자리 이상</b>으로 사용하세요.
                </p>

                <!-- 버튼 -->
                <div class="btn-wrap">
                    <button type="submit" class="btn-primary">변경하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>

<script>
    // 메뉴 열고 닫기 + 서브 메뉴 active (이미 있으면 생략 가능)
    document.querySelectorAll(".menu-item").forEach(item=>{
        const title=item.querySelector(".menu-title");
        const submenu=item.querySelector(".submenu");
        if(title && submenu){
            title.addEventListener("click",()=>submenu.classList.toggle("open"));
            submenu.querySelectorAll("a").forEach(a=>{
                a.addEventListener("click",e=>{
                    submenu.querySelectorAll("a").forEach(x=>x.classList.remove("active"));
                    e.target.classList.add("active");
                });
            });
        }
    });

    // 비밀번호 표시/숨김
    document.querySelectorAll(".link-toggle").forEach(btn=>{
        btn.addEventListener("click",()=>{
            const id = btn.dataset.target;
            const ipt = document.getElementById(id);
            ipt.type = (ipt.type === "password") ? "text" : "password";
            btn.textContent = (ipt.type === "password") ? "표시" : "숨김";
        });
    });

    // 간단 유효성 검사
    const currPw = document.getElementById("currPw");
    const newPw  = document.getElementById("newPw");
    const newPw2 = document.getElementById("newPw2");
    document.getElementById("pwForm").addEventListener("submit",(e)=>{
        const c = currPw.value.trim();
        const n1 = newPw.value.trim();
        const n2 = newPw2.value.trim();
        const rule = /^(?=.*[A-Za-z])(?:(?=.*\d)(?=.*[^\w\s])|(?=.*\d)|(?=.*[^\w\s])).{8,}$/;

        if(!c || !n1 || !n2){ alert("모든 항목을 입력하세요."); e.preventDefault(); return; }
        if(n1.length < 8 || !rule.test(n1)){ alert("새 비밀번호 규칙을 확인하세요."); e.preventDefault(); return; }
        if(n1 !== n2){ alert("새 비밀번호와 확인 값이 일치하지 않습니다."); e.preventDefault(); }
    });
</script>
