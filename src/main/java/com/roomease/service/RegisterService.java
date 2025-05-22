package com.roomease.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.roomease.config.DbConfig;
import com.roomease.model.UserModel;

public class RegisterService {

	private Connection dbConn;

	public RegisterService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		} catch (SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
	}

	public Boolean addUser(UserModel userModel) {
		if (dbConn == null) {
			System.err.println("Database connection is not available.");
			return null;
		}

		String insertQuery = "INSERT INTO user (user_name, user_email, user_password, user_contact_number) "
				+ "VALUES (?, ?, ?, ?)";

		try {
			dbConn.setAutoCommit(false);

			try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {
				insertStmt.setString(1, userModel.getUser_name());
				insertStmt.setString(2, userModel.getUser_email());
				insertStmt.setString(3, userModel.getUser_password());
				insertStmt.setString(4, userModel.getUser_contact_number());

				int rowsAffected = insertStmt.executeUpdate();
				dbConn.commit();
				return rowsAffected > 0;
			}
		} catch (SQLException e) {
			try {
				dbConn.rollback();
			} catch (SQLException ex) {
				System.err.println("Rollback failed: " + ex.getMessage());
			}
			System.err.println("Error during registration: " + e.getMessage());
			e.printStackTrace();
			return false; // Return false instead of null for clearer flow
		} finally {
			try {
				dbConn.setAutoCommit(true);
			} catch (SQLException ex) {
				System.err.println("Failed to reset auto-commit: " + ex.getMessage());
			}
		}
	}

}