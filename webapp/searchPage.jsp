<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>검색 | WoW</title>
	</head>
	<body>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp" style="display:inline-block">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<div id="head">
				<p>검색결과</p>
			</div>
			<div id="body">
				<div id="commu">
					<p>커뮤니티</p>
					<ul>
						<c:forEach items="${commuList }" var="list">
							<li>${list.getContent() }</li>
						</c:forEach>
					</ul>
				</div>
				<div id="work">
					<p>운동</p>
					<ul>
						<c:forEach items="${workList }" var="list">
							<li><a href="workout.do?name=${name }">${list }</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</body>
</html>