package com.travelers.travelweb;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "calendar", urlPatterns = "/calendar")
public class CalendarServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// JSP로 포워딩 (forward)
		RequestDispatcher dispatcher = req.getRequestDispatcher("/calendarTest.jsp");
		dispatcher.forward(req, resp);
	}

}
