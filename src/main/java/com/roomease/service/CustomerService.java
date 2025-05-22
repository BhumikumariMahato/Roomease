package com.roomease.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.roomease.model.UserModel;
import com.roomease.config.DbConfig;

public class CustomerService {
	private static final Logger logger = Logger.getLogger(CustomerService.class.getName());

	public List<UserModel> getAllUserInfo() {
		String query = "SELECT user_ID, user_name, user_email, user_contact_number FROM user";
		try (Connection conn = DbConfig.getDbConnection();
				PreparedStatement stmt = conn.prepareStatement(query);
				ResultSet result = stmt.executeQuery()) {

			List<UserModel> userList = new ArrayList<>();

			while (result.next()) {
				userList.add(new UserModel(result.getInt("user_ID"), result.getString("user_name"),
						result.getString("user_email"), result.getString("user_contact_number")));
			}
			return userList;

		} catch (SQLException | ClassNotFoundException e) {
			logger.log(Level.SEVERE, "Error fetching user list", e);
			return new ArrayList<>();
		}
	}

	public boolean updateUser(UserModel user) {
		String updateQuery = "UPDATE user SET user_name = ?, user_email = ?, user_contact_number = ? WHERE user_ID = ?";
		try (Connection conn = DbConfig.getDbConnection();
				PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

			stmt.setString(1, user.getUser_name());
			stmt.setString(2, user.getUser_email());
			stmt.setString(3, user.getUser_contact_number());
			stmt.setInt(4, user.getUser_ID());

			int rowsAffected = stmt.executeUpdate();
			logger.info("User update executed. Rows affected: " + rowsAffected);
			return rowsAffected > 0;

		} catch (SQLException | ClassNotFoundException e) {
			logger.log(Level.SEVERE, "Error updating user", e);
			return false;
		}
	}

	public boolean deleteUser(int user_ID) {
		String deleteBookingsSQL = "DELETE FROM bookings WHERE user_ID = ?";
		String deleteContactSQL = "DELETE FROM contact_form WHERE user_ID = ?";
		String deleteUserSQL = "DELETE FROM user WHERE user_ID = ?";

		try (Connection conn = DbConfig.getDbConnection()) {
			conn.setAutoCommit(false); // Start transaction

			try (PreparedStatement deleteBookingsStmt = conn.prepareStatement(deleteBookingsSQL);
					PreparedStatement deleteContactStmt = conn.prepareStatement(deleteContactSQL);
					PreparedStatement deleteUserStmt = conn.prepareStatement(deleteUserSQL)) {
				// Delete bookings
				deleteBookingsStmt.setInt(1, user_ID);
				deleteBookingsStmt.executeUpdate();

				// Delete contact form entries
				deleteContactStmt.setInt(1, user_ID);
				deleteContactStmt.executeUpdate();

				// Delete user
				deleteUserStmt.setInt(1, user_ID);
				boolean userDeleted = deleteUserStmt.executeUpdate() > 0;

				conn.commit(); // Commit if all succeed
				return userDeleted;

			} catch (SQLException e) {
				conn.rollback(); // Rollback on failure
				logger.log(Level.SEVERE, "Transaction failed while deleting user with ID: " + user_ID, e);
				return false;
			}

		} catch (SQLException | ClassNotFoundException e) {
			logger.log(Level.SEVERE, "Error connecting to the database while deleting user with ID: " + user_ID, e);
			return false;
		}
	}

	public UserModel getSpecificUserInfo(int user_ID) {
		String query = "SELECT user_ID, user_name, user_email, user_contact_number FROM user WHERE user_ID = ?";
		try (Connection conn = DbConfig.getDbConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, user_ID);
			ResultSet result = stmt.executeQuery();

			if (result.next()) {
				return new UserModel(result.getInt("user_ID"), result.getString("user_name"),
						result.getString("user_email"), result.getString("user_contact_number"));
			}

		} catch (SQLException | ClassNotFoundException e) {
			logger.log(Level.SEVERE, "Error fetching specific user", e);
		}
		return null;
	}

	public UserModel getUserByUsername(String username) {
		String query = "SELECT user_ID, user_name, user_email, user_password, user_contact_number FROM user WHERE user_name = ?";
		try (Connection conn = DbConfig.getDbConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setString(1, username);
			ResultSet result = stmt.executeQuery();

			if (result.next()) {
				return new UserModel(result.getInt("user_ID"), result.getString("user_name"),
						result.getString("user_email"), result.getString("user_password"),
						result.getString("user_contact_number")

				);
			}

		} catch (SQLException | ClassNotFoundException e) {
			logger.log(Level.SEVERE, "Error fetching user by username", e);
		}
		return null;
	}

	public boolean updateUserinfo(UserModel user) {
		String updateQuery = "UPDATE user SET user_name = ?, user_email = ?, user_password = ?, user_contact_number = ? WHERE user_ID = ?";
		try (Connection conn = DbConfig.getDbConnection();
				PreparedStatement stmt = conn.prepareStatement(updateQuery)) {

			stmt.setString(1, user.getUser_name());
			stmt.setString(2, user.getUser_email());
			stmt.setString(3, user.getUser_password());
			stmt.setString(4, user.getUser_contact_number());
			stmt.setInt(5, user.getUser_ID());

			int rowsAffected = stmt.executeUpdate();
			logger.info("User update executed. Rows affected: " + rowsAffected);
			return rowsAffected > 0;

		} catch (SQLException | ClassNotFoundException e) {
			logger.log(Level.SEVERE, "Error updating user", e);
			return false;
		}
	}
}
