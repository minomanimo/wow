package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import member.*;
import DAO.MemberDAO;



@WebServlet("/searchCommu.do")
public class SearchCommuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int isSearch=1;
		int currentPage=1;
		if(request.getParameter("currentPage")!=null) {
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		String search=request.getParameter("search");
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<Community> list=DAO.searchCommu(search);
		
		int nOfPage=list.size()/20;
		if(list.size()%20!=0) {
			nOfPage++;
		}
		
		ArrayList<Community> splitList=new ArrayList<Community>();
		int start=(currentPage-1)*20;
		int end=0;
		
		if(currentPage<nOfPage) {
			end=start+20;
		}else{
			end=list.size()%20+start;
		}
		
		for(int i=start; i<end; i++) {
			splitList.add(list.get(i));
		}
		
		request.setAttribute("isSearch", isSearch);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("Alist", splitList);
		request.setAttribute("page", "검색");
		
		request.getRequestDispatcher("community.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
