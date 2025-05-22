package com.roomease.model;

public class ContactModel {

	private int contact_form_id;
	private String first_name;
	private String last_name;
	private String form_email;
	private String form_message;

	private UserModel user_ID;

	public ContactModel(int contact_form_id, String first_name, String last_name, String form_email,
			String form_message, UserModel user_ID) {
		super();
		this.contact_form_id = contact_form_id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.form_email = form_email;
		this.form_message = form_message;
		this.user_ID = user_ID;
	}

	public ContactModel() {
		super();
	}

	public int getContact_form_id() {
		return contact_form_id;
	}

	public void setContact_form_id(int contact_form_id) {
		this.contact_form_id = contact_form_id;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getForm_email() {
		return form_email;
	}

	public void setForm_email(String form_email) {
		this.form_email = form_email;
	}

	public String getForm_message() {
		return form_message;
	}

	public void setForm_message(String form_message) {
		this.form_message = form_message;
	}

	public UserModel getUser_ID() {
		return user_ID;
	}

	public void setUser_ID(UserModel user_ID) {
		this.user_ID = user_ID;
	}

}
