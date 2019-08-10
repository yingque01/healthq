package com.healthq.core.model;

import java.util.UUID;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * The entity class for CRUD operations from the database table: healthq.clinics.
 * @author YingPeng Que
 *
 */
@Data
@ToString(callSuper=true)
@EqualsAndHashCode(callSuper=true)
@NoArgsConstructor
public class HealthQClinics extends BaseEntity {
	private String address1;
	private String address2;
	private String suburbOrCity;
	private String stateOfProvince;
	private String country;
	private String postalCode;
	private String description;
    
	/*public HealthQClinics(final UUID id, final String address1,
			final String address2, final String suburbOrCity,
			final String stateOfProvince, final String country,
			final String postalCode, final String description) {
		super(id);
		this.address1 = address1;
		this.address2 = address2;
		this.suburbOrCity = suburbOrCity;
		this.stateOfProvince = stateOfProvince;
		this.country = country;
		this.postalCode = postalCode;
		this.description = description;
	}*/
}