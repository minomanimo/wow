package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;

@WebServlet("/DeleteList")
public class DeleteListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		String name=request.getParameter("name");
		MemberDAO mDAO=MemberDAO.getInstance();
		int delete=mDAO.deleteList(name);
		String responseText=null;
		if(delete==1) {
			responseText="삭제완료";
		}else if(delete==0) {
			responseText="오류 : 삭제실패";
		}
		PrintWriter out=response.getWriter();
		out.println(responseText);
		out.close();
	}

}
