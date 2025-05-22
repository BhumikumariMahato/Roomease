package com.roomease.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.roomease.config.DbConfig;
import com.roomease.model.BookingModel;
import com.roomease.model.RoomModel;
import com.roomease.model.UserModel;

public class BookingService {
	private Connection dbConn;

	public BookingService() {
		try {
			dbConn = DbConfig.getDbConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean hasUserAlreadyBookedRoom(int userId, int roomId) {
		String query = "SELECT COUNT(*) FROM bookings WHERE user_ID = ? AND room_ID = ?";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, roomId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<BookingModel> getBookingsByUserID(int user_ID) {
		List<BookingModel> bookings = new ArrayList<>();
		String query = "SELECT * FROM bookings WHERE user_ID = ?";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			stmt.setInt(1, user_ID);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				bookings.add(mapResultSetToBooking(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookings;
	}

	public List<BookingModel> getAllBookings() {
		List<BookingModel> bookings = new ArrayList<>();
		String query = "SELECT * FROM bookings";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				bookings.add(mapResultSetToBooking(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookings;
	}

	public boolean deleteBookingById(int booking_ID) {
		String query = "DELETE FROM bookings WHERE booking_ID = ?";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			stmt.setInt(1, booking_ID);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteBookingByIdAndUser(int booking_ID, int user_ID) {
		String query = "DELETE FROM bookings WHERE booking_ID = ? AND user_ID = ?";
		try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
			stmt.setInt(1, booking_ID);
			stmt.setInt(2, user_ID);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public void submitBooking(BookingModel booking) throws SQLException {
		String sql = "INSERT INTO bookings (room_ID, user_ID, full_name, email, checkin_date, booking_date) VALUES (?, ?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
			stmt.setInt(1, booking.getRoom_ID().getRoom_ID());
			stmt.setInt(2, booking.getUser_ID().getUser_ID());
			stmt.setString(3, booking.getFull_name());
			stmt.setString(4, booking.getEmail());
			stmt.setDate(5, new java.sql.Date(booking.getCheckin_date().getTime()));
			stmt.setTimestamp(6, new java.sql.Timestamp(new Date().getTime()));
			stmt.executeUpdate();
		}
	}

	private BookingModel mapResultSetToBooking(ResultSet rs) throws SQLException {
		RoomModel room = new RoomModel();
		room.setRoom_ID(rs.getInt("room_ID"));

		UserModel user = new UserModel();
		user.setUser_ID(rs.getInt("user_ID"));

		return new BookingModel(rs.getInt("booking_ID"), rs.getString("full_name"), rs.getString("email"),
				rs.getDate("checkin_date"), rs.getDate("booking_date"), room, user);
	}
}
