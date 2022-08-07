<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>루틴 | WoW</title>
		<link rel="stylesheet" href="style_rout.css">
	</head>
	<body>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<%
				request.setCharacterEncoding("utf-8");
				//String time=request.getParameter("time");
				String[] day=request.getParameterValues("day");
			%>
			<div id="header">
				<ul>
				<%
					for(int i=0; i<day.length; i++){
				%>
						<li id="<%=i %>">
							<a href='#' onclick="dayOnClick('<%=day[i]%>','<%=i %>')">
				<%
							out.print(day[i]);
				%>
							</a>
						</li>
				<%	
					}
				%>
				</ul>
			</div>
			<div id="main">
				<div id="choose">
					<p>운동을 선택하세요</p>
					<ul>
						<a href="#" onclick="showPart('all')"><li>전체</li></a>
						<a href="#" onclick="showPart('chest')"><li>가슴</li></a>
						<a href="#" onclick="showPart('back')"><li>등</li></a>
						<a href="#" onclick="showPart('shoulder')"><li>어깨</li></a>
						<a href="#" onclick="showPart('triceps')"><li>삼두</li></a>
						<a href="#" onclick="showPart('biceps')"><li>이두</li></a>
						<a href="#" onclick="showPart('leg')"><li>하체</li></a>
					</ul>
					<div id="list">
						<ul>
							<li><a href="#">덤벨프레스</a></li>
							<li><a href="#">벤치프레스</a></li>
							<li><a href="#">사이드 레터럴 레이즈</a></li>
							<li><a href="#">렛 풀 다운</a></li>
							<li><a href="#">케이블 푸시다운</a></li>						</ul>
					</div>
				</div>
				<div id="put">
					 <form method="post" action="">
					 	<div id="drop">
					 		덤벨프레스
					 		<div id="input">
					 			세트
						 		<input type="number" name="set">
						 		중량
						 		<input type="text" name="kg">
					 		</div>
					 	</div>
					 	<div id="drop">
					 		벤치프레스
					 		<div id="input">
					 			세트
						 		<input type="number" name="set">
						 		중량
						 		<input type="text" name="kg">
					 		</div>
					 	</div>
					 	<div id="drop">
					 		사이드 레터럴 레이즈
					 		<div id="input">
					 			세트
						 		<input type="number" name="set">
						 		중량
						 		<input type="text" name="kg">
					 		</div>
					 	</div>
					 	<div id="drop">
					 		랫 풀 다운
					 		<div id="input">
					 			세트
						 		<input type="number" name="set">
						 		중량
						 		<input type="text" name="kg">
					 		</div>
					 	</div>
					 	<div id="drop">
					 		케이블 푸시다운
					 		<div id="input">
					 			세트
						 		<input type="number" name="set">
						 		중량
						 		<input type="text" name="kg">
					 		</div>
					 	</div>
					 </form>
				</div>
			</div>
		</div>
		<script>
			function dayOnClick(day, i){
				var li=document.getElementById(i);
				var lis=document.getElementsByTagName("li");
				for(var i=0; i<lis.length; i++){
					lis[i].style.backgroundColor="white";
				}
				li.style.backgroundColor="lightgray";
				var main=document.getElementById("main");
				var inner="<div id='choose'><p>운동을 선택하세요</p>";
				
			}
		</script>
	</body>
</html>