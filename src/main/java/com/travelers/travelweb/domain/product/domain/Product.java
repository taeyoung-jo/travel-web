package com.travelers.travelweb.domain.product.domain;

import java.math.BigDecimal;

import com.travelers.travelweb.global.config.BaseTimeEntity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
public class Product extends BaseTimeEntity {

	private Long id;
	private Long deptFlightId;
	private Long arriveFlightId;
	private Long hotelId;
	private Long locationId;
	private BigDecimal price;
}
