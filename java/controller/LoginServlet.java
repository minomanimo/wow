package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.MemberDAO;
import member.Member;


@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		MemberDAO mDAO=MemberDAO.getInstance();
		int result=mDAO.memberCheck(id, pwd);
		
		HttpSession session=request.getSession();
		if(result==1) {
			Member m=mDAO.getMember(id);
			session.setAttribute("userid", m.getId());
			session.setAttribute("admin", m.getAdmin());			
			session.setMaxInactiveInterval(60*60);
			request.setAttribute("message", 1);
		}else if(result==0) {
			request.setAttribute("message", 0);
		}else {
			request.setAttribute("message", -1);
		}
		RequestDispatcher dis=request.getRequestDispatcher("index.jsp");
		dis.forward(request, response);
	}

}
