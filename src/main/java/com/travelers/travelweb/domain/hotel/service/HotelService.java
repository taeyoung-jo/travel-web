package com.travelers.travelweb.domain.hotel.service;

import com.travelers.travelweb.domain.hotel.domain.Hotel;
import com.travelers.travelweb.domain.hotel.repository.HotelRepository;

import java.util.ArrayList;
import java.util.List;

public class HotelService {

    private HotelRepository hotelRepository = new HotelRepository();

    // 전체 호텔 리스트 반환
    public List<Hotel> getAllHotels() {
        return hotelRepository.getAllHotels();
    }
    // 도시별 호텔리스트 가져오기
    public List<Hotel> getHotelsByCity(int city) {
        List<Hotel> hotels = hotelRepository.getAllHotels();
        List<Hotel> result = new ArrayList<>();

        for (Hotel h : hotels) {
            if (h.getCity() == city) {
                result.add(h);
            }
        }

        return result;  // 해당 도시에 있는 호텔 리스트 반환
    }

}