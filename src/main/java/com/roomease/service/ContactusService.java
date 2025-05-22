package com.roomease.service;

import com.roomease.config.DbConfig;
import com.roomease.model.ContactModel;
import com.roomease.model.UserModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactusService {
	private Connection dbConn;

	public ContactusService() {
		try {
			dbConn = DbConfig.getDbConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Insert a contact form entry
	public void insertContact(ContactModel contact) throws SQLException {
		String query = "INSERT INTO contact_form (first_name, last_name, form_email, form_message, user_ID) VALUES (?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			stmt.setString(1, contact.getFirst_name());
			stmt.setString(2, contact.getLast_name());
			stmt.setString(3, contact.getForm_email());
			stmt.setString(4, contact.getForm_message());
			stmt.setInt(5, contact.getUser_ID().getUser_ID());
			stmt.executeUpdate();
		}
	}

	public List<ContactModel> getContacts() {
		List<ContactModel> contacts = new ArrayList<>();
		String query = "SELECT * FROM contact_form";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				ContactModel contact = new ContactModel();
				UserModel user = new UserModel();

				contact.setContact_form_id(rs.getInt("contact_form_id"));
				contact.setFirst_name(rs.getString("first_name"));
				contact.setLast_name(rs.getString("last_name"));
				contact.setForm_email(rs.getString("form_email"));
				contact.setForm_message(rs.getString("form_message"));

				user.setUser_ID(rs.getInt("user_ID"));
				contact.setUser_ID(user);

				contacts.add(contact);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return contacts;
	}

	// Delete a contact form entry by ID
	public void deleteContactById(int contactId) throws SQLException {
		String query = "DELETE FROM contact_form WHERE contact_form_id = ?";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			stmt.setInt(1, contactId);
			stmt.executeUpdate();
		}
	}
}
