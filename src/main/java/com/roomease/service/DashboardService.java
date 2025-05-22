package com.roomease.service;

import com.roomease.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.Map;
import java.util.HashMap;



public class DashboardService {

    public int getTotalRooms() {
        return getCount("SELECT COUNT(*) FROM room");
    }

    public int getOccupiedRooms() {
        return getCount("SELECT COUNT(*) FROM room WHERE room_status = 'Occupied'");
    }

    public int getAvailableRooms() {
        return getCount("SELECT COUNT(*) FROM room WHERE room_status = 'Available'");
    }

    public int getTotalUsers() {
        return getCount("SELECT COUNT(*) FROM user");
    }

    public int getTotalBookings() {
        return getCount("SELECT COUNT(*) FROM bookings");
    }

    public int getPendingRequests() {
        return getCount("SELECT COUNT(*) FROM contact_form");
    }

    public int getTotalRevenue() {
        String sql = "SELECT SUM(p.price_monthly) FROM bookings b " +
                     "JOIN room r ON b.room_ID = r.room_ID " +
                     "JOIN price p ON r.price_ID = p.price_ID";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int getCount(String sql) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public Map<String, Integer> getRoomTypeDistribution() {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT room_type, COUNT(*) AS count FROM room GROUP BY room_type";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("room_type"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
