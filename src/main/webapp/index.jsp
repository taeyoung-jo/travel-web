<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>노랑풍선</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background: #fff;
            color: #333;
        }
        main {
            padding: 40px;
            text-align: center;
        }
        main h1 {
            font-size: 28px;
            color: #222;
        }
        main p {
            margin-top: 10px;
            font-size: 16px;
            color: #666;
        }
    </style>
</head>

<body>

<!-- ✅ 헤더 include -->
<div id="header">
    <jsp:include page="header.jsp" />
</div>

<!-- ===== 본문 영역 ===== -->
<main>
    <h1>메인 콘텐츠 영역</h1>
    <p>이 영역에 여행 상품이나 메인 배너를 넣으시면 됩니다.</p>
</main>

<!-- ✅ 푸터 include -->
<div id="footer">
    <jsp:include page="footer.jsp" />
</div>

</body>
</html>
