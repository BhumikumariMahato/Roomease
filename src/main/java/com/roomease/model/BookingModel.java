package com.roomease.model;

import java.util.Date;

public class BookingModel {
	private int booking_ID;
	private String full_name;
	private String email;
	private Date checkin_date;
	private Date booking_date;

	private RoomModel room_ID;
	private UserModel user_ID;

	public BookingModel(int booking_ID, String full_name, String email, Date checkin_date, Date booking_date,
			RoomModel room_ID, UserModel user_ID) {
		super();
		this.booking_ID = booking_ID;
		this.full_name = full_name;
		this.email = email;
		this.checkin_date = checkin_date;
		this.booking_date = booking_date;
		this.room_ID = room_ID;
		this.user_ID = user_ID;
	}

	public int getBooking_ID() {
		return booking_ID;
	}

	public void setBooking_ID(int booking_ID) {
		this.booking_ID = booking_ID;
	}

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCheckin_date() {
		return checkin_date;
	}

	public void setCheckin_date(Date checkin_date) {
		this.checkin_date = checkin_date;
	}

	public Date getBooking_date() {
		return booking_date;
	}

	public void setBooking_date(Date booking_date) {
		this.booking_date = booking_date;
	}

	public RoomModel getRoom_ID() {
		return room_ID;
	}

	public void setRoom_ID(RoomModel room_ID) {
		this.room_ID = room_ID;
	}

	public UserModel getUser_ID() {
		return user_ID;
	}

	public void setUser_ID(UserModel user_ID) {
		this.user_ID = user_ID;
	}

}