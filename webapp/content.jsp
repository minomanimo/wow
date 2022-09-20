<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				display:inline-block;
				text-align:center;
			}
			#num{
				display:inline-block;
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
				padding-bottom:10px;
			}
			#comments{
				border-top:1px solid gray;
			}
			#co{
				list-style:none;
				border-bottom:1px solid lightgray;
				padding:5px;
				padding-left:60px;
			}
			#comments a{
				text-decoration:none;
				color:gray;
				font-size:0.8em;
				display:block;
			}
			.rewrite textarea{
				width: 90%;
				height: 40px;
    			padding: 15px;
    			font-size: 1.1em;
    			resize: none;
    			display:block;
			}
			.rewrite input{
				width:60px;
				height:30px;
				font-weight:bold;
				border-radius:5px;
				border:0;
				cursor:pointer;
				margin-top:10px;
			}
			.rewrite input[type="submit"]{
				background-color:#3BA683;
				color:white;
			}
			.rewrite{
				display:none;
				padding:10px;
			}
			#re{
				list-style:none;
				border-bottom:1px solid lightgray;
				padding:10px;
			}
			#re span{
				width:40px;
				display:inline-block;
				margin-left:60px;
				color:gray;
			}
			#ud{
				float: right;
   				cursor: pointer;
   				text-align:right;
   				font-size: 1.7em;
    			line-height: 5px;
			}
			#ud ul{
				font-weight:normal;
				list-style:none;
				font-size:0.9em;
				float:right;
				display:none;
				margin-top:6px;
			}
			#ud li{
				border-bottom:1px solid gray;
				background-color:white;
				padding:3px;
				font-size: 0.6em;
 				line-height: 21px;
			}
			#letter{
				padding:10px 0;
				padding-bottom:50px;
				line-height:30px;
			}
		</style>
	</head>
	<body>
	<%
		String userid;
		int admin;
		if(session.getAttribute("userid")!=null){
			userid=(String)session.getAttribute("userid");
			admin=(int)session.getAttribute("admin");
	%>
			<input type="hidden" id="userid" value="<%=userid %>">
	<%
		}
		if(request.getAttribute("success")!=null){
			if((int)request.getAttribute("success")==1){
	%>
				<script>alert("댓글 작성 성공");</script>
	<%	
			}else{
	%>		
				<script>alert("댓글 작성에 실패했습니다...");</script>
	<%	
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
			<div id="main">
				<div id="title">
					${title }
					<c:if test="${userid eq id or admin eq 1}">
					<div id="ud">
						...<br>
						<ul>
							<li>게시글 수정</li>
							<li>게시글 삭제</li>
						</ul>
					</div>
				</c:if>
				</div>
				<div id="id">${id }</div>
				<div id="time">${time }</div>
				
				<div id="content">
					<div id="letter">
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
					댓글 ${Clist.size() }
				</div>
				<div id="writeButton">
					댓글달기
				</div>
				<div id="write">
					<form method="post" action="comment.do">
						<input type="hidden" name="content_num" value="${num }">
						<input type="hidden" id="writeid" name="userid" value="${userid }">
						<input type="hidden" name="id" value="${id }">
						<input type="hidden" name="time" value="${time }">
						<textarea name="comment"></textarea>
						<input type="submit" value="작성">
						<input type="button" value="취소">
					</form>
				</div>
				<div id="comments">
					<input type="hidden" id="clist_size" value="${Clist.size() }">
					<ul>
						<c:forEach items="${Clist }" var="Clist">
							<li id="co">
								<div style="font-size:0.8em;">${Clist.getCommentId() }</div>
								${Clist.getComment() }<a id="${Clist.getNum() }" href="#">답글달기</a>
								<input type="hidden" class="clist_num" value="${Clist.getNum() }">
								<div id="rewrite_${Clist.getNum() }" class="rewrite">
									<form method="post" action="comment.do">
										<input type="hidden" name="content_num" value="${num }">
										<input type="hidden" id="writeid" name="userid" value="${userid }">
										<input type="hidden" name="id" value="${id }">
										<input type="hidden" name="time" value="${time }">
										<input type="hidden" name="recomment" value="1">
										<input type="hidden" name="comment_num" value="${Clist.getNum() }">
										<textarea name="comment"></textarea>
										<input type="submit" value="작성">
										<input type="button" value="취소">
									</form>
								</div>
							</li>
							<c:if test="${Rlist.size() ne 0 }">
								<c:forEach items="${Rlist }" var="Rlist">
									<c:if test="${Rlist.getCommentNum() eq Clist.getNum()}">
										<li id="re">
											<div style="font-size:0.8em; margin-left:100px;">${Rlist.getCommentId() }</div>
											<span>┗</span>${Rlist.getComment() }
										</li>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<script>
		//댓글
			$("#writeButton").click(function(){
				if($("#writeid").val()==""){
					alert("로그인이 필요합니다.");
				}else{
					$("#write").attr("style","display:block;");	
				}
			});
			$("#write input[type='button']").click(function(){
				$("#write").attr("style","");
			});
		//대댓글	
			var listsize=Number($("#clist_size").val());
			for(var i=0; i<listsize; i++){
				var num=document.getElementsByClassName("clist_num")[i].value;
				var rewrite="#rewrite_"+num;
				writeRe(num, rewrite);
			}
			function writeRe(num, rewrite){
				$("#"+num).click(function(){
					if($("#writeid").val()==""){
						alert("로그인이 필요합니다.");
					}else{
						$(rewrite).attr("style", "display:block;");
						console.log(num);
					}
				});
				$(rewrite+" input[type='button']").click(function(){
					$(rewrite).attr("style","");
				});
			}
		//좋아요	
			$("#like").click(function(){
				if($("#userid").val()==null){
					alert("로그인이 필요합니다");
				}else{
					var like=Number($("#like span").text())+1;
					$.ajax("like.do",{
						type : "POST",
						data : {
							like:like,
							islike:1,
							id:$("#id").text(),
							time:$("#time").text(),
							likedid:$("#userid").val()
						},
						success : function(response,status,xhr){
							if(response==1){
								alert("이미 좋아요 하셨습니다.");
							}else if(response==0){
								alert("이미 싫어요 하셨습니다.");
							}else if(response==-1){
								$("#like span").text(like);
							}
						},
						error : function(xhr, status, errorMessage){
							alert("좋아요 실패...");
						}
					});
				}
			});
		//싫어요
			$("#dislike").click(function(){
				if($("#userid").val()==null){
					alert("로그인이 필요합니다");
				}else{
					var dislike=Number($("#dislike span").text())+1;
					$.ajax("like.do",{
						type : "POST",
						data : {
							like:dislike,
							islike:0,
							id:$("#id").text(),
							time:$("#time").text(),
							likedid:$("#userid").val()
						},
						success : function(response, status, xhr){
							if(response==1){
								alert("이미 좋아요 하셨습니다.");
							}else if(response==0){
								alert("이미 싫어요 하셨습니다.");
							}else if(response==-1){
								$("#dislike span").text(dislike);
							}
						},
						error : function(xhr, status, errorMessage){
							alert("싫어요 실패...");
						}
					});
				}
			});
		//게시글수정
			$("#ud").click(function(){
				$("#ud ul").attr("style","display:block");
			});
			$("#content").click(function(){
				$("#ud ul").attr("style","");
			});
			$("#id").click(function(){
				$("#ud ul").attr("style","");
			});
			$("#time").click(function(){
				$("#ud ul").attr("style","");
			});
			$("#ud li:first-child").click(function(){
				var num=$("#write input:first-child").val();
				location.href="update.do?num="+num
			});
			$("#ud li:last-child").click(function(){
				var num=$("#write input:first-child").val();
				var bool=confirm("정말 삭제하시겠습니까?");
				if(bool){
					$.ajax("ud.do",{
						type:"POST",
						data:{
							num:num,
							update:0
						},
						async:true,
						success:function(resoponse, status, xhr){
							alert("삭제 완료");
							location.href="community.do";
						},
						error:function(xhr, status, errorMessage){
							alert("삭제 실패..");
						}
					});
				}
			});
		</script>
	</body>
</html>