package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import DAO.MemberDAO;


@WebServlet("/routine.do")
public class RoutineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
//		String time=request.getParameter("time");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("userid");
		MemberDAO DAO=MemberDAO.getInstance();
		
		String[] day=null;
		if(request.getParameterValues("day")!=null) {
			day=request.getParameterValues("day");
			DAO.setDaysOfRoutine(day, id);
		}
//		request.setAttribute("time", time);
//		request.setAttribute("day", day);
		
		
		
		ArrayList<String> arr=DAO.getDaysOfRoutine(id);
		request.setAttribute("day", arr);
		RequestDispatcher dis=request.getRequestDispatcher("routine.jsp");
		dis.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
