package com.roomease.model;

public class LocationModel {
	private int location_ID;
	private String location_city;
	private String location_area;

	public LocationModel(int location_ID, String location_city, String location_area) {
		this.location_ID = location_ID;
		this.location_city = location_city;
		this.location_area = location_area;
	}

	public int getLocation_ID() {
		return location_ID;
	}

	public void setLocation_ID(int location_ID) {
		this.location_ID = location_ID;
	}

	public String getLocation_city() {
		return location_city;
	}

	public void setLocation_city(String location_city) {
		this.location_city = location_city;
	}

	public String getLocation_area() {
		return location_area;
	}

	public void setLocation_area(String location_area) {
		this.location_area = location_area;
	}

}