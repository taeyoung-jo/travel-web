package com.travelers.travelweb.domain.hotel.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Getter
@Setter
@NoArgsConstructor   // 기본 생성자
@AllArgsConstructor  // 모든 필드 받는 생성자
@Builder             // 빌더 패턴
public class Hotel {
    private int id;
    private String name;
    private int city;
    private String country;
    private String image;
    private String price;
    private double rating;
}