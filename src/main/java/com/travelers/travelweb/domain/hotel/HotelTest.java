package com.travelers.travelweb.domain.hotel;

import com.travelers.travelweb.domain.hotel.domain.Hotel;
import com.travelers.travelweb.domain.hotel.service.HotelService;

import java.util.List;

public class HotelTest {
    public static void main(String[] args) {
        HotelService hotelService = new HotelService();

        // 서울 호텔만 조회
        List<Hotel> seoulHotels = hotelService.getHotelsByCity(4);

        System.out.println("도쿄 호텔 개수: " + seoulHotels.size());
        System.out.println("------ 도쿄 호텔 리스트 ------");
        for (Hotel h : seoulHotels) {
            System.out.println("호텔 이름: " + h.getName());
            System.out.println("도시: " + h.getCity());
            System.out.println("가격: " + h.getPrice());
            System.out.println("평점: " + h.getRating());
            System.out.println("----------------------------");
        }

    }
}