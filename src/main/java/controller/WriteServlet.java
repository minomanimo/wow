package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


import DAO.MemberDAO;

@WebServlet("/write.do")
public class WriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String userid=request.getParameter("userid");
		String category=request.getParameter("category");
		
		MemberDAO mDAO=MemberDAO.getInstance();
		int success=mDAO.writeCommu(userid, category, title, content);
		HttpSession session=request.getSession();
		session.setAttribute("success", success);
		response.sendRedirect("community.do");
		
	}

}
