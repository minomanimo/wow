package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;


@WebServlet("/idcheck.do")
public class idcheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		String id=request.getParameter("id");
		MemberDAO mDAO=MemberDAO.getInstance();
		boolean hasId=mDAO.idCheck(id);
		String isValid="false";
		String message="X 이미 존재하는 아이디입니다.";
		if(!hasId) {
			isValid="true";
			message="√ 사용가능한 아이디입니다!";
		}
		PrintWriter out=response.getWriter();
		out.println("<response>");
		out.println("<message>"+message+"</message>");
		out.println("<isValid>"+isValid+"</isValid>");
		out.println("</response>");
		out.close();
	}

}
