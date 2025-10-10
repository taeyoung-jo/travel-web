<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="ko">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>노랑풍선</title>--%>
<%--    <style>--%>
<%--        body {--%>
<%--            margin: 0;--%>
<%--            font-family: 'Noto Sans KR', sans-serif;--%>
<%--            background: #fff;--%>
<%--            color: #333;--%>
<%--        }--%>
<%--        main {--%>
<%--            padding: 40px;--%>
<%--            text-align: center;--%>
<%--        }--%>
<%--        main h1 {--%>
<%--            font-size: 28px;--%>
<%--            color: #222;--%>
<%--        }--%>
<%--        main p {--%>
<%--            margin-top: 10px;--%>
<%--            font-size: 16px;--%>
<%--            color: #666;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>

<%--<body>--%>

<%--<!-- ✅ 헤더 include -->--%>
<%--<div id="header">--%>
<%--    <jsp:include page="header.jsp" />--%>
<%--</div>--%>

<%--<!-- ===== 본문 영역 ===== -->--%>
<%--<main>--%>
<%--    <h1>메인 콘텐츠 영역</h1>--%>
<%--    <p>이 영역에 여행 상품이나 메인 배너를 넣으시면 됩니다.</p>--%>
<%--</main>--%>

<%--<!-- ✅ 푸터 include -->--%>
<%--<div id="footer">--%>
<%--    <jsp:include page="footer.jsp" />--%>
<%--</div>--%>

<%--</body>--%>
<%--</html>--%>

<%--두번째--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행가자 메인</title>
    <style>
        body { margin:0; font-family:'Noto Sans KR', sans-serif; background:#fff; color:#333; }

        .menu-tabs {
            display:flex; border-bottom:1px solid #ddd; justify-content:center;
            background:#fff; font-weight:bold;
        }
        .menu-tabs div { padding:15px 30px; cursor:pointer; }
        .menu-tabs div:hover, .menu-tabs .active { color:#ffcc00; border-bottom:2px solid #ffcc00; }

        .hero { display:flex; justify-content:space-between; align-items:center;}
        .hero-text { max-width:50%; }
        .hero-text h1 { font-size:36px; margin:0 0 20px; line-height:1.3; }
        .hero-text h1 span { color:#ff9900; }
        .hero-form { display:flex; gap:10px; margin-top:20px; }
        .hero-form input, .hero-form select { padding:12px; border:1px solid #ccc; border-radius:4px; font-size:14px; }
        .hero-form button { background:#333; color:#fff; border:none; border-radius:4px; padding:12px 20px; cursor:pointer; }
        .hero-img img { width:350px; border-radius:20px; }

        .section { padding:40px 80px; }
        .section h2 { margin-bottom:15px; font-size:20px; }
        .categories { display:flex; gap:20px; overflow-x:auto; }
        .categories .cat { text-align:center; }
        .categories img { width:120px; height:120px; border-radius:60px; object-fit:cover; }

        .cards { display:flex; gap:20px; overflow-x:auto; }
        .card { width:260px; background:#fff; border:1px solid #eee; border-radius:8px; box-shadow:0 2px 4px rgba(0,0,0,0.1); overflow:hidden; }
        .card img { width:100%; height:160px; object-fit:cover; }
        .card .info { padding:15px; font-size:14px; }
        .card .info strong { color:#c00; font-size:13px; display:block; margin-bottom:8px; }
        .card .price { font-weight:bold; margin-top:10px; font-size:16px; }
    </style>
</head>
<body>

<!-- ✅ 헤더 include -->
<jsp:include page="header.jsp" />

<!-- ✅ 메인 콘텐츠 include -->
<jsp:include page="main.jsp" />

<!-- ✅ 푸터 include -->
<jsp:include page="footer.jsp" />

</body>
</html>


