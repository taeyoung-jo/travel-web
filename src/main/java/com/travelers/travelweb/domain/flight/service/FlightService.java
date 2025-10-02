package com.travelers.travelweb.domain.flight.service;

import java.util.List;

import com.travelers.travelweb.domain.flight.domain.Flight;
import com.travelers.travelweb.domain.flight.repository.FlightRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class FlightService {

	private final FlightRepository repository;

	public Flight getFlight(Long id) {
		return repository.findById(id)
			.orElseThrow(() -> new IllegalArgumentException(id + "라는 아이디를 가진 항공편을 찾을 수 없습니다."));
	}

	public List<Flight> getFlights() {
		return repository.findAll();
	}
}
