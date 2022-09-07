package controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.simple.*;
import org.json.simple.parser.*;

import DAO.MemberDAO;
import member.Routine;



@WebServlet("/setRoutine.do")
public class setRoutineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String day=request.getParameter("day");
		String data=request.getParameter("arr");
		int len=Integer.parseInt(request.getParameter("len"));
		int[] sets=new int[len];
		int[] kg=new int[len];
		int[] reps=new int[len];
		for(int i=1; i<=len; i++) {
			sets[i-1]=Integer.parseInt(request.getParameter("sets"+i));
			kg[i-1]=Integer.parseInt(request.getParameter("kg"+i));
			reps[i-1]=Integer.parseInt(request.getParameter("reps"+i));
		}
		String[] arr=null; 
		JSONParser jParser=new JSONParser();
		try {
			JSONArray obj=(JSONArray)jParser.parse(data);
			arr=new String[obj.size()];
			for(int i=0; i<obj.size(); i++) {
				arr[i]=(String)obj.get(i);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ArrayList<Routine> routineList=new ArrayList<Routine>();
		for(int i=0; i<len; i++) {
			Routine routine=new Routine(id, day, arr[i], sets[i], kg[i], reps[i]);
			routineList.add(routine);
		}
		MemberDAO DAO=MemberDAO.getInstance();
		DAO.setRoutine(routineList);
	}

}
