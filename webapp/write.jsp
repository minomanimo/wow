<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>글쓰기 | WoW</title>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<style>
			*{
				margin:0;
				padding:0;
			}
			#wrap{
				width:80%;
				margin:0 auto;
			}
			select{
				width:100px;
				height:30px;
				display:block;
				margin-top:20px;
			}
			input[type="text"]{
				width:90%;
				height:40px;
				margin:20px 0;
				display:block;
				padding:0 10px;
			}
			input[type="button"]{
				width:80px;
				height:40px;
				border:0;
				border-radius:5px;
				font-weight:bold;
				float:right;
				margin:10px 5px;
				cursor:pointer;
			}
			input[type="submit"]{
				width:80px;
				height:40px;
				background-color:#3BA683;
				border:0;
				border-radius:5px;
				font-weight:bold;
				color:white;
				float:right;
				margin:10px 5px;
				cursor:pointer;
			}
			textarea{
				width:98%;
				height:600px;
				resize:none;
				padding:10px;
			}
			#footer{
				border-top:1px solid black;
				padding:10px;
			}
			form:after{
				content:"";
				display:block;
				clear:both;
			}
		</style>
	</head>
	<body>
		<%
			String userid=null;
			if(session.getAttribute("userid")==null){
		%>
				<script>
					alert("로그인이 필요합니다.");
					location.href="login.jsp";
				</script>
		<%		
			}else{
				userid=(String)session.getAttribute("userid");
			}
		%>
		<div id="wrap">
			<form method="post" action="write.do">
				<select name="category">
					<option value="">게시판 선택</option>
					<option value="info">운동 정보글</option>
					<option value="free">자유 게시판</option>
					<option value="recom">보충제 추천</option>
				</select>
				<input type="text" name="title" placeholder="제목을 입력해주세요.">
				<textarea rows="10" name="content" placeholder="내용을 입력해주세요." ></textarea>
				<input type="hidden" value="<%=userid %>" name="userid">
				<input type="button" value="취소" >
				<input type="submit" value="작성">
			</form>
			<div id="footer">
				<div id="logo">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</div>
			</div>
		</div>
		<script>
			$("input[type='button']").click(function(){
				location.href="community.do";
			});
			$("input[type='submit']").click(function(){
				if($("select").val()==""){
					alert("게시판을 선택해주세요.");
					return false;
				}if($("input[type='text']").val()==""){
					alert("제목을 입력해주세요.");
					return false;
				}if($("textarea").val()==""){
					alert("내용을 입력해주세요.");
					return false;
				}
			});
		</script>
	</body>
</html>