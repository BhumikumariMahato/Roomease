package com.roomease.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.roomease.util.RedirectionUtil;
import com.roomease.service.DashboardService;

/**
 * Servlet implementation class DashboardController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/dashboard" })
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DashboardService dashboardService = new DashboardService();

        request.setAttribute("totalRooms", dashboardService.getTotalRooms());
        request.setAttribute("occupiedRooms", dashboardService.getOccupiedRooms());
        request.setAttribute("availableRooms", dashboardService.getAvailableRooms());
        request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());
        request.setAttribute("totalUsers", dashboardService.getTotalUsers());
        request.setAttribute("totalBookings", dashboardService.getTotalBookings());
        request.setAttribute("pendingRequests", dashboardService.getPendingRequests());
        request.setAttribute("roomTypeMap", dashboardService.getRoomTypeDistribution());

        request.getRequestDispatcher(RedirectionUtil.dboardUrl).forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
