<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>커뮤니티 | WoW</title>
		<link rel="stylesheet" href="style_c.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
	<body>
		<%
			if(request.getAttribute("success")!=null){
				int success=(int)request.getAttribute("success");
				if(success==1){
		%>
					<script>
						alert("작성완료");
					</script>
					
		<%
					request.removeAttribute("success");
				}else if(success==0){
		%>
					<script>
						alert("작성에 실패하였습니다");
					</script>
					
		<%
					request.removeAttribute("success");
				}
			}
		
			
			 
		%>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<div id="write" style="cursor:pointer">글쓰기</div>
			<div id="search">
				<form method="get" action="">
					<input type="text" name="search">
					<input type="submit" value="검색">
				</form>
			</div>
			<div id="menu">
				<ul>
					<li><a href="#">인기글</a></li>
					<li><a href="#">운동 정보글</a></li>
					<li><a href="#">자유 게시판</a></li>
					<li><a href="#">보충제 추천</a></li>
				</ul>
				<div id="id">
			<%
					if(session.getAttribute("userid")!=null){
						String userid=(String)session.getAttribute("userid");
						int admin=(int)session.getAttribute("admin");
						if(admin==1){
			%>
							<a href="adminCommu.jsp">관리자 페이지</a>
			<%				
						}else{
			%>
							<a href="myPage.jsp">마이 페이지</a>
			<%				
						}
					}else{
			%>		
						<a href="login.jsp">
							로그인
						</a>
			<%
					}
			%>		
				</div>
			</div>
			<div id="content">
				<div id="new">최신글</div>
				<div id="list">
					<ul>
						<c:forEach items="${Alist }" var="Alist">
							<li><a href="content.do?id=${Alist.getId() }&time=${Alist.getTime() }"><span>${Alist.getId() }</span><span>${Alist.getTitle() }</span><span>${Alist.getTime() }</span><span>좋아요 ${Alist.getLikes() }</span></a></li>
						</c:forEach>			
					</ul>
				</div>
				<div id="page">
					<ul>
						<c:forEach begin="1" end="${nOfPage }" var="i">
							<c:choose>
								<c:when test="${currentPage eq i }">
									<li style="font-weight:bold; text-decoration:underline;">${i }</li>
								</c:when>
								<c:otherwise>
									<li><a href="community.do?currentPage=${i }">${i }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div id="footer">
				<div id="logo">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</div>
			</div>
		</div>
		<script>
			$("#write").click(function(){
				location.href="write.jsp";
			});
		</script>
	</body>
</html>