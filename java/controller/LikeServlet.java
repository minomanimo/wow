package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;


@WebServlet("/like.do")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String like=request.getParameter("like");
		int islike=Integer.parseInt(request.getParameter("islike"));
		String id=request.getParameter("id");
		String time=request.getParameter("time");
		String likedid=request.getParameter("likedid");
		MemberDAO mDAO=MemberDAO.getInstance();
		int liked=mDAO.setGetLikes(like, islike, id, time,likedid);
		response.getWriter().write(Integer.toString(liked));
	}

}
