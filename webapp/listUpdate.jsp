<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>listupdate</title>
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
			String part=request.getParameter("part");
			String name=request.getParameter("name");
			String ytlink1=request.getParameter("ytlink1");
			String ytlink2=request.getParameter("ytlink2");
			String ytlink3=request.getParameter("ytlink3");
			String exp=request.getParameter("exp");
			String insert=request.getParameter("insert");
			
			if(ytlink1.equals(""))ytlink1=null;
			if(ytlink2.equals(""))ytlink2=null;
			if(ytlink3.equals(""))ytlink3=null;
			if(exp.equals(""))exp=null;
			
			Connection conn=null;
			PreparedStatement pstmt=null;
			String url="jdbc:mysql://127.0.0.1:3306/wow";
			String db_id="root";
			String db_pw="iotiot";
			String sql=null;
			if(insert==null){
				sql="update workout_list set part=?, name=?, ytlink1=?, ytlink2=?, ytlink3=?, exp=? where name=?;";
			}else{
				sql="insert into workout_list (part,name,ytlink1,ytlink2,ytlink3,exp) values (?,?,?,?,?,?);";
			}
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn=DriverManager.getConnection(url,db_id,db_pw);
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, part);
				pstmt.setString(2, name);
				pstmt.setString(3, ytlink1);
				pstmt.setString(4, ytlink2);
				pstmt.setString(5, ytlink3);
				pstmt.setString(6, exp);
				if(insert==null){
					pstmt.setString(7, name);
				}
				pstmt.executeUpdate();
			}catch(Exception e){
				out.print("오류발생 : "+e);
			}finally{
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}
		%>
		<script>
			alert("수정완료");
			location.replace("list.jsp");
		</script>
	</body>
</html>