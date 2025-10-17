package com.travelers.travelweb.domain.user.domain;

import com.travelers.travelweb.global.BaseTimeEntity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@SuperBuilder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
public class User extends BaseTimeEntity {

	private Long id;
	private String email;
	private String name;
	private String password;
	private String phone;

}
