<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>로그인 | WoW</title>
		<link rel="stylesheet" href="style_log.css">
	</head>
	<body>
		
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<form method="post" action="login.do">
				<input type="text" name="id" placeholder="아이디">
				<input type="password" name="pwd" placeholder="비밀번호">
				<input type="submit" value="로그인">
			</form>
			<div id="more">
				<span>아이디/비밀번호를 잊으셨나요?</span><a href="#">아이디/비밀번호 찾기</a><br>
				<span>아직 회원이 아니신가요?</span><a href="register.jsp">회원가입</a>
			</div>
		</div>
	</body>
</html>