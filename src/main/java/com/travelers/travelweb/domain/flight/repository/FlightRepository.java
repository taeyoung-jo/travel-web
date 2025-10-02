package com.travelers.travelweb.domain.flight.repository;

import java.util.List;
import java.util.Optional;

import com.travelers.travelweb.domain.flight.domain.Flight;

public interface FlightRepository {

	Optional<Flight> findById(Long id);

	List<Flight> findAll();
}
