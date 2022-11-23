<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			if(request.getAttribute("message")!=null){
				int id=(int)request.getAttribute("message");
				if(id==1){
		%>
					<script>location.href="main.do"</script>	
		<%
				}else if(id==0){
		%>
					<script>
						alert("비밀번호가 일치하지 않습니다.");
						location.href="login.jsp";
					</script>		
		<%		
				}else{
		%>
					<script>
						alert("존재하지 않는 아이디 입니다.");
						location.href="login.jsp";
					</script>
		<%		
				}
			}
		%>
		<script>location.href="main.do"</script>
		
	</body>
</html>