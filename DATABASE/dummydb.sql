-- 예약 --
CREATE TABLE reservations
(
    id          VARCHAR(20) PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    order_date  DATE         NOT NULL,
    depart_date DATE         NOT NULL,
    people      INT          NOT NULL,
    total_price INT          NOT NULL,
    status      VARCHAR(20)  NOT NULL
);

INSERT INTO reservations (id, name, order_date, depart_date, people, total_price, status)
VALUES ('R20251012001', '오사카 3일 자유여행', '2025-10-05', '2025-11-05', 2, 1298000, '예약완료'),
       ('R20250815001', '도쿄 디즈니랜드 4일', '2025-08-10', '2025-09-20', 3, 2100000, '결제대기'),
       ('R20250720002', '후쿠오카 자유여행 3일', '2025-07-18', '2025-08-05', 1, 980000, '예약완료'),
       ('R20250915002', '교토 2일 자유여행', '2025-06-15', '2025-10-20', 2, 680000, '예약완료'),
       ('R20251001003', '삿포로 스키 여행 3일', '2025-05-01', '2025-12-05', 4, 3200000, '결제대기');

-- 예약 취소 --
INSERT INTO reservations (id, name, order_date, depart_date, people, total_price, status)
VALUES ('C20250910001', '오키나와 3일 패키지', '2025-09-05', '2025-09-20', 2, 450000, '취소완료');

-------------------------
-- 마이페이지 예약 확인 --
CREATE TABLE reservation
(
    id            VARCHAR(20) PRIMARY KEY,
    name          VARCHAR(200) NOT NULL, -- 상품명
    order_date    DATETIME     NOT NULL, -- 예약일 (시각 포함)
    depart_date   DATE         NOT NULL, -- 출발일
    people        INT          NOT NULL, -- 인원수
    total_price   INT          NOT NULL, -- 총금액
    status        VARCHAR(20)  NOT NULL, -- 예약상태
    customer_name VARCHAR(50),           -- 예약자명
    type          VARCHAR(20),           -- 예약유형
    deposit_info  VARCHAR(50),           -- 예약금 정보
    transport     VARCHAR(50),           -- 이용교통
    period VARCHAR (50)                  -- 여행기간 (예: 7박 9일)
);

INSERT INTO reservation
(id, name, order_date, depart_date, people, total_price, status, customer_name, type, deposit_info, transport, period)
VALUES ('RB2025092411234',
        '이탈리아 일주 9일 TW #낭만이 가득한 이탈리아 #친체레레 #피사 #남부 #베로나 #10대특식 #바티칸 #전일정4성호텔',
        '2025-09-24 17:33:00',
        '2025-11-19',
        2,
        7210000, -- 예시 금액 (7박9일 기준)
        '예약완료',
        '김혜민',
        '일반예약',
        '별도안내',
        '대한항공',
        '7박 9일');


-------------------------
-- 패키지 --
CREATE TABLE package
(
    package_id  INT PRIMARY KEY,
    name        VARCHAR(100)  NOT NULL,
    depart      VARCHAR(50)   NOT NULL,
    destination VARCHAR(50)   NOT NULL,
    country     VARCHAR(50)   NOT NULL,
    price       INT           NOT NULL,
    days        DECIMAL(3, 1) NOT NULL, -- 예: 3.0, 4.0
    image_url   VARCHAR(200)  NOT NULL
);

INSERT INTO package (package_id, name, depart, destination, country, price, days, image_url)
VALUES (1, '도쿄 벚꽃 여행 3일', '김포', '도쿄', '일본', 890000, 3.0, 'image/package/tokyo.jpg'),
       (2, '오사카 맛집 탐방 4일', '인천', '오사카', '일본', 950000, 4.0, 'image/package/osaka.jpg'),
       (3, '방콕 힐링 여행 5일', '김포', '방콕', '태국', 1150000, 5.0, 'image/package/bangkok.jpg'),
       (4, '다낭 가족 여행 4일', '인천', '다낭', '베트남', 1050000, 4.0, 'image/package/danang.jpg'),
       (5, '타이베이 미식 여행 3일', '김포', '타이베이', '대만', 870000, 3.0, 'image/package/taipei.jpg'),
       (6, '상하이 도심 투어 4일', '인천', '상하이', '중국', 990000, 4.0, 'image/package/sanghai.jpg'),
       (7, '싱가포르 야경 여행 5일', '인천', '싱가포르', '싱가포르', 1190000, 5.0, 'image/package/singapore.jpg'),

       (8, '파리 낭만 여행 7일', '김포', '파리', '프랑스', 2890000, 7.0, 'image/package/paris.jpg'),
       (9, '런던 시티 투어 6일', '인천', '런던', '영국', 2750000, 6.0, 'image/package/london.jpg'),
       (10, '로마 예술 여행 5일', '김포', '로마', '이탈리아', 2650000, 5.0, 'image/package/roma.jpg'),
       (11, '뉴욕 자유 여행 6일', '인천', '뉴욕', '미국', 3150000, 6.0, 'image/package/newyork.jpg'),
       (12, '로스앤젤레스 해변 여행 7일', '김포', '로스앤젤레스', '미국', 2980000, 7.0, 'image/package/losangeles.jpg'),
       (13, '스위스 알프스 하이킹 6일', '인천', '취리히', '스위스', 3100000, 6.0, 'image/package/swiss.jpg'),
       (14, '프라하 감성 여행 5일', '김포', '프라하', '체코', 2550000, 5.0, 'image/package/praha.jpg'),

       (16, '오키나와 휴양 여행 4일', '김포', '오키나와', '일본', 1380000, 4.0, 'image/package/bangkok.jpg'),
       (17, '교토 문화 탐방 3일', '인천', '교토', '일본', 920000, 3.0, 'image/package/danang.jpg'),
       (18, '후쿠오카 쇼핑 여행 3일', '김포', '후쿠오카', '일본', 880000, 3.0, 'image/package/taipei.jpg'),

       (19, '샌프란시스코 골든게이트 투어 4일', '인천', '샌프란시스코', '미국', 1420000, 4.0, 'image/package/paris.jpg'),
       (20, '라스베이거스 카지노 여행 3일', '김포', '라스베이거스', '미국', 1190000, 3.0, 'image/package/london.jpg'),
       (21, '마이애미 해변 휴양 5일', '인천', '마이애미', '미국', 1650000, 5.0, 'image/package/roma.jpg');

--------------------------

