package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/routine.do")
public class RoutineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
//		String time=request.getParameter("time");
		String[] day=request.getParameterValues("day");
//		request.setAttribute("time", time);
		request.setAttribute("day", day);
		RequestDispatcher dis=request.getRequestDispatcher("routine.jsp");
		dis.forward(request, response);
	}

}
