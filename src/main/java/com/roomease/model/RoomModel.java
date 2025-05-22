package com.roomease.model;

public class RoomModel {
	private int room_ID;
	private String room_type;
	private String room_description;
	private String room_status;
	private int room_capacity;
	private String room_furnishing;
	private String room_facilities;
	private int room_size;
	private String image_path;

	private PriceModel price_ID;
	private LocationModel location_ID;

	public RoomModel() {
	}

	public RoomModel(int room_ID, String room_type, String room_description, String room_status, int room_capacity,
			String room_furnishing, String room_facilities, int room_size, String image_path, PriceModel price_ID,
			LocationModel location_ID) {
		super();
		this.room_ID = room_ID;
		this.room_type = room_type;
		this.room_description = room_description;
		this.room_status = room_status;
		this.room_capacity = room_capacity;
		this.room_furnishing = room_furnishing;
		this.room_facilities = room_facilities;
		this.room_size = room_size;
		this.image_path = image_path;
		this.price_ID = price_ID;
		this.location_ID = location_ID;
	}

	public int getRoom_ID() {
		return room_ID;
	}

	public void setRoom_ID(int room_ID) {
		this.room_ID = room_ID;
	}

	public String getRoom_type() {
		return room_type;
	}

	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}

	public String getRoom_description() {
		return room_description;
	}

	public void setRoom_description(String room_description) {
		this.room_description = room_description;
	}

	public String getRoom_status() {
		return room_status;
	}

	public void setRoom_status(String room_status) {
		this.room_status = room_status;
	}

	public int getRoom_capacity() {
		return room_capacity;
	}

	public void setRoom_capacity(int room_capacity) {
		this.room_capacity = room_capacity;
	}

	public String getRoom_furnishing() {
		return room_furnishing;
	}

	public void setRoom_furnishing(String room_furnishing) {
		this.room_furnishing = room_furnishing;
	}

	public String getRoom_facilities() {
		return room_facilities;
	}

	public void setRoom_facilities(String room_facilities) {
		this.room_facilities = room_facilities;
	}

	public int getRoom_size() {
		return room_size;
	}

	public void setRoom_size(int room_size) {
		this.room_size = room_size;
	}

	public String getImage_path() {
		return image_path;
	}

	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}

	public PriceModel getPrice_ID() {
		return price_ID;
	}

	public void setPrice_ID(PriceModel price_ID) {
		this.price_ID = price_ID;
	}

	public LocationModel getLocation_ID() {
		return location_ID;
	}

	public void setLocation_ID(LocationModel location_ID) {
		this.location_ID = location_ID;
	}

	

}