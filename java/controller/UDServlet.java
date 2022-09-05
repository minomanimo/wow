package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import DAO.MemberDAO;



@WebServlet("/ud.do")
public class UDServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		int num=Integer.parseInt(request.getParameter("num"));
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<String> list=DAO.updateContent(num, title, content);
		HttpSession session=request.getSession();
		session.setAttribute("success", Integer.parseInt(list.get(0)));
		response.sendRedirect("community.do");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num=Integer.parseInt(request.getParameter("num"));
		int isupdate=Integer.parseInt(request.getParameter("update"));
		MemberDAO mDAO=MemberDAO.getInstance();
		if(isupdate==0) {
			mDAO.deleteContent(num);
		}
	}

}
