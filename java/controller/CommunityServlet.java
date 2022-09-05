package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import DAO.MemberDAO;
import member.Community;


@WebServlet("/community.do")
public class CommunityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO mDAO=MemberDAO.getInstance();
		int currentPage=1;
		String category=null;
		if(request.getParameter("currentPage")!=null) {
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		if(request.getParameter("category")!=null) {
			if(request.getParameter("category").equals("")) {
				category=null;
			}else {
				category=request.getParameter("category");
			}
		}
		ArrayList<Community> Alist=mDAO.getCommu(category, null, null, currentPage);
//		int idx=Alist.size();
//		String[] id=new String[idx];
//		String[] title=new String[idx];
//		String[] time=new String[idx];
//		String[] like=new String[idx];
//		
//		for(int i=0; i<Alist.size(); i++) {
//			id[i]=Alist.get(i).getId();
//			title[i]=Alist.get(i).getTitle();
//			time[i]=Alist.get(i).getTime();
//			like[i]=Alist.get(i).getLikes();
//		}
//		
//		request.setAttribute("id", id);
//		request.setAttribute("title",title);
//		request.setAttribute("time", time);
//		request.setAttribute("like", like);
		int row=mDAO.getNumberOfRows(category, null);
		int nOfPage=row/20;
		if(row%20!=0) {
			nOfPage++;
		}
		
		String page=null;
		if(category==null) {
			page="최신글";
		}else if(category.equals("popular")) {
			page="인기글";
		}else if(category.equals("info")) {
			page="운동 정보글";
		}else if(category.equals("free")) {
			page="자유 게시판";
		}else if(category.equals("recom")) {
			page="보충제 추천";
		}
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("Alist", Alist);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("category", category);
		request.setAttribute("page", page);
		RequestDispatcher dis=request.getRequestDispatcher("community.jsp");
		dis.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request,response);
	}

}
