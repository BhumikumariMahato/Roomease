package com.roomease.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.roomease.model.BookingModel;
import com.roomease.model.RoomModel;
import com.roomease.model.UserModel;
import com.roomease.service.BookingService;
import com.roomease.util.SessionUtil;
import com.roomease.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, urlPatterns = { "/book-room" })
public class BookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookingService bookingService;
	private ValidationUtil validationUtil;

	@Override
	public void init() throws ServletException {
		bookingService = new BookingService();
		validationUtil = new ValidationUtil();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserModel currentUser = (UserModel) SessionUtil.getAttribute(req, "customer");

		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		if ("admin".equalsIgnoreCase(currentUser.getUser_role())) {
			List<BookingModel> bookings = bookingService.getAllBookings();
			req.setAttribute("bookings", bookings);
			req.getRequestDispatcher("/WEB-INF/pages/bookings.jsp").forward(req, resp);
		} else {
			List<BookingModel> bookings = bookingService.getBookingsByUserID(currentUser.getUser_ID());
			req.setAttribute("bookings", bookings);
			req.getRequestDispatcher("/WEB-INF/pages/userbooking.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		UserModel currentUser = (UserModel) SessionUtil.getAttribute(req, "customer");

		if ("book".equalsIgnoreCase(action)) {
			try {
				int room_ID = Integer.parseInt(req.getParameter("room_ID"));
				int user_ID = currentUser.getUser_ID();

				if (bookingService.hasUserAlreadyBookedRoom(user_ID, room_ID)) {
					resp.sendRedirect(req.getContextPath() + "/RoomDetails?id=" + room_ID + "&error=alreadyBooked");
					return;
				}

				String fullName = req.getParameter("name");
				String email = req.getParameter("email");
				String checkinDateStr = req.getParameter("checkin");

				Date checkinDate = new SimpleDateFormat("yyyy-MM-dd").parse(checkinDateStr);

				RoomModel room = new RoomModel();
				room.setRoom_ID(room_ID);

				BookingModel booking = new BookingModel(0, fullName, email, checkinDate, new Date(), room, currentUser);

				bookingService.submitBooking(booking);
				resp.sendRedirect(req.getContextPath() + "/RoomDetails?id=" + room_ID + "&success=bookingSubmitted");

			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect(req.getContextPath() + "/RoomDetails?error=bookingFailed");
			}
			return;
		}

		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		if ("delete".equalsIgnoreCase(action)) {
			String bookingIdParam = req.getParameter("booking_ID");
			if (!validationUtil.isNullOrEmpty(bookingIdParam)) {
				int bookingId = Integer.parseInt(bookingIdParam);
				boolean deleted;

				if ("admin".equalsIgnoreCase(currentUser.getUser_role())) {
					deleted = bookingService.deleteBookingById(bookingId);
				} else {
					deleted = bookingService.deleteBookingByIdAndUser(bookingId, currentUser.getUser_ID());
				}

				if (deleted) {
					req.setAttribute("success", "Booking deleted successfully.");
				} else {
					req.setAttribute("error", "Failed to delete booking.");
				}
			}
			doGet(req, resp);
		}
	}
}
