package controller;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import member.WorkList;


@WebServlet("/workout.do")
public class WorkoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name=null;
		ArrayList<String> slist=new ArrayList<String>();
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<WorkList> list=DAO.getWorkList("all");
		if(request.getParameter("name")!=null) {
			name=request.getParameter("name");
			slist=DAO.searchWork(name);
		}
		
		request.setAttribute("slist",slist);
		request.setAttribute("list", list);
		request.getRequestDispatcher("workout.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
