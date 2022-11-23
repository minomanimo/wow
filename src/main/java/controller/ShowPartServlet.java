package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import DAO.MemberDAO;
import member.*;

@WebServlet("/ShowPart")
public class ShowPartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		String part=request.getParameter("part");
		MemberDAO mDAO=MemberDAO.getInstance();
		ArrayList<WorkList> list=mDAO.getWorkList(part);
		PrintWriter out=response.getWriter();
		out.println("<response>");
		for(int i=0; i<list.size(); i++) {
			out.println("<name>"+list.get(i).getName()+"</name>");
		}
		out.println("</response>");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
