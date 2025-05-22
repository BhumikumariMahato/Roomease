package com.roomease.controller;

import com.roomease.model.RoomModel;
import com.roomease.model.UserModel;
import com.roomease.model.LocationModel;
import com.roomease.model.PriceModel;
import com.roomease.service.RoomService;
import com.roomease.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/home", "/manage-rooms" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class RoomController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String locationId = req.getParameter("location_ID");
        String priceId = req.getParameter("price_ID");
        String status = req.getParameter("room_status");

        List<RoomModel> rooms;

        if ((locationId != null && !locationId.isEmpty()) ||
            (priceId != null && !priceId.isEmpty()) ||
            (status != null && !status.isEmpty())) {
            rooms = roomService.getFilteredRooms(locationId, priceId, status);
        } else {
            rooms = roomService.getAllRooms();
        }

        List<LocationModel> locations = roomService.getAllLocations();
        List<PriceModel> prices = roomService.getAllPrices();

        req.setAttribute("rooms", rooms);
        req.setAttribute("locations", locations);
        req.setAttribute("prices", prices);

        HttpSession session = req.getSession(false);
        UserModel user = (UserModel) session.getAttribute("customer");
        boolean isAdmin = user != null && "admin".equalsIgnoreCase(user.getUser_role());

        if (req.getServletPath().equals("/manage-rooms") && isAdmin) {
            req.getRequestDispatcher("/WEB-INF/pages/room-management.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/pages/rooms.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        UserModel user = (UserModel) session.getAttribute("customer");

        if (user == null || !"admin".equalsIgnoreCase(user.getUser_role())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int roomId = Integer.parseInt(req.getParameter("room_ID"));
            roomService.deleteRoom(roomId);
        } else {

            RoomModel room = new RoomModel();
            room.setRoom_type(req.getParameter("room_type"));
            room.setRoom_description(req.getParameter("room_description"));
            room.setRoom_status(req.getParameter("room_status"));
            room.setRoom_capacity(Integer.parseInt(req.getParameter("room_capacity")));
            room.setRoom_furnishing(req.getParameter("room_furnishing"));
            room.setRoom_facilities(req.getParameter("room_facilities"));
            room.setRoom_size(Integer.parseInt(req.getParameter("room_size")));
            room.setLocation_ID(new LocationModel(Integer.parseInt(req.getParameter("location_ID")), "", ""));
            room.setPrice_ID(new PriceModel(Integer.parseInt(req.getParameter("price_ID")), 0, 0));

            Part imagePart = req.getPart("image_path");
            ImageUtil imageUtil = new ImageUtil();
            String imageName = imageUtil.getImageNameFromPart(imagePart);
            boolean uploadSuccess = imageUtil.uploadImage(imagePart, "", "rooms", req);


            if (uploadSuccess) {
            	room.setImage_path("images/rooms/" + imageName);
            } else {
                room.setImage_path("images/default.png"); // fallback or log error
            }

            if ("create".equalsIgnoreCase(action)) {
                roomService.createRoom(room);
            } else if ("update".equalsIgnoreCase(action)) {
                room.setRoom_ID(Integer.parseInt(req.getParameter("room_ID")));
                roomService.updateRoom(room);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/manage-rooms");
    }
}
