package com.roomease.model;

public class UserModel {
	private int user_ID;
	private String user_name;
	private String user_email;
	private String user_password;
	private String user_contact_number;
	private String user_role;

	public UserModel() {

	}

	public UserModel(String user_name, String user_password) {
		super();
		this.user_name = user_name;
		this.user_password = user_password;
	}

	public UserModel(int user_ID, String user_name, String user_email, String user_password, String user_contact_number,
			String user_role) {
		super();
		this.user_ID = user_ID;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_contact_number = user_contact_number;
		this.user_role = user_role;
	}

	public UserModel(String user_name, String user_email, String user_password, String user_contact_number) {
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_contact_number = user_contact_number;

	}

	public UserModel(int user_ID, String user_name, String user_email, String user_contact_number) {
		this.user_ID = user_ID;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_contact_number = user_contact_number;
	}

	public UserModel(String user_name, String user_email, String user_contact_number) {
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_contact_number = user_contact_number;
	}

	public UserModel(int user_ID, String user_name, String user_email, String user_password,
			String user_contact_number) {
		this.user_ID = user_ID;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_contact_number = user_contact_number;
	}

	public int getUser_ID() {
		return user_ID;
	}

	public void setUser_ID(int user_ID) {
		this.user_ID = user_ID;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_contact_number() {
		return user_contact_number;
	}

	public void setUser_contact_number(String user_contact_number) {
		this.user_contact_number = user_contact_number;
	}

	public String getUser_role() {
		return user_role;
	}

	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}

}