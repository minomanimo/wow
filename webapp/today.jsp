<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>투데이 | WoW</title>
		<link rel="stylesheet" href="style_t.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
	<body>
	<%
		String id=null;
		if(session.getAttribute("userid")==null){
	%>
			<script>
				alert("로그인 후 이용하실 수 있습니다.");
				location.href="index.jsp";
			</script>
	<%		
		}else{
			id=(String)session.getAttribute("userid");
		}
		
		int num=0;
	%>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<div id="main">
				<p>오늘의 운동</p>
				<span>운동을 클릭하여 오늘 운동을 기록하세요!</span>
				<ul>
					<c:choose>
						<c:when test="${list.size() eq 0 }">
							<li>오늘 할 운동이 없습니다.</li>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list }" var="list">
								<li>${list.getName() }</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<c:forEach items="${list }" var="list">
				<div class="list" id="<%=num %>">
					<div id="name">${list.getName() }</div>
					<form method="post" action="today.do">
						<table>
							<tr>
								<th>Set</th>
								<th>Kg</th>
								<th>reps</th>
							</tr>
							
					<%
							HashMap<String, Routine> map=(HashMap<String, Routine>)request.getAttribute("map");	
							ArrayList<Routine> list=(ArrayList<Routine>)request.getAttribute("list");
							
							int len=0;
							int[] kg=null;
							int[] reps=null;
							if(map.get(list.get(num).getName())!=null){
								len=map.get(list.get(num).getName()).getSetsarr().length;
								kg=map.get(list.get(num).getName()).getKgarr();
								reps=map.get(list.get(num).getName()).getRepsarr();
								
							}
							request.setAttribute("kg",kg);
							request.setAttribute("reps", reps);
							
							if(map.get(list.get(num).getName())!=null){
					%>
								<c:forEach begin="1" end="${list.getSets() }" var="i">
									<tr>
										<td>${i }<input type="hidden" name="sets${i }" value="${i }"></td>
										<td><input type="text" name="kg${i }" value="${kg[i-1] }"></td>
										<td><input type="text" name="reps${i }" value="${reps[i-1] }"></td>
									</tr>
								</c:forEach>	
					<%			
							}else{
					%>
								<c:forEach begin="1" end="${list.getSets() }" var="i">
									<tr>
										<td>${i }<input type="hidden" name="sets${i }" value="${i }"></td>
										<td><input type="text" name="kg${i }" value="${list.getKg() }"></td>
										<td><input type="text" name="reps${i }" value="${list.getReps() }"></td>
									</tr>
								</c:forEach>
					<%			
							}
					%>	
					
							
						</table>
						
						<input type="hidden" name="id" value="<%=id%>">
						<input type="hidden" name="name" value="${list.getName() }">
						<input type="hidden" name="day" value="${list.getDay() }">
						<input type="hidden" name="len" value="${list.getSets() }">
						<input type="submit" value="완료">
						<input type="button" value="취소">
					</form>
				</div>
				<%num++; %>
			</c:forEach>
		</div>
		<script>
			$("#main li").each(function(index){
				$(this).click(function(){
					$("#"+index).attr("style","display:block;");
					$("#main").attr("style","display:none;");
				});
			});
			$(".list input[type='button']").click(function(){
				var list=this.parentNode.parentNode;
				list.style.display="";
				$("#main").attr("style","");
			});
		</script>
	</body>
</html>