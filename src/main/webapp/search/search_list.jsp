<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctx = request.getContextPath(); // 정적 리소스/링크에 사용
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>검색결과 - 여행가자</title>

    <!-- 필요 시 공용 CSS 유지 (없으면 제거해도 됨) -->
    <link rel="stylesheet" href="<%=ctx%>/css/header.css">
    <link rel="stylesheet" href="<%=ctx%>/css/searchResult.css">

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        /* --- 페이지 보조 스타일(필요 시만 유지) --- */
        :root{--muted:#6b7280;--border:#e5e7eb}
        *{box-sizing:border-box}
        body{margin:0;font-family:'Noto Sans KR',system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial}
        .in{max-width:1200px;margin:0 auto;padding:0 16px}

        /* 헤더(최상단 미니 영역—GNB 없음) */
        .header-top{display:flex;justify-content:flex-end;gap:12px;padding:10px 0}
        .header-top a{display:inline-flex;align-items:center;gap:6px;font-size:13px;color:#374151;text-decoration:none}
        .header-top img{width:18px;height:18px}

        /* 검색영역/본문 */
        .srch-wrap{margin:12px auto 64px}
        .srch-head{display:flex;align-items:end;justify-content:space-between;gap:16px;margin:8px 0 24px}
        .srch-title{font-size:22px;margin:0}
        .srch-title .muted{color:var(--muted);font-weight:600}
        .srch-sub{margin:4px 0 0;color:var(--muted)}
        .srch-grid{display:grid;grid-template-columns:280px 1fr;gap:24px}

        /* 좌측 필터 */
        .srch-filter{border:1px solid var(--border);border-radius:12px;padding:16px;background:#fff}
        .chip-group{display:flex;flex-wrap:wrap;gap:8px;margin:0;padding:0;border:0}
        .chip{border:1px solid var(--border);border-radius:999px;padding:8px 12px;background:#fff;cursor:pointer}
        .chip.ghost{background:#fafafa}

        /* 우측 카드 리스트 */
        .srch-results{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:16px}
        .pkg-card{border:1px solid #eee;border-radius:14px;overflow:hidden;background:#fff;display:flex;flex-direction:column}
        .pkg-card a{color:inherit;text-decoration:none}
        .pkg-thumb{aspect-ratio:4/3;object-fit:cover;background:#f6f7f9;width:100%}
        .pkg-body{padding:14px;display:flex;flex-direction:column;gap:6px}
        .pkg-name{font-size:16px;font-weight:700;line-height:1.35;margin:0}
        .pkg-meta{color:var(--muted);font-size:13px}
        .pkg-price{margin-top:6px;font-size:18px;font-weight:800}
        .no-result{grid-column:1/-1;text-align:center;color:#9ca3af;padding:48px 0;border:1px dashed var(--border);border-radius:12px}

        /* 반응형 */
        @media (max-width: 960px){
            .srch-grid{grid-template-columns:1fr}
            .srch-results{grid-template-columns:repeat(2,minmax(0,1fr))}
        }
        @media (max-width: 640px){
            .srch-results{grid-template-columns:1fr}
            .srch-head{flex-direction:column;align-items:flex-start}
        }
    </style>
</head>
<body>
<div class="in">

    <!-- (GNB 없음) 상단 미니유틸만 사용 -->
    <div class="header-top">
        <a href="<%=ctx%>/mypage/mypage_recent.jsp">
            <img src="<%=ctx%>/image/time.png" alt="">최근 본 내역
        </a>
        <a href="<%=ctx%>/mypage/mypage_wish.jsp">
            <img src="<%=ctx%>/image/wishlist.png" alt="">찜한 내역
        </a>
    </div>

    <!-- ===== 본문 ===== -->
    <main class="srch-wrap">
        <div class="srch-head">
            <h1 class="srch-title">
                검색결과 <span class="muted">${fn:escapeXml(param.q)}</span>
            </h1>
            <p class="srch-sub">관련 상품 총 <span class="muted"><fmt:formatNumber value="${totalCount}" /></span>개</p>
        </div>

        <div class="srch-grid">
            <!-- 좌측: 필터(예시) -->
            <aside class="srch-filter">
                <form id="filterForm" method="get" action="">
                    <input type="hidden" name="q" value="${param.q}">
                    <fieldset class="chip-group">
                        <button type="button" class="chip ghost" id="compareBtn">선택상품 비교</button>
                        <button type="button" class="chip ghost" id="clearSelBtn">선택 해제</button>
                    </fieldset>
                    <!-- 필요 시 가격/일수 등 필터 추가 -->
                </form>
            </aside>

            <!-- 우측: 결과 카드 -->
            <section class="srch-results">
                <c:if test="${empty packageList}">
                    <div class="no-result">검색 결과가 없습니다.</div>
                </c:if>

                <c:forEach var="pkg" items="${packageList}">
                    <article class="pkg-card">
                        <a href="<%=ctx%>/package/detail.jsp?id=${pkg.packageId}">
                            <img class="pkg-thumb"
                                 src="<c:out value='${empty pkg.imageUrl ? ctx += "/image/placeholder.jpg" : pkg.imageUrl}'/>"
                                 alt="${fn:escapeXml(pkg.packageName)}" />
                            <div class="pkg-body">
                                <h3 class="pkg-name">${pkg.packageName}</h3>
                                <div class="pkg-meta">${pkg.departure} → ${pkg.destination}</div>
                                <div class="pkg-meta">${pkg.departureDate} · ${pkg.days}일</div>
                                <div class="pkg-price">
                                    <fmt:formatNumber value="${pkg.price}" pattern="#,###" />원
                                </div>
                            </div>
                        </a>
                    </article>
                </c:forEach>
            </section>
        </div>
    </main>
</div>

<script>
    /* 비교/선택 해제 버튼 예시 (원하면 제거) */
    document.getElementById('clearSelBtn')?.addEventListener('click', ()=> {
        // 여기에 선택 초기화 로직
        alert('선택이 해제되었습니다.');
    });
</script>
</body>
</html>
