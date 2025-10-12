<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품상세 | 노랑풍선</title>
    <link rel="stylesheet" href="css/productDetail.css">
    <script src="js/productDetail.js" defer></script>
</head>
<body>

<jsp:include page="header.jsp" />

<!-- 상품 기본 정보 -->
<section class="product-header">
    <div class="breadcrumb">
        홈 > 해외패키지 > 일본 > 규슈
    </div>

    <div class="product-main">
        <div class="product-image">
            <img src="image/main_slide1.jpg" alt="상품 이미지">
        </div>

        <div class="product-summary">
            <h2>[나리타 출발] 도쿄 1일 #패키지투어 #요코하마</h2>
            <p class="tags">#요코하마 #패키지투어 #촬영명소</p>
            <div class="price-box">
                <p class="price">130,000원</p>
                <p class="sub">(5만원 입금 시 예약 확정)</p>
                <p class="point">적립금 2,000원</p>
            </div>
            <button class="book-btn">예약하기</button>
        </div>
    </div>
</section>

<!-- 옵션 선택 -->
<section class="product-options">
    <h3>인원 선택</h3>
    <div class="option-list">
        <div class="option-item">
            <span>성인</span>
            <div class="counter">
                <button class="minus">-</button>
                <input type="text" value="1">
                <button class="plus">+</button>
            </div>
            <p class="option-price">135,000원</p>
        </div>
        <div class="option-total">
            <span>총 금액</span>
            <strong id="totalPrice">135,000원</strong>
            <button class="book-btn">예약하기</button>
        </div>
    </div>
</section>

<!-- 탭 메뉴 -->
<section class="product-tabs">
    <div class="tab-menu">
        <button class="tab active" data-tab="schedule">상품상세정보</button>
        <button class="tab" data-tab="notice">예약/취소안내</button>
        <button class="tab" data-tab="review">후기(77)</button>
    </div>

    <div class="tab-content active" id="schedule">
        <h4>여행 주요 일정</h4>
        <table class="schedule-table">
            <tr>
                <th>일정</th>
                <td>2박 3일</td>
            </tr>
            <tr>
                <th>항공</th>
                <td>대한항공 / TW123</td>
            </tr>
            <tr>
                <th>여행코드</th>
                <td>JP-001</td>
            </tr>
            <tr>
                <th>방문도시</th>
                <td>도쿄 / 요코하마 / 오사카</td>
            </tr>
        </table>
    </div>

    <div class="tab-content" id="notice">
        <h4>예약/취소 안내</h4>
        <p>출발 7일 전까지 무료 취소 가능합니다.</p>
        <p>이후 취소 시 수수료가 발생할 수 있습니다.</p>
    </div>

    <div class="tab-content" id="review">
        <h4>상품 후기</h4>
        <div class="review">
            <p class="user">이*연</p>
            <p>가이드분이 너무 친절했어요!</p>
        </div>
        <div class="review">
            <p class="user">박*진</p>
            <p>일정이 빡빡하지만 알찬 여행이었어요.</p>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />

</body>
</html>
