<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>운동목록</title>
		<style>
			#wrap{
				width:80%;
				margin:0 auto;
			}
			#menu li{
				list-style:none;
				display:inline-block;
				text-align:center;
				padding:10px;
				margin:0px 45px;
			}
			
			#menu li:hover{
				border-bottom:2px solid gray;
				padding-bottom:5px;
				transition:.1s;
			}
			a{
				text-decoration:none;
				color:black;
			}
			ul{
				margin:0 auto;
			}
			#search form{
				margin-left:76%;
			}
			#list li{
				border-bottom:1px solid gray;
				list-style:none;
				padding:10px;
				border-radius:10px 10px;
				background-color:#3BA683;
				color:white;
				font-weight:bold;
				margin:5px 0px;
			}
			#list li:hover{
				padding:15px;
				transition:.2s;
			}
			#title{
				width:74%;
			}
			#title th{
				width:14%;
			}
			#list{
				width:90%;
			}
			#list input{
				width:90%;
			}
			#add input{
				width:90%;
			}
		</style>
	</head>
	<body>
		<%
			if(session.getAttribute("admin")==null){
		%>
				<script>
					alert("접근권한이 없습니다.");
					location.replace("index.jsp");
				</script>
		<%
			}
		%>
		<div id="wrap">
			<a href="admin.jsp">관리자 페이지로 돌아가기</a>
			<div id="menu">
				<ul>
					<a href="#" onclick="showList('all')"><li>전체</li></a>
					<a href="#" onclick="showList('chest')"><li>가슴</li></a>
					<a href="#" onclick="showList('back')"><li>등</li></a>
					<a href="#" onclick="showList('shoulder')"><li>어깨</li></a>
					<a href="#" onclick="showList('triceps')"><li>삼두</li></a>
					<a href="#" onclick="showList('biceps')"><li>이두</li></a>
					<a href="#" onclick="showList('leg')"><li>하체</li></a>
				</ul>
			</div>
			<div id="search">
				<form method="post" action="">
					<input type="text" name="search" id="searchWork" onkeydown="return searchKeyDown(event)" placeholder="운동 검색">
					<input type="button" value="검색" onclick="doSearch()">
				</form>
			</div>
			<fieldset id="add">
				<legend>운동 추가하기</legend>
				<form method="post" action="listUpdate.jsp">
					<table>
						<tr>
							<th>부위</th>
							<th>이름</th>
							<th>VideoId1</th>
							<th>VideoId2</th>
							<th>VideoId3</th>
							<th>설명</th>
						</tr>
						<tr>
							<td><input type="text" name="part"></td>
							<td><input type="text" name="name"></td>
							<td><input type="text" name="ytlink1"></td>
							<td><input type="text" name="ytlink2"></td>
							<td><input type="text" name="ytlink3"></td>
							<td><input type="text" name="exp"></td>
							<td><input type="submit" value="추가하기" onclick="return insertOnClick()"></td>
						</tr>
					</table>
					<input type="hidden" name="insert" value="insert">
				</form>
			</fieldset>
			<div id="table">
				
			</div>
			
		</div>
		<script>
			var XHR;
			function createXMLHttpRequest(){
				if(window.ActiveXObject){
					XHR=new ActiveXObject("Microsoft.XMLHTTP");
				}
				if(window.XMLHttpRequest){
					XHR=new XMLHttpRequest();
				}
			}
			//운동목록 가져오기
			function showList(part){
				createXMLHttpRequest();
				XHR.onreadystatechange=handleStateChange;
				var dataString="ShowList?part="+part;
				XHR.open("GET",dataString,true);
				XHR.send(null);
			}
			function handleStateChange(){
				if(XHR.readyState==4){
					if(XHR.status==200){
						var part=[];
						var name=[];
						var ytlink1=[];
						var ytlink2=[];
						var ytlink3=[];
						var exp=[];
						part=XHR.responseXML.getElementsByTagName("part");
						name=XHR.responseXML.getElementsByTagName("name");
						ytlink1=XHR.responseXML.getElementsByTagName("ytlink1");
						ytlink2=XHR.responseXML.getElementsByTagName("ytlink2");
						ytlink3=XHR.responseXML.getElementsByTagName("ytlink3");
						exp=XHR.responseXML.getElementsByTagName("exp");
						getList(part,name,ytlink1,ytlink2,ytlink3,exp);
					}
				}
			}
			function getList(part,name,ytlink1,ytlink2,ytlink3,exp){
				var tab=document.getElementById("table");
				tab.innerHTML="<table id='title'><tr><th>부위</th><th>이름</th><th>VideoId1</th><th>VideoId2</th><th>VideoId3</th><th>설명</th></tr></table>";
				var data="";
				for(var i=0; i<part.length; i++){
					data+="<form method='post' action='listUpdate.jsp'><table id='list'><tr><td><input type='text' name='part' value='"+part[i].firstChild.data+
					"'></td><td><input type='text' name='name' value='"+name[i].firstChild.data+
					"'></td><td><input type='text' name='ytlink1' value='"+ytlink1[i].firstChild.data+
					"'></td><td><input type='text' name='ytlink2' value='"+ytlink2[i].firstChild.data+
					"'></td><td><input type='text' name='ytlink3' value='"+ytlink3[i].firstChild.data+
					"'></td><td><input type='text' name='exp' value='"+exp[i].firstChild.data+"'></td>"+
					"<td><input type='submit' value='수정하기'></td>"+
					"<td><input type='button' value='삭제하기' onclick='deleteList("+i+")'><input type='hidden' id='hidden"+i+"' value='"+
					name[i].firstChild.data+"'</td></tr></table></form>";
				}
				tab.innerHTML+=data;
			}
			//운동추가시 부위,이름 입력체크
			function insertOnClick(){
				var form=document.getElementsByTagName("form")[1];
				var part=form[0];
				var name=form[1];
				if(part.value==""){
					alert("부위를 입력하세요.");
					part.focus();
					return false;
				}if(name.value==""){
					alert("이름을 입력하세요.");
					name.focus();
					return false;
				}
			}
			//운동 삭제하기
			function deleteList(i){
				createXMLHttpRequest();
				var id="hidden"+i;
				var name=document.getElementById(id).value;
				var dataString="name="+name;
				XHR.onreadystatechange=handleStateChange2;	//운동삭제용handleStateChange
				XHR.open("POST","DeleteList",true);
				XHR.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				XHR.send(dataString);
			}
			function handleStateChange2(){
				if(XHR.readyState==4){
					if(XHR.status==200){
						var del=XHR.responseText;
						alert(del);
					}
				}
			}
		</script>
	</body>
</html>