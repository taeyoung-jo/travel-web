<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<link rel="stylesheet" href="css/mypage_find-reserv.css">

<div class="mypage-wrapper in">
    <!-- 🔸 좌측 메뉴 -->
    <aside class="mypage-sidebar">
		<h2>마이페이지</h2>
		<ul class="menu">
			<li class="menu-item">
				<div class="menu-title">예약 / 취소내역 ▾</div>
				<ul class="submenu open">
					<li><a href="mypage_reservation.jsp" >예약/ 취소내역</a></li>
					<li><a href="mypage_find-reserv.jsp" class="active">예약번호로 찾기</a></li>
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
        <h2>예약번호로 찾기</h2>

        <!-- 예약 내역 테이블 -->
		<table class="reservation-search-table" border="1" cellpadding="8" cellspacing="0">
			<tbody>
			<tr>
				<td>이름</td>
				<td>홍길동</td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>2000.00.00</td>
			</tr>
			<tr>
				<td>예약번호</td>
				<td>
					<input type="text" name="reservationNo" placeholder="예)R20251012001">
				</td>
			</tr>
			</tbody>
		</table>
		<button type="submit" class="find-btn">검색하기</button>
	</div>
</div>

<%@ include file="footer.jsp" %>

<script>
    // ---------------- 메뉴 열고 닫기 + 서브 메뉴 active ----------------
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

    // ---------------- 더미 데이터 ----------------
    const reservationData = [
        { id: "R20251012001", orderDate: "2025-10-05", name: "오사카 3일 자유여행", departDate: "2025-11-05", people: 2, totalPrice: 1298000, status: "예약완료" },
        { id: "R20250815001", orderDate: "2025-08-10", name: "도쿄 디즈니랜드 4일", departDate: "2025-09-20", people: 3, totalPrice: 2100000, status: "결제대기" },
        { id: "R20250720002", orderDate: "2025-07-18", name: "후쿠오카 자유여행 3일", departDate: "2025-08-05", people: 1, totalPrice: 980000, status: "예약완료" },
        { id: "R20250515001", orderDate: "2025-05-15", name: "제주도 힐링투어", departDate: "2025-06-01", people: 2, totalPrice: 750000, status: "여행완료" }
    ];

    // ---------------- 검색 버튼 ----------------
    const searchBtn = document.querySelector('.find-btn');
    const reservationInput = document.querySelector('input[name="reservationNo"]');

    searchBtn.addEventListener('click', () => {
        const inputVal = reservationInput.value.trim();
        let tableHTML = '';

        if (inputVal === '') {
            tableHTML = '<tr><td colspan="7" class="empty">예약번호를 입력하세요.</td></tr>';
        } else {
            const result = reservationData.filter(r => r.id === inputVal);

            if (result.length === 0) {
                tableHTML = '<tr><td colspan="7" class="empty">예약내역을 찾을 수 없습니다.</td></tr>';
            } else {
                tableHTML = result.map(r =>
                    '<tr>' +
                    '<td>' + r.id + '</td>' +
                    '<td>' + r.orderDate + '</td>' +
                    '<td>' + r.name + '</td>' +
                    '<td>' + r.departDate + '</td>' +
                    '<td>' + r.people + '명</td>' +
                    '<td>' + r.totalPrice.toLocaleString() + '원</td>' +
                    '<td>' + r.status + '</td>' +
                    '</tr>'
                ).join('');
            }
        }

        // 기존 테이블이 이미 있으면 tbody 갱신, 없으면 새로 생성
        let resultTable = document.querySelector('.reservation-search-result-table');
        if (!resultTable) {
            resultTable = document.createElement('table');
            resultTable.classList.add('reservation-search-result-table');
            resultTable.style.width = '100%';
            resultTable.style.borderCollapse = 'collapse';
            resultTable.innerHTML = `
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
                <tbody></tbody>
            `;
            document.querySelector('.mypage-content').appendChild(resultTable);
        }

        resultTable.querySelector('tbody').innerHTML = tableHTML;
    });


</script>
