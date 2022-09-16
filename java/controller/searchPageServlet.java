package controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import member.*;

@WebServlet("/searchPage.do")
public class searchPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String search=request.getParameter("search");
		
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<String> workList=DAO.searchWork(search);
		ArrayList<Community> commuList=DAO.searchCommu(search);
		
		
		request.setAttribute("workList", workList);
		request.setAttribute("commuList", commuList);
		request.getRequestDispatcher("searchPage.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
