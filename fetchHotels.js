const axios = require("axios");
const fs = require("fs");

// 랜덤 데이터 생성 함수
//랜덤 가격
function getRandomPrice(min = 30000, max = 800000) {
    const price = Math.floor(Math.random() * ((max - min) / 100 + 1) + min / 100) * 100;
    return `${price.toLocaleString()}`;
}
//랜덤 평점
function getRandomRating() {
    const min = 1;
    const max = 5;
    return (Math.random() * (max - min) + min).toFixed(1);
}

// 도시 리스트
const cities = [
    // 일본
    { id: 4, name: "Tokyo", country: "JP" },
    { id: 3, name: "Osaka", country: "JP" },
    { id: 5, name: "Okinawa", country: "JP" },

    // 중국
    { id: 21, name: "Xining", country: "CN" },    // 싱해
    { id: 27, name: "Harbin", country: "CN" },    // 하얼빈
    { id: 20, name: "Beijing", country: "CN" },   // 북경

    // 기타 지역
    { id: 32, name: "Sydney", country: "AU" },        // 호주
    { id: 33, name: "Auckland", country: "NZ" },      // 뉴질랜드
    { id: 36, name: "Guam", country: "GU" },          // 괌
    { id: 37, name: "Saipan", country: "MP" },       // 사이판
    { id: 41, name: "Hawaii", country: "US" },       // 하와이
    { id: 42, name: "Toronto", country: "CA" },      // 캐나다
    { id: 38, name: "Los Angeles", country: "US" },  // 미서부(대표 도시로 LA)

    // 동남아 & 기타
    { id: 50, name: "Manila", country: "PH" },       // 필리핀
    { id: 51, name: "Hanoi", country: "VN" },        // 베트남
    { id: 52, name: "Singapore", country: "SG" },    // 싱가포르
    { id: 55, name: "Bangkok", country: "TH" },      // 태국
    { id: 57, name: "Hong Kong", country: "HK" },    // 홍콩
    { id: 61, name: "Jeju", country: "KR" },         // 제주도
    { id: 60, name: "Bali", country: "ID" }          // 발리
];

// 일본 - 도쿄, 오사카, 오키나와
// 중국 - 싱해, 하얼빈, 북경
// 호주, 뉴질랜드, 괌, 사이판, 하와이, 캐나다, 미서부
//필리핀, 베트남, 싱가포르, 태국, 홍콩, 제주도, 발리

const allHotels = [];

async function fetchHotels() {
    for (let city of cities) {
        try {
            const response = await axios.get("https://serpapi.com/search", {
                params: {
                    api_key: "e15e6945f39593ad861b977e8869c7a74582854008a3ad3a51fb6cbabbd88874",
                    engine: "google_hotels",
                    q: `${city.name} hotels`,
                    location: `${city.name}, ${city.country}`,
                    check_in_date: "2025-10-10",   // YYYY-MM-DD
                    check_out_date: "2025-10-12"
                }
            });

            const hotels = response.data.properties.map((hotel, index) => ({
                id: allHotels.length + index + 1,
                name: hotel.name,
                city: city.id,
                country: city.country,
                image: hotel.images ? hotel.images[0].image_url : "N/A",
                price: getRandomPrice(),           // 한국어 랜덤 가격
                rating: getRandomRating()  // 랜덤 평점
            }));

            allHotels.push(...hotels);
        } catch (err) {
            console.error(`Error fetching hotels for ${city.name}:`, err.message);
        }
    }

    fs.writeFileSync("hoteldb.json", JSON.stringify({ hotels: allHotels }, null, 2));
    console.log("hoteldb.json 생성 완료!");
}

fetchHotels();

