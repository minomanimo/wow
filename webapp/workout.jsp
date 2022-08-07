<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>운동 | WoW</title>
		<link href="style_w.css" rel="stylesheet">
	</head>
	<body>
		<div id="wrap">
		
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<div id="menu">
				<ul>
					<a href="#" onclick="showPart('all')"><li id="all">전체</li></a>
					<a href="#" onclick="showPart('chest')"><li id="chest">가슴</li></a>
					<a href="#" onclick="showPart('back')"><li id="back">등</li></a>
					<a href="#" onclick="showPart('shoulder')"><li id="shoulder">어깨</li></a>
					<a href="#" onclick="showPart('triceps')"><li id="triceps">삼두</li></a>
					<a href="#" onclick="showPart('biceps')"><li id="biceps">이두</li></a>
					<a href="#" onclick="showPart('leg')"><li id="leg">하체</li></a>
				</ul>
			</div>
			<div id="search">
				<form method="post" action="">
					<input type="text" name="search" id="searchWork" onkeydown="return searchKeyDown(event)" placeholder="운동 검색">
					<input type="button" value="검색" onclick="doSearch()">
				</form>
			</div>
			<div id="list">
				<ul>
					
				</ul>
			</div>
			<div id="explain">
				
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
			function showPart(part){
				var li=document.getElementById("menu").getElementsByTagName("li");
				for(var i=0; i<li.length; i++){
					li[i].style.backgroundColor="white";
					li[i].style.borderRadius="0px";
				}
				var selected=document.getElementById(part);
				selected.style.backgroundColor="lightgray";
				selected.style.borderRadius="5px";
				createXMLHttpRequest();
				var dataString="ShowPart?part="+part;
				XHR.onreadystatechange=handleStateChange;
				XHR.open("GET",dataString,true);
				XHR.send(null);
			}
			function handleStateChange(){
				if(XHR.readyState==4){
					if(XHR.status==200){
						var work=[];
						work=XHR.responseXML.getElementsByTagName("name");
						addWork(work);
					}
				}
			}
			function addWork(work){
				var ul=document.getElementById("list").getElementsByTagName("ul")[0];
				var data="";
				for(var i=0; i<work.length; i++){
					data+='<a href="#" onclick="getLinks(&quot;'+work[i].firstChild.data+'&quot;)"><li>'+work[i].firstChild.data+'</li></a>';
				}
				ul.innerHTML=data;
			}
			function doSearch(){
				createXMLHttpRequest();
				var name=document.getElementById("searchWork").value;
				var dataString="SearchWork?name="+name;
				XHR.onreadystatechange=handleStateChange2;
				XHR.open("GET",dataString,true);
				XHR.send(null);
			}
			function handleStateChange2(){
				if(XHR.readyState==4){
					if(XHR.status==200){
						var work=[];
						work=XHR.responseXML.getElementsByTagName("name");
						addWork(work);
					}
				}
			}
			function searchKeyDown(e){
				if(e.key=='Enter'){
					doSearch();
					return false;
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
			}
		</script>
	</body>
</html>