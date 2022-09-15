<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>마이 페이지 | WoW</title>
		<style>
			*{
				margin:0;
				padding:0;
			}
			#wrap{
				width:80%;
				margin:0 auto;
			}
			#logo{
				text-align:center;
			}
			a{
				text-decoration:none;
				color:black;
			}
			#write{
				float:left;
				background-color:#ababc7;
				font-size:0.9em;
				padding:3px;
				border-radius:4px;
			}
			#write:hover{
				background-color:#9a9abc;
			}
			#search{
				float:right;
			}
			li{
				list-style:none;
			}
			#menu li{
				display:inline-block;
				margin:0 6%;
			}
			#menu ul{
				display:inline-block;
				width:80%;
			}
			#id{
				display:inline-block;
				width:16%;
				text-align:right;
			}
			#menu #id a{
				font-weight:normal;
				font-size:0.9em;
			}
			#menu{
				margin-top:30px;
				background-color:#3BA683;
				height:40px;
				line-height:40px;
				border-radius:3px;
				font-weight:bold;
				color:white;
			}
			
			#content{
				width:90%;
				margin:0 auto;
			}
			#list li{
				height:50px;
				line-height:50px;
				border-bottom:1px solid gray;
			}
			#list span:nth-child(2n-1){
				margin:0 2%;
				font-size:0.8em;
				display:inline-block;
				width:14%;
			}
			#list span:nth-child(2){
				display:inline-block;
				width:50%;
				margin-left:2%;
			}
			#list span:last-child{
				margin:0 2%;
				font-size:0.8em;
				display:inline-block;
			}
			#list span:nth-child(2):hover{
				text-decoration:underline ;
			}
			#page li{
				display:inline-block;
				margin:0 2%;
				font-size:0.8em;
			}
			#page{
				text-align:center;
				margin:15px auto;
			}
			#page a{
				color:gray;
			}
			#footer{
				border-top:1px solid black;
			}
			#page li:hover{
				text-decoration:underline;
			}
		</style>
	</head>
	<body>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp" style="display:inline-block">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			
			<div id="search">
				<form method="get" action="">
					<input type="text" name="search">
					<input type="submit" value="검색">
				</form>
			</div>
			<div id="menu">
				<ul>
					<li>마이 페이지</li>
					
				</ul>
			</div>
			<div id="content">
				<div id="new">내가 쓴 글</div>
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
									<li><a href="myPage.do?id=${Alist.id }&currentPage=${i }">${i }</a></li>
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
	</body>
</html>