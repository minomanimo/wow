package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import DAO.MemberDAO;
import member.*;

@WebServlet("/myPage.do")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid=request.getParameter("userid");
		int currentPage=1;
		if(request.getParameter("currentPage")!=null) {
			currentPage=Integer.parseInt(request.getParameter("currentpage"));
		}
		
		MemberDAO mDAO=MemberDAO.getInstance();
		
		ArrayList<Community> list=new ArrayList<Community>();
		list=mDAO.getCommu(null, userid, null, currentPage);
		
		int row=mDAO.getNumberOfRows(null, userid);
		int nOfPage=row/20;
		if(row%20!=0) {
			nOfPage++;
		}
		
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("Alist", list);
		RequestDispatcher dis=request.getRequestDispatcher("myPage.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
