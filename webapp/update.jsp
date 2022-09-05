<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>게시글 수정 | WoW</title>
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
		</style>
	</head>
	<body>
		<div id="wrap">
			<form method="get" action="ud.do">
				<input type="hidden" name="num" value="${num }">
				<input type="text" name="title" value="${title }">
				<textarea name="content">${content }</textarea>
				<input type="button" value="취소">
				<input type="submit" value="수정">
				
			</form>
		</div>
		<script>
			$("input[type='button']").click(function(){
				location.href="community.do";
			});
		</script>
	</body>
</html>