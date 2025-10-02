package com.travelers.travelweb.domain.hotel.repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.travelers.travelweb.domain.hotel.domain.Hotel;

import java.io.File;
import java.util.List;

public class HotelRepository {
    private static final String HOTEL_JSON_PATH = "hoteldb.json"; // JSON 파일 경로

    // 전체 호텔 리스트 반환
    public List<Hotel> getAllHotels() {
        ObjectMapper mapper = new ObjectMapper();//JSON ↔ Java 객체 변환을 담당하는 객체 생성
        try {
            // json 파일 읽어서 hotel 리스트로 변환
            HotelListWrapper wrapper = mapper.readValue(new File(HOTEL_JSON_PATH), HotelListWrapper.class);
            return wrapper.getHotels();
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    // json 구조에 맞춘 wrapper 클래스 //JSON 최상위 객체를 감싸는 보조 클래스
    private static class HotelListWrapper {
        private List<Hotel> hotels; //json key를 가져옴

        public List<Hotel> getHotels(){return hotels;}
        public void setHotels(List<Hotel> hotels){this.hotels = hotels;}
    }
}
