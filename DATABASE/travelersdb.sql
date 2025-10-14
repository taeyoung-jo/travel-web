CREATE TABLE locations
(
    id        BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    continent VARCHAR(255) NOT NULL,
    city      VARCHAR(255) NOT NULL
);

INSERT INTO locations (continent, city)
VALUES ('일본', '북해도'),
       ('일본', '후쿠오카'),
       ('일본', '오사카/교토/고베'),
       ('일본', '동경/시즈오카/이바라키'),
       ('일본', '오키나와/미야코지마/이시가키'),
       ('일본', '오이타/사가/우베/야마구치'),
       ('일본', '아오모리/니가타/아키타'),
       ('일본', '요나고/나고야/알펜루트'),
       ('일본', '마츠야마'),
       ('일본', '다카마츠/나오시마/도쿠시마'),
       ('일본', '대마도/선박여행'),
       ('중국', '장가계'),
       ('중국', '백두산'),
       ('중국', '태항산'),
       ('중국', '황산/신선거'),
       ('중국', '계림/망산(천저우)'),
       ('중국', '여강(리장)/곤명'),
       ('중국', '구채구/성도'),
       ('중국', '중경/귀양'),
       ('중국', '북경(베이징)'),
       ('중국', '상해(상하이)'),
       ('중국', '서안/정주'),
       ('중국', '칭다오(청도)'),
       ('중국', '대련'),
       ('중국', '연태/위해/천진'),
       ('중국', '하문(샤먼)'),
       ('중국', '하얼빈/하이난'),
       ('중국', '광동성/홍콩/마카오/충칭'),
       ('중국', '우루무치/티벳'),
       ('몽골', '몽골/내몽골'),
       ('호주', '호주'),
       ('뉴질랜드', '뉴질랜드'),
       ('호주', '타히티'),
       ('괌', '괌'),
       ('사이판', '사이판'),
       ('미주', '미서부'),
       ('미주', '미동부'),
       ('미주', '미남부'),
       ('하와이', '하와이'),
       ('캐나다', '캐나다'),
       ('미주', '미주 연계'),
       ('미주', '알래스카'),
       ('중남미', '중남미'),
       ('아프리카', '아프리카'),
       ('중앙아시아', '코카서스');

-- 임시 테이블에 CSV 로드
DROP TABLE IF EXISTS flights_temp;

CREATE TABLE flights_temp
(
    location_id   BIGINT,
    flight_number VARCHAR(255) NOT NULL,
    airline       VARCHAR(255) NOT NULL,
    dept_time     DATETIME     NOT NULL,
    arrival_time  DATETIME     NOT NULL,
    price         BIGINT       NOT NULL,
    destination   VARCHAR(255)
);

LOAD DATA LOCAL INFILE './flights_data.csv'
    INTO TABLE flights_temp
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (location_id, flight_number, airline, dept_time, arrival_time, price, destination);

-- destination으로 location_id 매핑
UPDATE flights_temp t
    JOIN locations l ON t.destination = l.continent
SET t.location_id = l.id;

-- flights 테이블 생성 및 데이터 이동
CREATE TABLE flights
(
    id            BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
    location_id   BIGINT,
    flight_number VARCHAR(255) NOT NULL,
    airline       VARCHAR(255) NOT NULL,
    dept_time     DATETIME     NOT NULL,
    arrival_time  DATETIME     NOT NULL,
    price         BIGINT       NOT NULL,
    CONSTRAINT fk_flights_location
        FOREIGN KEY (location_id) REFERENCES locations (id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO flights (location_id, flight_number, airline, dept_time, arrival_time, price)
SELECT location_id, flight_number, airline, dept_time, arrival_time, price
FROM flights_temp
WHERE location_id IS NOT NULL;

-- 임시 테이블 제거
DROP TABLE flights_temp;
