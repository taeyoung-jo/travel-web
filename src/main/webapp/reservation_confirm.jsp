<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="../css/reservation_confirm.css" />

<%@ include file="header.jsp" %>

<div class="reservation-page">
    <h2>예약하기</h2>

    <!-- 안내문 -->
    <div class="info-box">
        <p>홈페이지를 통한 예약은 확정이 아닌 접수 상태이며, 담당자 확인 후 최종 요금 및 예약 확정이 진행됩니다.</p>
        <p>예약금은 담당자 안내 후 결제하셔야 하며, 지정 시간 내 미입금 시 예약이 임의 취소될 수 있습니다.</p>
        <p>항공권 또는 항공권이 포함된 상품의 경우, 유류할증료 포함 금액이며 유가 및 환율 변동 시 변경될 수 있습니다.</p>
        <p>아동/유아 기준은 항공사마다 상이하므로 예약 후 최종 확정됩니다.</p>
    </div>

    <div class="reservation-layout">

        <!-- 상품 정보 -->
        <div class="product-info">
            <h3>상품 정보</h3>
            <table>
                <tr>
                    <th>상품명</th>
                    <td colspan="3">동유럽 3국 9일 #부다페스트 #프라하 #빈 #특식7회</td>
                </tr>
                <tr>
                    <th>예약유형</th>
                    <td>일반예약(1명 가능)</td>
                    <th>예약금</th>
                    <td>인당 400,000원</td>
                </tr>
                <tr>
                    <th>이용 교통</th>
                    <td><img src="../image/airline.png" alt="항공사" style="width:18px;vertical-align:middle;"> 대한항공</td>
                    <th>여행 기간</th>
                    <td>7박 9일</td>
                </tr>
                <tr>
                    <th>일정</th>
                    <td colspan="3">
                        <p>KE937 한국출발 2025.10.26 (일) 11:55 → 현지도착 16:55</p>
                        <p>KE938 현지출발 2025.11.02 (일) 19:15 → 한국도착 2025.11.03 (월) 14:15</p>
                    </td>
                </tr>
            </table>

            <!-- ✅ 예약자 정보 -->
            <div class="product-info">
                <h3>예약자 정보</h3>

                <form class="resv-form" method="post" action="reservation_complete.jsp">
                    <table>
                        <tr>
                            <th><span class="req">*</span> 이름</th>
                            <td>
                                <input type="text" name="name" placeholder="이름을 입력하세요" required>
                            </td>
                            <th><span class="req">*</span> 생년월일</th>
                            <td>
                                <input type="text" name="birth" placeholder="YYYY.MM.DD" required>
                            </td>
                        </tr>

                        <tr>
                            <th><span class="req">*</span> 성별</th>
                            <td colspan="3" class="gender-cell">
                                <label><input type="radio" name="gender" value="M" required> 남</label>
                                <label><input type="radio" name="gender" value="F"> 여</label>
                            </td>
                        </tr>

                        <tr>
                            <th>전화번호</th>
                            <td colspan="3">
                                <input type="text" name="phone" placeholder="예) 01012345678" required>
                            </td>
                        </tr>
                    </table>

                    <ul class="form-notice">
                        <li>상품 예약 관련 이메일/SMS는 수신 동의 여부와 관계없이 자동 발송됩니다.</li>
                        <li>정확한 예약자 정보를 입력해 주세요.</li>
                        <li>외국 국적자의 경우 여행자 보험 가입을 위해 등록번호가 필요합니다.</li>
                    </ul>

                    <button type="submit" class="btn-primary">예약하기</button>
                </form>
            </div>
        </div>

        <aside class="right-summary">
            <table>
                <tr><td>출발</td><td>2025.10.26 (일) 11:55</td></tr>
                <tr><td>도착</td><td>2025.11.03 (월) 14:15</td></tr>
                <tr>
                    <td>교통</td>
                    <td>대한항공 <img src="../image/airline.png" alt="항공사"></td>
                </tr>
                <tr><td>남은좌석</td><td>1석</td></tr>
                <tr><td>성인 × 1명</td><td>3,090,000원</td></tr>
                <tr><td>아동 × 0명</td><td>3,090,000원</td></tr>
                <tr><td>유아 × 0명</td><td>540,200원</td></tr>
                <tr><td>할인쿠폰</td><td>쿠폰 적용</td></tr>
                <tr><td>쿠폰할인</td><td>-0원</td></tr>
            </table>

            <div class="total-section">
                <div class="total-price">
                    3,090,000 <small>원</small>
                </div>
            </div>

            <div class="point-info">
                (성인1인기준) 30,900 P 적립예정<br>
                <a href="#">포인트 적립 안내</a>
            </div>

            <button class="btn-primary">예약하기</button>
        </aside>

    </div>
</div>

<%@ include file="footer.jsp" %>
