package controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import member.Community;



@WebServlet("/content.do")
public class ContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("id");
		String time=request.getParameter("time");
		MemberDAO mDAO=MemberDAO.getInstance();
		ArrayList<Community> list=mDAO.getCommu(null, id, time, 0);
		
		Community content=list.get(0);
		
		
		request.setAttribute("id", id);
		request.setAttribute("title",content.getTitle());
		request.setAttribute("content", content.getContent());
		request.setAttribute("like", content.getLikes());
		request.setAttribute("dislike", content.getDislike());
		request.setAttribute("time", content.getTime());
		RequestDispatcher dis=request.getRequestDispatcher("content.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
