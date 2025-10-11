require('dotenv').config();
const axios = require("axios");
const fs = require("fs");
const path = require("path");

const DATA_DIR = path.resolve(__dirname, "data");
const OUTPUT_PATH = path.join(DATA_DIR, "hoteldb.json");

function getRandomPrice(min = 30000, max = 800000) {
  const price = Math.floor(Math.random() * ((max - min) / 100 + 1) + min / 100) * 100;
  return `${price.toLocaleString()}`;
}

function getRandomRating() {
  const min = 1;
  const max = 5;
  return (Math.random() * (max - min) + min).toFixed(1);
}

const cities = [
  { id: 4, name: "Tokyo", country: "JP" },
  { id: 3, name: "Osaka", country: "JP" },
  { id: 5, name: "Okinawa", country: "JP" },

  { id: 21, name: "Xining", country: "CN" },
  { id: 27, name: "Harbin", country: "CN" },
  { id: 20, name: "Beijing", country: "CN" },

  { id: 32, name: "Sydney", country: "AU" },
  { id: 33, name: "Auckland", country: "NZ" },
  { id: 36, name: "Guam", country: "GU" },
  { id: 37, name: "Saipan", country: "MP" },
  { id: 41, name: "Hawaii", country: "US" },
  { id: 42, name: "Toronto", country: "CA" },
  { id: 38, name: "Los Angeles", country: "US" },

  { id: 50, name: "Manila", country: "PH" },
  { id: 51, name: "Hanoi", country: "VN" },
  { id: 52, name: "Singapore", country: "SG" },
  { id: 55, name: "Bangkok", country: "TH" },
  { id: 57, name: "Hong Kong", country: "HK" },
  { id: 61, name: "Jeju", country: "KR" },
  { id: 60, name: "Bali", country: "ID" }
];

const allHotels = [];

async function fetchHotels() {
  if (!fs.existsSync(DATA_DIR)) {
    fs.mkdirSync(DATA_DIR, { recursive: true });
  }

  const apiKey = process.env.SERPAPI_KEY;
  if (!apiKey) {
    console.error("SERPAPI_KEY 환경 변수가 설정되지 않았습니다.");
    process.exit(1);
  }

  // e15e6945f39593ad861b977e8869c7a74582854008a3ad3a51fb6cbabbd88874
  const fetchPromises = cities.map(city =>
    axios.get("https://serpapi.com/search", {
      params: {
        api_key: apiKey,
        engine: "google_hotels",
        q: `${city.name} hotels`,
        location: `${city.name}, ${city.country}`,
        check_in_date: "2025-10-10",
        check_out_date: "2025-10-12"
      }
    })
    .then(response => ({city, properties: response.data?.properties ?? []}))
    .catch(err => {
      console.error(`Error fetching hotels for ${city.name}:`, err.message);
      return {city, properties: []};
    })
  );

  const results = await Promise.all(fetchPromises);

  let hotelIdCounter = 1;
  const allHotels = results.flatMap(result => {
    const {city, properties} = result;
    return properties.map(hotel => ({
      id: hotelIdCounter++,
      name: hotel.name,
      city: city.id,
      country: city.country,
      image: hotel.images ? hotel.images[0].image_url : "N/A",
      price: getRandomPrice(),
      rating: getRandomRating()
    }));
  });

  fs.writeFileSync(OUTPUT_PATH, JSON.stringify({ hotels: allHotels }, null, 2));
  console.log(`hoteldb.json 생성 완료! (경로: ${OUTPUT_PATH})`);
}
