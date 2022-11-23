package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import DAO.MemberDAO;



@WebServlet("/update.do")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int num=Integer.parseInt(request.getParameter("num"));
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<String> list=DAO.updateContent(num, null, null);
		request.setAttribute("title", list.get(0));
		request.setAttribute("content",list.get(1));
		request.setAttribute("num", num);
		request.getRequestDispatcher("update.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
