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

@WebServlet("/join.do")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		String birth=request.getParameter("birth1")+"-"+request.getParameter("birth2");
		String email=request.getParameter("email1")+"@"+request.getParameter("email2");
		Member m=new Member();
		m.setId(id);
		m.setPwd(pwd);
		m.setName(name);
		m.setPhone(phone);
		m.setBirth(birth);
		m.setEmail(email);
		MemberDAO mDAO=MemberDAO.getInstance();
		int result=mDAO.insertMember(m);
		if(result==1) {
			request.setAttribute("message", 1);
		}else {
			request.setAttribute("message", 0);
		}
		RequestDispatcher dis=request.getRequestDispatcher("login.jsp");
		dis.forward(request,response);
	}

}
