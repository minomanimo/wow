package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;



@WebServlet("/comment.do")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String comment=request.getParameter("comment");
		int main_num=Integer.parseInt(request.getParameter("content_num"));
		String userid=request.getParameter("userid");
		int recomment=0;
		if(request.getParameter("recomment")!=null) {
			recomment=Integer.parseInt(request.getParameter("recomment"));
		}
		int comment_num=0;
		if(request.getParameter("comment_num")!=null) {
			comment_num=Integer.parseInt(request.getParameter("comment_num"));
		}
		MemberDAO mDAO=MemberDAO.getInstance();
		int success=mDAO.writeComment(userid, comment, main_num, recomment, comment_num);
		request.setAttribute("success", success);
		response.sendRedirect("content.do");
	}

}
