package controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;


@WebServlet("/GetLink")
public class GetLinkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		String name=request.getParameter("name");
		MemberDAO mDAO=MemberDAO.getInstance();
		String[] links=mDAO.getLink(name);
		PrintWriter out=response.getWriter();
		out.println("<response>");
		for(int i=0; i<3; i++) {
			out.println("<ytlink>"+links[i]+"</ytlink>");
		}
		out.println("<exp>"+links[3]+"</exp>");
		out.println("</response>");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
