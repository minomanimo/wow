package controller;

import java.io.*;
import java.time.LocalDate;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import DAO.MemberDAO;
import member.*;

@WebServlet("/today.do")
public class TodayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("userid");
		LocalDate ld=LocalDate.now();
		int dayofweek=ld.getDayOfWeek().getValue();
		String day=null;
		if(dayofweek==1) {
			day="월";
		}else if(dayofweek==2) {
			day="화";
		}else if(dayofweek==3) {
			day="수";
		}else if(dayofweek==4) {
			day="목";
		}else if(dayofweek==5) {
			day="금";
		}else if(dayofweek==6) {
			day="토";
		}else if(dayofweek==7) {
			day="일";
		}
		
		MemberDAO DAO=MemberDAO.getInstance();
		ArrayList<Routine> list=DAO.getRoutine(id, day);
		HashMap<String, Routine> map=DAO.getTodaysWork(id, day);
		
		request.setAttribute("list", list);
		request.setAttribute("map", map);
		RequestDispatcher dis=request.getRequestDispatcher("today.jsp");
		dis.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String day=request.getParameter("day");
		int length=Integer.parseInt(request.getParameter("len"));
		int[] sets=new int[length];
		int[] kg=new int[length];
		int[] reps=new int[length];
		for(int i=0; i<length; i++) {
			
			sets[i]=Integer.parseInt(request.getParameter("sets"+(i+1)));
			kg[i]=Integer.parseInt(request.getParameter("kg"+(i+1)));
			reps[i]=Integer.parseInt(request.getParameter("reps"+(i+1)));
		}
		MemberDAO DAO=MemberDAO.getInstance();
		DAO.setTodaysWork(id, day, name, sets, kg, reps);
		ArrayList<Routine> list=DAO.getRoutine(id, day);
		HashMap<String,Routine> map=DAO.getTodaysWork(id, day);
		
		request.setAttribute("list", list);
		request.setAttribute("map", map);
		request.getRequestDispatcher("today.jsp").forward(request, response);
		
	}

}
