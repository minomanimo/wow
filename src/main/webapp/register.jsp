<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>회원가입 | WoW</title>
		<link href="style_r.css" rel="stylesheet">
	</head>
	<body>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<h1>회원가입</h1>
			<span id="info">'*'은 필수 입력 항목입니다.</span>
			<form method="post" action="join.do">
				<table>
					<tr>
						<td>* 아이디</td>
						<td><input type="text" name="id" id="id"><input type="button" id="checkid" value="중복확인" onclick="idCheck()"><input type="hidden" id="reid"><span id="idCheck"></span></td>
					</tr>
					<tr>
						<td>* 비밀번호</td>
						<td><input type="password" name="pwd"></td>
					</tr>
					<tr>
						<td>* 비밀번호 재입력</td>
						<td><input type="password" name="pwd_check" onkeyup="onKeyUp()"><span id="pwdCheck"></span></td>
					</tr>
					<tr>
						<td>* 이름</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>* 전화번호<span id="info">'-'없이 입력하세요</span></td>
						<td><input type="text" name="phone" maxlength="11"></td>
					</tr>
					<tr>
						<td>* 주민등록번호</td>
						<td><input type="text" id="birth1" name="birth1" maxlength="6">-<input type="password" id="birth2" name="birth2" maxlength="7"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="email1" name="email1">@<input type="text" id="email2" name="email2"></td>
					</tr>
				</table>
				<div>
					<input type="submit" value="회원가입" onclick="return necCheck()">
					<a href="login.jsp" id="cancel">취소</a>
				</div>
			</form>
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
			function idCheck(){
				createXMLHttpRequest();
				var url="idcheck.do";
				var dataString="id="+document.getElementById("id").value;
				
				XHR.onreadystatechange=handleStateChange;
				XHR.open("POST",url,true);
				XHR.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				XHR.send(dataString);
			}
			function handleStateChange(){
				if(XHR.readyState==4){
					if(XHR.status==200){
						var message=XHR.responseXML.getElementsByTagName("message")[0].firstChild.data;
						var isValid=XHR.responseXML.getElementsByTagName("isValid")[0].firstChild.data;
						setMessage(message,isValid);
						
					}
				}
			}
			function setMessage(message, isValid){
				var area=document.getElementById("idCheck");
				var color="red";
				if(isValid=="true"){
					color="green";
					var id=document.getElementById("id");
					id.readOnly=true;
					document.getElementById("reid").value=id;
				}
				area.style.color=color;
				area.innerHTML=message;
			}
			function necCheck(){
				var reId=document.getElementById("reid").value;
				var inputs=document.getElementsByTagName("input");
				if(inputs[0].value==""){
					alert("아이디를 입력해주세요");
					return false;
				}
				if(reId==""){
					alert("아이디 중복확인을 해주세요.");
					return false;
				}if(inputs[3].value==""){
					alert("비밀번호를 입력해주세요.");
					return false;
				}if(inputs[4].value==""){
					alert("비밀번호 재입력을 해주세요.");
					return false;
				}if(inputs[3].value!=inputs[4].value){
					alert("비밀번호가 일치하지 않습니다.");
					return false;
				}if(inputs[5].value==""){
					alert("이름을 입력해주세요.");
					return false;
				}if(inputs[6].value==""){
					alert("전화번호를 입력해주세요.");
					return false;
				}if(inputs[7].value=="" || inputs[8].value==""){
					alert("주민등록번호를 입력해주세요");
				}
			}
			function onKeyUp(){
				var pwd=document.getElementsByTagName("input")[3].value;
				var repwd=document.getElementsByTagName("input")[4].value;
				var pwdcheck=document.getElementById("pwdCheck");
				if (pwd!=repwd){
					pwdcheck.innerHTML="비밀번호가 일치하지 않습니다.";
					pwdcheck.style.color="red";
				}
				if(pwd==repwd){
					pwdcheck.innerHTML="√";
					pwdcheck.style.color="green";
				}
			}
			
		</script>
	</body>
</html>