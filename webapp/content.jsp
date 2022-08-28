<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>커뮤니티 | WoW</title>
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
			#logo a{
				text-decoration:none;
				color:black;
			}
			#logo{
				text-align:center;
			}
			#title{
				border-top:1px solid gray;
				border-bottom:1px solid gray;
				padding:10px;
				font-weight:bold;
				margin-top:10px;
			}
			#time{
				font-size:0.8em;
				color:gray;
			}
			#id{
				font-size:0.8em;
			}
			#content{
				border-bottom:1px solid gray;
				padding:20px;
			}
			#like{
				border-radius:20px;
				width:60px;
				background-color:#3BA683;
				display:inline-block;
				height:60px;
				line-height:30px;
				text-align:center;
				color:white;
				cursor:pointer;
			}
			#dislike{
				border-radius:20px;
				width:60px;
				background-color:gray;
				display:inline-block;
				height:60px;
				line-height:30px;
				text-align:center;
				color:white;
				cursor:pointer;
			}
			#writeButton{
				cursor:pointer;
				width:70px;
				background-color:#3BA683;
				margin:10px;
				border-radius:5px;
				color:white;
				padding:2px;
			}
			#write textarea{
				width: 90%;
				height: 40px;
    			padding: 15px;
    			font-size: 1.1em;
    			resize: none;
    			display:block;
			}
			#write input{
				width:60px;
				height:30px;
				font-weight:bold;
				border-radius:5px;
				border:0;
				cursor:pointer;
				margin-top:10px;
			}
			#write input[type="submit"]{
				background-color:#3BA683;
				color:white;
			}
			#write{
				display:none;
			}
			
		</style>
	</head>
	<body>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<div id="main">
				<div id="title">${title }</div>
				<div id="id">${id }</div>
				<div id="time">${time }</div>
				
				<div id="content">
					<div>
						${content }
					</div>
					<div style="text-align:center;">
						<div id="like">
							좋아요
							<span>${like }</span>
						</div>
						
						<div id="dislike">
							싫어요
							<span>${dislike }</span>
						</div>
					</div>
				</div>
			</div>
			<div id="comment">
				<div id="num">
				
				</div>
				<div id="writeButton">
					댓글달기
				</div>
				<div id="write">
					<form method="post" action="">
						<textarea name="comment"></textarea>
						<input type="submit" value="작성">
						<input type="button" value="취소">
					</form>
				</div>
			</div>
		</div>
		<script>
			$("#writeButton").click(function(){
				$("#write").attr("style","display:block;");
			});
			$("#write input[type='button']").click(function(){
				$("#write").attr("style","");
			});
			
			$("#like").click(function(){
				var like=Number($("#like span").text())+1;
				$.ajax("like.do",{
					type : "POST",
					data : {
						like:like,
						islike:1,
						id:$("#id").text(),
						time:$("#time").text()
					},
					success : function(response,status,xhr){
						$("#like span").text(like);
						
					},
					error : function(xhr, status, errorMessage){
						alert("좋아요 실패...");
					}
				});
			});
			$("#dislike").click(function(){
				var dislike=Number($("#dislike span").text())+1;
				$.ajax("like.do",{
					type : "POST",
					data : {
						like:dislike,
						islike:0,
						id:$("#id").text(),
						time:$("#time").text()
					},
					success : function(response, status, xhr){
						$("#dislike span").text(dislike);
					},
					error : function(xhr, status, errorMessage){
						alert("싫어요 실패...");
					}
				});
			});
		</script>
	</body>
</html>