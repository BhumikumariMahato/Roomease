package com.roomease.service;

import com.roomease.config.DbConfig;
import com.roomease.model.RoomModel;
import com.roomease.model.PriceModel;
import com.roomease.model.LocationModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomService {

    public List<RoomModel> getAllRooms() {
        List<RoomModel> rooms = new ArrayList<>();
        String sql = "SELECT r.*, p.*, l.* FROM room r " +
                "JOIN price p ON r.price_ID = p.price_ID " +
                "JOIN location l ON r.location_ID = l.location_ID";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                PriceModel price = new PriceModel(
                        rs.getInt("price_ID"),
                        rs.getInt("price_monthly"),
                        rs.getInt("price_deposit_amount")
                );

                LocationModel location = new LocationModel(
                        rs.getInt("location_ID"),
                        rs.getString("location_city"),
                        rs.getString("location_area")
                );

                RoomModel room = new RoomModel(
                        rs.getInt("room_ID"),
                        rs.getString("room_type"),
                        rs.getString("room_description"),
                        rs.getString("room_status"),
                        rs.getInt("room_capacity"),
                        rs.getString("room_furnishing"),
                        rs.getString("room_facilities"),
                        rs.getInt("room_size"),
                        rs.getString("image_path"),
                        price,
                        location
                );
                rooms.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }

    public List<LocationModel> getAllLocations() {
        List<LocationModel> list = new ArrayList<>();
        String sql = "SELECT * FROM location";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new LocationModel(
                        rs.getInt("location_ID"),
                        rs.getString("location_city"),
                        rs.getString("location_area")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<PriceModel> getAllPrices() {
        List<PriceModel> list = new ArrayList<>();
        String sql = "SELECT * FROM price";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new PriceModel(
                        rs.getInt("price_ID"),
                        rs.getInt("price_monthly"),
                        rs.getInt("price_deposit_amount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Deletes the room and any associated bookings to prevent foreign key constraint violations.
     * Returns true if the room was successfully deleted, false otherwise.
     */
    public boolean deleteRoom(int roomId) {
        String deleteBookingsSQL = "DELETE FROM bookings WHERE room_ID = ?";
        String deleteRoomSQL = "DELETE FROM room WHERE room_ID = ?";

        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false); // Start transaction

            try (
                PreparedStatement deleteBookingsStmt = conn.prepareStatement(deleteBookingsSQL);
                PreparedStatement deleteRoomStmt = conn.prepareStatement(deleteRoomSQL)
            ) {
                // Delete bookings referencing the room
                deleteBookingsStmt.setInt(1, roomId);
                deleteBookingsStmt.executeUpdate();

                // Delete the room itself
                deleteRoomStmt.setInt(1, roomId);
                int affectedRows = deleteRoomStmt.executeUpdate();

                conn.commit(); // All successful
                return affectedRows > 0;

            } catch (SQLException e) {
                conn.rollback(); // Undo changes on failure
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public void updateRoom(RoomModel room) {
        String sql = "UPDATE room SET room_type = ?, room_description = ?, room_status = ?, room_capacity = ?, " +
                "room_furnishing = ?, room_facilities = ?, room_size = ?, price_ID = ?, location_ID = ?, image_path = ? WHERE room_ID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
        	 stmt.setString(1, room.getRoom_type());
             stmt.setString(2, room.getRoom_description());
             stmt.setString(3, room.getRoom_status());
             stmt.setInt(4, room.getRoom_capacity());
             stmt.setString(5, room.getRoom_furnishing());
             stmt.setString(6, room.getRoom_facilities());
             stmt.setInt(7, room.getRoom_size());
             stmt.setInt(8, room.getPrice_ID().getPrice_ID());
             stmt.setInt(9, room.getLocation_ID().getLocation_ID());
             stmt.setString(10, room.getImage_path());
            stmt.setInt(11, room.getRoom_ID());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createRoom(RoomModel room) {
        String sql = "INSERT INTO room (room_type, room_description, room_status, room_capacity, room_furnishing, room_facilities, room_size, price_ID, location_ID, image_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, room.getRoom_type());
            stmt.setString(2, room.getRoom_description());
            stmt.setString(3, room.getRoom_status());
            stmt.setInt(4, room.getRoom_capacity());
            stmt.setString(5, room.getRoom_furnishing());
            stmt.setString(6, room.getRoom_facilities());
            stmt.setInt(7, room.getRoom_size());
            stmt.setInt(8, room.getPrice_ID().getPrice_ID());
            stmt.setInt(9, room.getLocation_ID().getLocation_ID());
            stmt.setString(10, room.getImage_path());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<RoomModel> getFilteredRooms(String locationId, String priceId, String status) {
        List<RoomModel> rooms = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT r.*, p.*, l.* FROM room r " +
            "JOIN price p ON r.price_ID = p.price_ID " +
            "JOIN location l ON r.location_ID = l.location_ID WHERE 1=1");

        if (locationId != null && !locationId.isEmpty()) {
            sql.append(" AND r.location_ID = ?");
        }
        if (priceId != null && !priceId.isEmpty()) {
            sql.append(" AND r.price_ID = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND r.room_status = ?");
        }

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (locationId != null && !locationId.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(locationId));
            }
            if (priceId != null && !priceId.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(priceId));
            }
            if (status != null && !status.isEmpty()) {
                stmt.setString(paramIndex++, status);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PriceModel price = new PriceModel(
                        rs.getInt("price_ID"),
                        rs.getInt("price_monthly"),
                        rs.getInt("price_deposit_amount")
                    );
                    LocationModel location = new LocationModel(
                        rs.getInt("location_ID"),
                        rs.getString("location_city"),
                        rs.getString("location_area")
                    );
                    RoomModel room = new RoomModel(
                        rs.getInt("room_ID"),
                        rs.getString("room_type"),
                        rs.getString("room_description"),
                        rs.getString("room_status"),
                        rs.getInt("room_capacity"),
                        rs.getString("room_furnishing"),
                        rs.getString("room_facilities"),
                        rs.getInt("room_size"),
                        rs.getString("image_path"),
                        price,
                        location
                    );
                    rooms.add(room);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }

}
