package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import member.*;
import DAO.MemberDAO;


@WebServlet("/totalVol.do")
public class TotalVolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		HttpSession session=request.getSession();
		
		String id=null;
		ArrayList<TotalVol> mylist=null;
		
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<TotalVol> list=DAO.getAllTotalVol();
		
		
		PrintWriter out=response.getWriter();
		
		out.println("<response>");
		out.println("<all>");
		for(int i=0; i<list.size(); i++) {
			out.println("<total>"+list.get(i).getTotal()+"</total>");
			out.println("<today>"+list.get(i).getToday()+"</today>");
		}
		out.println("</all>");
		if(session.getAttribute("userid")!=null) {
			id=(String)session.getAttribute("userid");
			mylist=DAO.getMyTotalVol(id);
			out.println("<my>");
			for(int i=0; i<mylist.size(); i++) {
				out.println("<total>"+mylist.get(i).getTotal()+"</total>");
				out.println("<today>"+mylist.get(i).getToday()+"</today>");
			}
			out.println("</my>");
		}
		out.println("</response>");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
