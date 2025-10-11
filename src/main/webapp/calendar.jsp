<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>출발일 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --bg:#fff; --text:#111; --muted:#6b7280; --brand:#FBBF24; /* 노랑풍선 노랑 */
            --border:#E5E7EB; --chip:#FFFBEB; --danger:#EF4444; --ok:#16A34A;
        }
        * { box-sizing: border-box; }
        body { margin:0; font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial; color:var(--text); background:var(--bg); }
        .wrap { max-width:1200px; margin:24px auto; padding:0 16px; }
        .title { font-size:20px; font-weight:700; margin:0 0 16px; }
        .grid { display:grid; grid-template-columns:360px 1fr; gap:20px; align-items:start; }
        .card { border:1px solid var(--border); border-radius:14px; background:#fff; overflow:hidden; box-shadow:0 2px 6px rgba(0,0,0,0.08); }
        .card:hover { box-shadow:0 4px 12px rgba(0,0,0,0.12); }
        .card header { padding:12px 14px; border-bottom:1px solid var(--border); font-weight:600; font-size:16px; }
        .card .body { padding:12px; }

        /* 달력 */
        .cal { width:100%; }
        .cal .cal-head { display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
        .cal .cal-head .ym { font-weight:700; font-size:16px; }
        .cal .nav-btn { border:1px solid var(--border); background:#fff; padding:6px 8px; border-radius:8px; cursor:pointer; transition:0.2s; }
        .cal .nav-btn:hover { background:#FEF3C7; border-color:#FBBF24; }
        .cal table { width:100%; border-collapse:collapse; table-layout:fixed; }
        .cal th { color:var(--muted); font-weight:600; padding:8px 0; }
        .cal td { height:52px; padding:0; text-align:right; vertical-align:top; border:1px solid var(--border); background:#fff; position:relative; cursor:pointer; transition:0.2s; border-radius:8px; }
        .cal td:hover { background:#FFFBEB; }
        .cal .day { position:absolute; top:6px; right:8px; font-size:12px; color:#374151; }
        .cal .price { position:absolute; left:8px; bottom:6px; font-size:11px; background:var(--chip); padding:2px 6px; border-radius:999px; color:#B45309; font-weight:600; }
        .cal td.is-other { background:#F9FAFB; color:#9CA3AF; }
        .cal td.is-today { background:#FFFBEB; border:2px solid #FBBF24; }
        .cal td.is-selected { background:#FEF3C7; border:2px solid #FBBF24; }

        /* 달력 legend */
        .legend { display:flex; gap:12px; font-size:12px; color:#374151; margin-top:8px; }
        .legend .dot { width:10px; height:10px; border-radius:999px; display:inline-block; vertical-align:-1px; margin-right:4px; }
        .dot-ok { background:var(--ok); }
        .dot-sold { background:var(--danger); }

        /* 필터 */
        .filters { display:flex; gap:10px; flex-wrap:wrap; align-items:center; margin-bottom:10px; }
        .chip { background:var(--chip); border:1px solid var(--border); padding:6px 12px; border-radius:999px; display:inline-flex; gap:6px; align-items:center; cursor:pointer; transition:0.2s; user-select:none; }
        .chip:hover { background:#FEF3C7; border-color:#FBBF24; }
        .chip input { display:none; }
        .chip.checked { background:#FBBF24; color:#fff; border-color:#FBBF24; }

        .select { padding:8px 10px; border:1px solid var(--border); border-radius:10px; background:#fff; }

        /* 일정 리스트 */
        .list { display:flex; flex-direction:column; gap:10px; margin-top:8px; }
        .item { border:1px solid var(--border); border-radius:14px; padding:14px; display:grid; grid-template-columns:1fr auto; gap:10px; box-shadow:0 2px 6px rgba(0,0,0,0.06); transition:0.2s; }
        .item:hover { box-shadow:0 4px 12px rgba(0,0,0,0.12); transform:translateY(-2px); }
        .item h4 { margin:0 0 6px; font-size:16px; font-weight:700; }
        .item .meta { display:flex; gap:8px; flex-wrap:wrap; color:#374151; font-size:13px; }
        .meta .tag { background:#FEF3C7; border:none; padding:2px 6px; border-radius:999px; color:#B45309; font-weight:600; }
        .price { font-weight:700; font-size:18px; color:#B45309; }
        .sold { color:var(--danger); font-weight:700; opacity:0.8; }

        /* 선택 안내 */
        .muted { color:var(--muted); font-size:12px; }
        .empty { text-align:center; color:var(--muted); padding:40px 0; border:1px dashed var(--border); border-radius:12px; background:#FFFBEB; }

        @media (max-width:980px){ .grid { grid-template-columns:1fr; } }
    </style>
</head>
<body>
<div class="wrap">
    <h1 class="title">출발일 보기</h1>
    <div class="grid">

        <!-- LEFT: Calendar -->
        <div class="card">
            <header>출발일 선택</header>
            <div class="body">
                <div class="cal">
                    <div class="cal-head">
                        <button class="nav-btn" id="prevMonth">&#9664;</button>
                        <div class="ym" id="ymLabel"></div>
                        <button class="nav-btn" id="nextMonth">&#9654;</button>
                    </div>
                    <table>
                        <thead>
                        <tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>
                        </thead>
                        <tbody id="calBody"></tbody>
                    </table>
                </div>
                <div class="legend">
                    <div><span class="dot dot-ok"></span>예약가능</div>
                    <div><span class="dot dot-sold"></span>예약마감</div>
                </div>
            </div>
        </div>

        <!-- RIGHT: Filters + List -->
        <div class="card">
            <header>일정 선택</header>
            <div class="body">
                <div class="toolbar">
                    <div class="filters">
                        <label class="chip"><input type="checkbox" class="flt-air" value="제주항공" checked>제주항공</label>
                        <label class="chip"><input type="checkbox" class="flt-air" value="이스타항공" checked>이스타항공</label>
                        <label class="chip"><input type="checkbox" class="flt-air" value="대한항공" checked>대한항공</label>
                        <label class="chip"><input type="checkbox" class="flt-air" value="아시아나" checked>아시아나</label>
                        <label class="chip"><input type="checkbox" id="fltOnlyAvailable" checked>예약가능만</label>
                    </div>
                    <div>
                        <select id="sortBy" class="select" aria-label="정렬">
                            <option value="dateAsc">출발일순</option>
                            <option value="priceAsc">낮은가격순</option>
                            <option value="priceDesc">높은가격순</option>
                        </select>
                    </div>
                </div>

                <div class="muted" id="selectedDateLabel">날짜를 선택해주세요.</div>
                <div class="list" id="list"></div>
            </div>
        </div>
    </div>
</div>

<script>
    // ------------------- 더미데이터 -------------------
    const DUMMY = (() => {
        const titles = ["오사카3일", "오사카&교토 2박3일", "단4석 출발확정 오사카3일"];
        const airlines = ["제주항공","이스타항공","대한항공","아시아나"];
        const data=[];
        const today=new Date();
        const addDays=(d,n)=>{ const x=new Date(d); x.setDate(x.getDate()+n); return x; };
        const pad=(n)=>n.toString().padStart(2,"0");
        const fmt=(d)=>d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate());

        for(let i=0;i<60;i++){
            const d=addDays(today,i);
            const cnt=Math.floor(Math.random()*3);
            for(let k=0;k<cnt;k++){
                const airline=airlines[Math.floor(Math.random()*airlines.length)];
                const price=599000+Math.floor(Math.random()*250000/1000)*1000;
                data.push({
                    id: fmt(d)+"-"+k,
                    packageId:"PKG-JP-OSK-3D2N",
                    title: titles[Math.floor(Math.random()*titles.length)],
                    date: fmt(d),
                    nights:2,
                    days:3,
                    airline,
                    flightNo: airline==="제주항공"?"7C"+(800+Math.floor(Math.random()*100)):
                        airline==="이스타항공"?"ZE"+(200+Math.floor(Math.random()*100)):
                            airline==="대한항공"?"KE"+(600+Math.floor(Math.random()*100)):"OZ"+(100+Math.floor(Math.random()*100)),
                    depart:"09:15",
                    arrive:"19:55",
                    price,
                    soldOut: Math.random()<0.22
                });
            }
        }
        return data;
    })();

    const state={ year:new Date().getFullYear(), month:new Date().getMonth(), selectedDate:null, monthData:DUMMY, filters:{airlines:new Set(["제주항공","이스타항공","대한항공","아시아나"]), onlyAvailable:true }, sortBy:"dateAsc" };

    const pad=(n)=>n.toString().padStart(2,"0");
    const ymd=(y,m,d)=>y+"-"+pad(m+1)+"-"+pad(d);

    const calBody=document.getElementById("calBody");
    const ymLabel=document.getElementById("ymLabel");

    function renderCalendar(){
        ymLabel.textContent=state.year+"."+pad(state.month+1);
        const first=new Date(state.year,state.month,1);
        const startIdx=first.getDay();
        const lastDay=new Date(state.year,state.month+1,0).getDate();
        const prevLast=new Date(state.year,state.month,0).getDate();
        const rows=[];
        let row=[];
        for(let i=0;i<startIdx;i++) row.push({y:state.month===0?state.year-1:state.year, m:(state.month+11)%12, d:prevLast-startIdx+1+i, other:true});
        for(let d=1;d<=lastDay;d++){
            row.push({y:state.year,m:state.month,d});
            if(row.length===7){ rows.push(row); row=[]; }
        }
        let add=1; while(row.length>0&&row.length<7){ row.push({y:state.month===11?state.year+1:state.year,m:(state.month+1)%12,d:add++,other:true}); }
        if(row.length) rows.push(row);

        calBody.innerHTML="";
        const byDate=new Map();
        state.monthData.forEach(it=>{ const e=byDate.get(it.date)||{min:Infinity,soldAll:true}; e.min=Math.min(e.min,it.price); e.soldAll=e.soldAll&&it.soldOut; byDate.set(it.date,e); });

        rows.forEach(r=>{
            const tr=document.createElement("tr");
            r.forEach(c=>{
                const td=document.createElement("td");
                if(c.other) td.classList.add("is-other");
                const dateStr=ymd(c.y,c.m,c.d);
                if(c.other===undefined&&dateStr===state.selectedDate) td.classList.add("is-selected");
                if(!c.other&&byDate.has(dateStr)){
                    const info=byDate.get(dateStr);
                    const priceDiv=document.createElement("div");
                    priceDiv.className="price";
                    priceDiv.textContent=info.min.toLocaleString('ko-KR')+"원~";
                    td.appendChild(priceDiv);
                    const dot=document.createElement("span");
                    dot.style.position="absolute"; dot.style.top="6px"; dot.style.left="8px"; dot.style.width="8px"; dot.style.height="8px";
                    dot.style.borderRadius="999px"; dot.style.background=info.soldAll?"var(--danger)":"var(--ok)";
                    td.appendChild(dot);
                }
                const dayEl=document.createElement("div");
                dayEl.className="day"; dayEl.textContent=c.d; td.appendChild(dayEl);
                td.addEventListener("click",()=>{ state.selectedDate=dateStr; renderCalendar(); renderList(); });
                tr.appendChild(td);
            });
            calBody.appendChild(tr);
        });
    }

    function applyFilters(items){
        let out=items.filter(x=>state.filters.airlines.has(x.airline));
        if(state.filters.onlyAvailable) out=out.filter(x=>!x.soldOut);
        switch(state.sortBy){
            case"priceAsc": out.sort((a,b)=>a.price-b.price); break;
            case"priceDesc": out.sort((a,b)=>b.price-a.price); break;
            case"dateAsc": default: out.sort((a,b)=>a.date.localeCompare(b.date)); break;
        }
        return out;
    }

    function renderList(){
        const list=document.getElementById("list");
        const label=document.getElementById("selectedDateLabel");
        if(!state.selectedDate){ label.textContent="날짜를 선택해주세요."; list.innerHTML='<div class="empty">왼쪽 달력에서 날짜 선택</div>'; return; }
        label.textContent="선택한 날짜: "+state.selectedDate;
        const dayItems=state.monthData.filter(x=>x.date===state.selectedDate);
        const items=applyFilters(dayItems);
        if(items.length===0){ list.innerHTML='<div class="empty">조건에 맞는 일정이 없습니다.</div>'; return; }
        list.innerHTML=items.map(it=>'<div class="item"><div><h4>'+it.title+'</h4><div class="meta"><span class="tag">'+it.airline+'</span><span class="tag">'+it.flightNo+'</span><span>'+it.depart+' → '+it.arrive+'</span><span>'+it.nights+'박 '+it.days+'일</span>'+(it.soldOut?'<span class="sold">예약마감</span>':'')+'</div></div><div class="price">'+it.price.toLocaleString('ko-KR')+'원~</div></div>').join('');
    }

    renderCalendar(); renderList();

    document.getElementById("prevMonth").addEventListener("click",()=>{ state.month--; if(state.month<0){ state.month=11; state.year--; } renderCalendar(); renderList(); });
    document.getElementById("nextMonth").addEventListener("click",()=>{ state.month++; if(state.month>11){ state.month=0; state.year++; } renderCalendar(); renderList(); });

    document.querySelectorAll(".flt-air").forEach(cb=>{
        cb.addEventListener("change",()=>{
            const chip=cb.closest(".chip");
            chip.classList.toggle("checked", cb.checked);
            state.filters.airlines=new Set(Array.from(document.querySelectorAll(".flt-air:checked")).map(i=>i.value)); renderList();
        });
    });
    const fltOnlyAvailable=document.getElementById("fltOnlyAvailable");
    fltOnlyAvailable.addEventListener("change",e=>{ fltOnlyAvailable.closest(".chip").classList.toggle("checked", e.target.checked); state.filters.onlyAvailable=e.target.checked; renderList(); });
    document.getElementById("sortBy").addEventListener("change",e=>{ state.sortBy=e.target.value; renderList(); });
</script>
</body>
</html>
