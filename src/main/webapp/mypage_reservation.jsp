<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ include file="header.jsp" %>

<link rel="stylesheet" href="css/mypage_reservation.css">

<div class="mypage-wrapper in">

    <!-- 🔸 좌측 메뉴 -->
    <aside class="mypage-sidebar">
        <h2>마이페이지</h2>
        <ul class="menu">
            <li class="menu-item">
                <div class="menu-title">예약 / 취소내역 ▾</div>
                <ul class="submenu open">
                    <li><a href="#">예약 내역</a></li>
                    <li><a href="#">취소 내역</a></li>
                    <li><a href="#">예약번호로 찾기</a></li>
                </ul>
            </li>
            <li class="menu-item">
                <div class="menu-title">관심상품 ▾</div>
                <ul class="submenu">
                    <li><a href="#">관심 여행지</a></li>
                    <li><a href="#">찜한 상품</a></li>
                    <li><a href="#">최근 본 상품</a></li>
                </ul>
            </li>
            <li class="menu-item">
                <div class="menu-title">개인정보 ▾</div>
                <ul class="submenu">
                    <li><a href="#">회원정보 수정</a></li>
                    <li><a href="#">비밀번호 변경</a></li>
                    <li><a href="#">회원 탈퇴</a></li>
                </ul>
            </li>
        </ul>
    </aside>

    <!-- 🔸 메인 콘텐츠 -->
    <!-- 🔸 메인 콘텐츠 -->
    <div class="mypage-content">
        <h2>예약/취소내역</h2>

        <!-- 상단 탭 -->
        <div class="tab-container">
            <button class="tab active" data-tab="package">패키지여행</button>
            <button class="tab" data-tab="free">자유여행</button>
        </div>

        <!-- 하위 탭 -->
        <div class="sub-tab-container">
            <button class="sub-tab active" data-subtab="reservation">예약내역</button>
            <button class="sub-tab" data-subtab="cancel">취소내역</button>
        </div>

        <!-- 검색 필터 -->
        <div class="search-box-wrap">
            <select class="period-select">
                <option>예약일</option>
            </select>
            <button class="period-btn">1개월</button>
            <button class="period-btn">3개월</button>
            <button class="period-btn active">전체</button>
            <input type="date"> ~ <input type="date">
            <button class="search-btn">검색</button>
            <%--            <p class="notice">· 도착일 기준 5년 전 예약 내역까지 확인 가능합니다.</p>--%>
        </div>

        <!-- 예약 내역 테이블 -->
        <table class="reservation-table">
            <thead>
            <tr>
                <th>예약번호</th>
                <th>예약일</th>
                <th>상품명</th>
                <th>출발일</th>
                <th>인원</th>
                <th>총금액</th>
                <th>남은금액</th>
                <th>진행상황</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="8" class="empty">예약하신 내역이 없습니다.</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="footer.jsp" %>


<script>
    // 메뉴 열고 닫기 + 서브 메뉴 active
    document.querySelectorAll(".menu-item").forEach(item => {
        const title = item.querySelector(".menu-title");
        const submenu = item.querySelector(".submenu");

        // 메뉴 토글
        title.addEventListener("click", () => {
            submenu.classList.toggle("open");
        });

        // 서브 메뉴 클릭 시 active
        submenu.querySelectorAll("a").forEach(link => {
            link.addEventListener("click", (e) => {
                // 같은 메뉴 안에서만 active 적용
                submenu.querySelectorAll("a").forEach(a => a.classList.remove("active"));
                e.target.classList.add("active");
            });
        });
    });
    // 서브메뉴 active
    document.querySelectorAll(".submenu a").forEach(link => {
        link.addEventListener("click", (e) => {
            document.querySelectorAll(".submenu a").forEach(a => a.classList.remove("active"));
            e.target.classList.add("active");
        });
    });

    // 상단 탭
    const tabs = document.querySelectorAll('.tab');
    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            tabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
        });
    });

    // 하위 탭
    const subTabs = document.querySelectorAll('.sub-tab');
    const tableBody = document.querySelector('.reservation-table tbody');

    subTabs.forEach(sub => {
        sub.addEventListener('click', () => {
            subTabs.forEach(s => s.classList.remove('active'));
            sub.classList.add('active');

            if (sub.dataset.subtab === 'reservation') {
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="8" class="empty">예약하신 내역이 없습니다.</td>
                    </tr>
                `;
            } else if (sub.dataset.subtab === 'cancel') {
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="8" class="empty">취소하신 내역이 없습니다.</td>
                    </tr>
                `;
            }
        });
    });

    // 기간 버튼
    const periodBtns = document.querySelectorAll('.period-btn');
    periodBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            periodBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        });
    });

    // 검색
    document.querySelector('.search-btn').addEventListener('click', () => {
        alert('검색되었습니다.');
    });
</script>
