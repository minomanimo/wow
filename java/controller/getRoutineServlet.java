package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import java.util.*;
import member.*;


@WebServlet("/getRoutine.do")
public class getRoutineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		String day=request.getParameter("day");
		String userid=request.getParameter("userid");
		
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<Routine> list=DAO.getRoutine(userid, day);
		
		PrintWriter out=response.getWriter();
		out.println("<response>");
		for(int i=0; i<list.size(); i++) {
			out.println("<name>"+list.get(i).getName()+"</name>");
			out.println("<idx>"+list.get(i).getIdx()+"</idx>");
			out.println("<sets>"+list.get(i).getSets()+"</sets>");
			out.println("<kg>"+list.get(i).getKg()+"</kg>");
			out.println("<reps>"+list.get(i).getReps()+"</reps>");
		}
		out.println("</response>");
		out.close();
	}

}
