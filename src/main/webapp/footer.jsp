<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ===== 푸터 ===== -->
<style>
    .footer-menu {
        background: #f8f8f8;
        border-top: 1px solid #ddd;
        border-bottom: 1px solid #ddd;
        padding: 12px 40px;
        display: flex;
        gap: 20px;
        font-size: 14px;
    }
    .footer-menu a { text-decoration: none; color: #333; }
    .footer-menu a:hover { color: #ffcc00; }
    .footer-center {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        padding: 40px;
        border-bottom: 1px solid #eee;
    }
    .footer-center .info { max-width: 500px; }
    .footer-center .info h3 { font-size: 18px; margin-bottom: 10px; }
    .footer-center .info p { font-size: 14px; color: #555; margin: 4px 0; }
    .footer-center .contacts { display: flex; gap: 60px; }
    .footer-center .contact-item { text-align: center; }
    .footer-center .contact-item i { font-size: 24px; display: block; margin-bottom: 8px; }
    .footer-center .contact-item strong { display: block; font-size: 20px; margin-top: 5px; }
    .footer-center .contact-item span { font-size: 13px; color: #555; }
    .footer-center button {
        margin-top: 10px;
        padding: 6px 14px;
        border: 1px solid #333;
        background: #fff;
        cursor: pointer;
        border-radius: 4px;
    }
    .footer-bottom {
        text-align: center;
        padding: 15px;
        font-size: 13px;
        color: #777;
        background: #f8f8f8;
    }
</style>

<footer>
    <div class="footer-menu">
        <a href="#">고객센터</a>
        <a href="#">공지사항</a>
        <a href="#">자주하는질문</a>
        <a href="#">1:1문의</a>
        <a href="#">견적문의</a>
        <a href="#">여행후기</a>
        <a href="#">칭찬합시다</a>
        <a href="#">무이자할부</a>
        <a href="#">현금영수증</a>
    </div>

    <div class="footer-center">
        <div class="info">
            <h3>노랑풍선 고객센터</h3>
            <p>상담시간: 평일 오전 9시 ~ 오후 6시 (토,일요일 및 공휴일 휴무)</p>
            <p>· 해외항공권 변경, 투어&티켓, 렌터카 취소/변경/환불: 평일 오후 5시까지</p>
            <p>· 호텔 취소/변경/환불: 평일 오후 4시까지</p>
        </div>

        <div class="contacts">
            <div class="contact-item">
                <i>🧳</i>
                <span>패키지여행 상담</span>
                <strong>1544-2288</strong>
                <button>지역별 전용 상담번호 안내</button>
            </div>
            <div class="contact-item">
                <i>✈️</i>
                <span>자유여행 상담</span>
                <strong>1644-3399</strong>
            </div>
            <div class="contact-item">
                <i>💼</i>
                <span>부산/지방출발 상담</span>
                <strong>051-713-0710</strong>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        © 2025 노랑풍선. All Rights Reserved.
    </div>
</footer>
