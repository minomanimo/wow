<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>관리자 페이지 | WoW</title>
		<style>
			*{
				margin:0;
				padding:0;
			}
			#logo{
				text-align:center;
			}
			#logo a{
				text-decoration:none;
				color:black;
			}
			li{
				display:inline-block;
				margin:10px;
			}
		</style>
	</head>
	<body>
		<%
			if(session.getAttribute("admin")==null){
		%>
				<script>
					alert("접근권한이 없습니다.");
					location.replace("index.jsp");
				</script>
		<%
			}
		%>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<h1>관리자 페이지</h1>
			<div id="header">
				<ul>
					<li><a href="member.jsp">회원관리</a></li>
					<li>QnA</li>
					<li><a href="list.jsp">운동목록</a></li>
				</ul>
			</div>
		</div>
	</body>
</html>