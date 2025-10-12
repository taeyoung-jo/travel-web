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
					<li><a href="mypage_reservation.jsp" class="active">예약/ 취소내역</a></li>
					<li><a href="mypage_find-reserv.jsp">예약번호로 찾기</a></li>
				</ul>
			</li>
			<li class="menu-item">
				<div class="menu-title">관심상품 ▾</div>
				<ul class="submenu">
					<li><a href="#">찜한 상품</a></li>
					<li><a href="#">최근 본 상품</a></li>
				</ul>
			</li> <li class="menu-item">
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
    <div class="mypage-content">
        <h2>예약/취소내역</h2>

        <!-- 하위 탭 -->
        <div class="tab-container">
            <button class="tab active" data-subtab="reservation">예약내역</button>
            <button class="tab" data-subtab="cancel">취소내역</button>
        </div>

        <!-- 검색 필터 -->
        <div class="search-box-wrap">
            <button class="period-btn active" data-period="1">1개월</button>
            <button class="period-btn" data-period="3">3개월</button>
            <button class="period-btn" data-period="6">6개월</button>
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
                <th>진행상황</th>
            </tr>
            </thead>
            <tbody>
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

        title.addEventListener("click", () => {
            submenu.classList.toggle("open");
        });

        submenu.querySelectorAll("a").forEach(link => {
            link.addEventListener("click", (e) => {
                submenu.querySelectorAll("a").forEach(a => a.classList.remove("active"));
                e.target.classList.add("active");
            });
        });
    });

    // ---------------- 더미데이터 ----------------
    const reservationData = [
        { id: "R20251012001", orderDate: "2025-10-05", name: "오사카 3일 자유여행", departDate: "2025-11-05", people: 2, totalPrice: 1298000, status: "예약완료" },
        { id: "R20250815001", orderDate: "2025-08-10", name: "도쿄 디즈니랜드 4일", departDate: "2025-09-20", people: 3, totalPrice: 2100000, status: "결제대기" },
        { id: "R20250720002", orderDate: "2025-07-18", name: "후쿠오카 자유여행 3일", departDate: "2025-08-05", people: 1, totalPrice: 980000, status: "예약완료" },
        { id: "R20250515001", orderDate: "2025-05-15", name: "제주도 힐링투어", departDate: "2025-06-01", people: 2, totalPrice: 750000, status: "여행완료" }
    ];

    const cancelData = [
        { id: "C20250910001", cancelDate: "2025-09-05", name: "오키나와 3일 패키지", departDate: "2025-09-20", people: 2, refund: 450000, status: "취소완료" }
    ];

    const tableBody = document.querySelector('.reservation-table tbody');
    const tableHead = document.querySelector('.reservation-table thead tr');
    const subTabs = document.querySelectorAll('.tab');
    const periodBtns = document.querySelectorAll('.period-btn');

    let activeTab = 'reservation'; // 현재 활성 탭

    // ---------------- 테이블 렌더링 ----------------
    function renderTable(type, periodMonths = null) {
        let data;

        if (type === 'reservation') {
            data = reservationData;

            if (periodMonths) {
                const today = new Date();
                const past = new Date();
                past.setMonth(today.getMonth() - periodMonths);

                data = data.filter(r => {
                    const orderDate = new Date(r.orderDate);
                    return orderDate >= past && orderDate <= today;
                });
            }

            tableHead.innerHTML = `
                <th>예약번호</th>
                <th>예약일</th>
                <th>상품명</th>
                <th>출발일</th>
                <th>인원</th>
                <th>총금액</th>
                <th>진행상황</th>
            `;

            if (data.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="7" class="empty">예약하신 내역이 없습니다.</td></tr>';
                return;
            }

            tableBody.innerHTML = data.map(r =>
                '<tr>' +
                '<td>' + (r.id || '-') + '</td>' +
                '<td>' + (r.orderDate || '-') + '</td>' +
                '<td>' + (r.name || '-') + '</td>' +
                '<td>' + (r.departDate || '-') + '</td>' +
                '<td>' + (r.people || 0) + '명</td>' +
                '<td>' + ((r.totalPrice || 0).toLocaleString()) + '원</td>' +
                '<td>' + (r.status || '-') + '</td>' +
                '</tr>'
            ).join('');

        } else if (type === 'cancel') {
            data = cancelData;

            tableHead.innerHTML = `
                <th>취소번호</th>
                <th>취소일</th>
                <th>상품명</th>
                <th>출발일</th>
                <th>인원</th>
                <th>환불금액</th>
                <th>상태</th>
            `;

            if (data.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="7" class="empty">취소하신 내역이 없습니다.</td></tr>';
                return;
            }

            tableBody.innerHTML = data.map(c =>
                '<tr>' +
                '<td>' + (c.id || '-') + '</td>' +
                '<td>' + (c.cancelDate || '-') + '</td>' +
                '<td>' + (c.name || '-') + '</td>' +
                '<td>' + (c.departDate || '-') + '</td>' +
                '<td>' + (c.people || 0) + '명</td>' +
                '<td>' + ((c.refund || 0).toLocaleString()) + '원</td>' +
                '<td>' + (c.status || '-') + '</td>' +
                '</tr>'
            ).join('');
        }
    }

    subTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            subTabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            activeTab = tab.dataset.subtab;

            if (activeTab === 'reservation') {
                // 예약내역 탭 클릭 시 1개월 내역만 표시
                renderTable('reservation', 1);

                // 기간 버튼도 1개월로 active
                periodBtns.forEach(b => b.classList.remove('active'));
                document.querySelector('.period-btn[data-period="1"]').classList.add('active');
                activePeriod = 1;
            } else {
                renderTable('cancel');
            }
        });
    });

    // ---------------- 기간 버튼 ----------------
    periodBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            periodBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            if (activeTab === 'reservation') {
                const months = parseInt(btn.dataset.period);
                renderTable('reservation', months);
            }
        });
    });

    // ---------------- 페이지 초기화 ----------------
    function initializePage() {
        // 기본 탭: 예약내역
        activeTab = 'reservation';
        subTabs.forEach(t => t.classList.remove('active'));
        document.querySelector(`.tab[data-subtab="reservation"]`).classList.add('active');
		
        // 기간 버튼 기본: 1개월
        periodBtns.forEach(b => b.classList.remove('active'));
        document.querySelector('.period-btn[data-period="1"]').classList.add('active');

        // 테이블 렌더링
        renderTable('reservation', 1);
    }

    // 초기화 실행
    initializePage();
</script>
