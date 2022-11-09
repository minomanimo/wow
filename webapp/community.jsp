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
			if(session.getAttribute("success")!=null){
				int success=(int)session.getAttribute("success");
				if(success==1){
		%>
					<script>
						alert("작성완료");
					</script>
					
		<%
					session.removeAttribute("success");
				}else if(success==0){
		%>
					<script>
						alert("작성에 실패하였습니다");
					</script>
					
		<%
					session.removeAttribute("success");
				}
			}
		%>

		<div id="wrap">
			<div id="logo">
				<a href="index.jsp" style="display:inline-block">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<div id="write" style="cursor:pointer">글쓰기</div>
			<div id="search">
				<form method="get" action="searchCommu.do">
					<input type="text" name="search">
					<input type="submit" value="검색">
				</form>
			</div>
			<div id="menu">
				<a class="menu-trigger" href="#">
					<span></span>
					<span></span>
					<span></span>
				</a>
				<ul>
					<li><a href="community.do?category=popular">인기글</a></li>
					<li><a href="community.do?category=info">운동 정보글</a></li>
					<li><a href="community.do?category=free">자유 게시판</a></li>
					<li><a href="community.do?category=recom">보충제 추천</a></li>
				</ul>
				
				<div id="id">
			<%
					if(session.getAttribute("userid")!=null){
						String userid=(String)session.getAttribute("userid");
						int admin=(int)session.getAttribute("admin");
			%>
						<a href="myPage.do?userid=${userid }">마이 페이지</a>
			<%				
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
				<div id="new">${page }</div>
				<div id="list">
					<ul>
						<c:forEach items="${Alist }" var="Alist">
							<li><a href="content.do?id=${Alist.getId() }&time=${Alist.getTime() }"><span>${Alist.getId() }</span><span>${Alist.getTitle() }</span><span>${Alist.getTime() }</span><span>좋아요 ${Alist.getLikes() }</span></a></li>
						</c:forEach>
						<c:if test="${Alist.size() eq 0 }">
							<li>결과가 없습니다.</li>
						</c:if>			
					</ul>
				</div>
				<div id="page">
					<ul>
						<c:choose>
							<c:when test="${isSearch eq 1 }">
								<c:forEach begin="1" end="${nOfPage }" var="i">
									<c:choose>
										<c:when test="${currentPage eq i }">
											<li style="font-weight:bold; text-decoration:underline;">${i }</li>
										</c:when>
										<c:otherwise>
											<li><a href="searchCommu.do?search=${search }&currentPage=${i }">${i }</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach begin="1" end="${nOfPage }" var="i">
									<c:choose>
										<c:when test="${currentPage eq i }">
											<li style="font-weight:bold; text-decoration:underline;">${i }</li>
										</c:when>
										<c:otherwise>
											<li><a href="community.do?category=${category }&currentPage=${i }">${i }</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
						</c:choose>
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
			
			var menu=$(".menu-trigger");
			menu.each(function(){
				var $this=$(this);
				$this.on('click', function(){
					if($(this).attr('class')=='menu-trigger'){
						$("#menu ul").attr('style','display:inline-block;');
						$("#menu li").each(function(index){
							$(this).attr('style', 'display:block');
						});
					}else if($(this).attr('class')=='menu-trigger active'){
						$("#menu ul").attr('style','');
						$("#menu li").each(function(index){
							$(this).attr('style', '');
						});
					}
					$(this).toggleClass('active');
				});
			});
			$("#list span:nth-child(2)").each(function(){
				var title=this.innerText;
				
				if(title.length>30){
					var titlearr=title.split('');
					var newTitle="";
					for(var i=0; i<30; i++){
						console.log(titlearr[i]);
						newTitle+=titlearr[i];
						if(i==29){
							newTitle+="...";
						}
					}
					this.innerText=newTitle;
				}
			});
			
		</script>
	</body>
</html>