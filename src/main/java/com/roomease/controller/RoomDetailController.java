package com.roomease.controller;

import com.roomease.model.RoomModel;
import com.roomease.service.RoomService;
import com.roomease.util.RedirectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class RoomDetailController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/RoomDetails" })
public class RoomDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final RoomService roomService = new RoomService();
	private final RedirectionUtil util = new RedirectionUtil();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String roomIdStr = req.getParameter("id");

		if (roomIdStr == null) {
			resp.sendRedirect("rooms");
			return;
		}

		try {
			int roomId = Integer.parseInt(roomIdStr);
			List<RoomModel> rooms = roomService.getAllRooms();

			for (RoomModel room : rooms) {
				if (room.getRoom_ID() == roomId) {
					req.setAttribute("room", room);
					util.redirectToPage(req, resp, RedirectionUtil.roomdUrl);
					return;
				}
			}

			util.setMsgAndRedirect(req, resp, "error", "Room not found.", RedirectionUtil.roomsUrl);

		} catch (NumberFormatException e) {
			util.setMsgAndRedirect(req, resp, "error", "Invalid room ID format.", RedirectionUtil.roomsUrl);
		}
	}

}
