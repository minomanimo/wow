<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>루틴 | WoW</title>
		<style>
			*{
				margin:0;
				padding:0;
			}
			#wrap{
				width:600px;
				margin:0 auto;
				border:1px solid black;
			}
			#wrap a{
				text-decoration:none;
				color:black;
				text-align:center;
			}
			#wrap *{
				margin:10px;
			}
			#wrap span{
				display:block;
				width:50%;
				margin:0 auto;
			}
			#wrap label{
				margin:5px;
			}
		</style>
	</head>
	<body>
		<%
			if(session.getAttribute("userid")==null){
		%>
				<script>
					alert("이 페이지는 로그인이 필요합니다.");
					location.href="index.jsp";
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
			<form method="post" action="routine.do">
				<span>주당 운동 요일을 선택하세요.</span>
				<label for="mon">월<input type="checkbox" id="mon" value="월" name="day"></label>
				<label for="tue">화<input type="checkbox" id="tue" value="화" name="day"></label>
				<label for="wed">수<input type="checkbox" id="wed" value="수" name="day"></label>
				<label for="thu">목<input type="checkbox" id="thu" value="목" name="day"></label>
				<label for="fri">금<input type="checkbox" id="fri" value="금" name="day"></label>
				<label for="sat">토<input type="checkbox" id="sat" value="토" name="day"></label>
				<label for="sun">일<input type="checkbox" id="sun" value="일" name="day"></label>
				<input type="submit" value="확인">
			</form>
		</div>
	</body>
</html>