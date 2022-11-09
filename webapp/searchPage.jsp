<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>검색 | WoW</title>
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
				margin:20px 0;
			}
			#logo a{
				text-decoration:none;
				color:black;
			}
			#head{
			    background-color: #3BA683;
			    padding: 10px 30px;
			    color: white;
			    font-weight: bold;
			    font-size: 1.3em;
			    border-radius: 4px;
			}
			#body{
				padding:10px;
			}
			#body li{
				list-style:none;
			}
			#commu{
				border-bottom:1px solid gray;
				padding:10px 15px;
			}
			#p{
				border-bottom:1px solid gray;
				padding-bottom:10px;
			}
			#commu li{
				border-bottom:1px solid lightgray;
				
				padding:0 2%;
				padding-bottom:10px;
				padding-top:10px;
				padding-left:1%;
			}
			
			#work{
				padding:10px 15px;
				
			}
			#work p{
				border-bottom:1px solid gray;
				padding-bottom:10px;
			}
			#work li{
				padding-top:10px;
			}
			#list{
				float:left;
				width:40%;
			}
			#list li{
				background-color:lightblue;
				
				padding:10px;
				margin:10px;
				border-radius:6px;
			}
			#list li a{
				color:white;
				font-weight:bold;
				text-decoration:none;
				display:block;
				width:100%;
			}
			#explain{
				border-left:1px solid gray;
				width:56%;
				height:600px;
				float:right;
				padding:10px;
			}
			iframe{
				width:100%;
				max-width:640px;
				min-width:300px;
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
			<div id="head">
				<p>검색결과</p>
			</div>
			<div id="body">
				<div id="commu">
					<p id="p">커뮤니티</p>
					<ul>
						<c:forEach items="${commuList }" var="list">
							<li><a href="content.do?id=${list.getId() }&time=${list.getTime() }">${list.getTitle() }</a></li>
							
						</c:forEach>
					</ul>
				</div>
				<div id="work">
					<p>운동</p>
					<div id="list">
						<ul>
							<c:forEach items="${workList }" var="list">
								<li><a href="#" onclick="getLinks('${list}')">${list }</a></li>
							</c:forEach>
						</ul>
					</div>
					<div id="explain">
				
					</div>
				</div>
				
			</div>
		</div>
		<script>
		var XHR;
		function createXMLHttpRequest(){
			if(window.ActiveXObject){
				XHR=new ActiveXObject("Microsoft.XMLHTTP");
			}else if(window.XMLHttpRequest){
				XHR=new XMLHttpRequest();
			}
		}
		//=============유튜브 플레이어 삽입======================
		var tag=document.createElement("script");
		tag.src="https://www.youtube.com/iframe_api";
		var firstScriptTag=document.getElementsByTagName("script")[0];
		firstScriptTag.parentNode.insertBefore(tag,firstScriptTag);
		/*
		var player1;
		//<iframe>생성
		function onYouTubeIframeAPIReady(videoId){
			player1=new YT.Player('player1',{
				height:'270',
				width:'480',
				videoId:videoId,
				events:{
					'onReady':onPlayerReady,
					'onStateChange':onPlayerStateChange
				}
			});
		}*/
		
		//비디오플레이어가 준비되면 API가 이 함수를 호출
		function onPlayerReady(event){
			event.target.playVideo();
		}
		function onPlayerStateChange(event){
			
		}
		//DB에서 운동 설명, 유튜브 링크 받아오기
		function getLinks(name){
			createXMLHttpRequest();
			var dataString="GetLink?name="+name;
			XHR.onreadystatechange=handleStateChange3;
			XHR.open("GET",dataString,true);
			XHR.send(null);
		}
		function handleStateChange3(){
			if(XHR.readyState==4){
				if(XHR.status==200){
					var exp=XHR.responseXML.getElementsByTagName("exp")[0];
					var links=XHR.responseXML.getElementsByTagName("ytlink");
					addLinks(exp,links);
				}
			}
		}
		function addLinks(exp,links){
			var div=document.getElementById("explain");
			div.innerHTML="";
			if(exp.firstChild.data!='null'){
				div.innerHTML="<p>"+exp.firstChild.data+"</p>";
			}if(links[0].firstChild.data!='null'){
				div.innerHTML+="<div class='ytPlayer' data-url='"+links[0].firstChild.data+"'></div>";
			}if(links[1].firstChild.data!='null'){
				div.innerHTML+="<div class='ytPlayer' data-url='"+links[1].firstChild.data+"'></div>";
			}if(links[2].firstChild.data!='null'){
				div.innerHTML+="<div class='ytPlayer' data-url='"+links[2].firstChild.data+"'></div>";
			}
			var script=document.getElementsByTagName("script");
			if(script.length==1){
				var tag=document.createElement("script");
				tag.src="http://www.youtube.com/iframe_api";
				var firstScript=script[0];
				firstScript.parentNode.insertBefore(tag,firstScript);
			}
			var videos=document.getElementsByClassName("ytPlayer");
			for(var i=0; i<videos.length; i++){
				var player;
				var youtube=videos[i];
				var iframe=document.createElement("iframe");
				var getUrl=youtube.getAttribute("data-url");
				iframe.setAttribute("src","http://www.youtube.com/embed"+getUrl+"?&enablejsapi=1&html5-1");
				youtube.appendChild(iframe);
				player=new YT.Player(youtube,{
					width:'480',
					height:'270',
					videoId:getUrl	
				});
			}
			var iframe=document.getElementsByClassName("ytPlayer");
			for(var i=0; i<iframe.length; i++){
				var responseH=iframe[i].offsetWidth*0.5625;
				iframe[i].setAttribute("height",responseH);
				resize(iframe, i);
			}
			function resize(iframe, i){
				window.addEventListener("resize",function(){
					responseH=iframe[i].offsetWidth*0.5625;
					iframe[i].setAttribute("height",responseH);
				});
			}
		}
		
		
		</script>
	</body>
</html>