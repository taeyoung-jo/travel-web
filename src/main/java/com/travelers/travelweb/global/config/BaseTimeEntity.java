package com.travelers.travelweb.global.config;

import java.time.LocalDateTime;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder(toBuilder = true)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public abstract class BaseTimeEntity {

	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private LocalDateTime deletedAt;

	public void markCreated() {
		LocalDateTime now = LocalDateTime.now();
		this.createdAt = now;
		this.updatedAt = now;
		this.deletedAt = null;
	}

	public void markUpdated() {
		this.updatedAt = LocalDateTime.now();
	}

	public void markDeleted() {
		LocalDateTime now = LocalDateTime.now();
		this.updatedAt = now;
		this.deletedAt = now;
	}

	public void restore() {
		this.deletedAt = null;
		this.updatedAt = LocalDateTime.now();
	}

	public boolean isDeleted() {
		return this.deletedAt != null;
	}
}
