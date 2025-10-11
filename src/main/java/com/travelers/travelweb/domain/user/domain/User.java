package com.travelers.travelweb.domain.user.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.travelers.travelweb.global.util.PhoneUtil;
import com.travelers.travelweb.global.util.auth.PasswordUtil;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class User {
	private Long id;
	private String email;
	private String name;
	private String password;
	private String phone;

	private LocalDateTime created_at;
	private LocalDateTime updated_at;
	private LocalDateTime deleted_at;
}