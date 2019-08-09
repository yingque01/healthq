package com.healthq.core.model;

import java.util.UUID;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@EqualsAndHashCode(callSuper=true)
@NoArgsConstructor
public class HealthQClinicRoomsDTO extends BaseDTO {
	private String clinicsId;
	private String description;

	public HealthQClinicRoomsDTO(final UUID id, final String clinicsId,
			String description) {
		super(id);
		this.clinicsId = clinicsId;
		this.description = description;
	}
}