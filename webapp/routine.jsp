<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>루틴 | WoW</title>
		<link rel="stylesheet" href="style_rout.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<style>
			
		</style>
	</head>
	<body>
		<%
			String userid=null;
			if(session.getAttribute("userid")!=null){
				userid=(String)session.getAttribute("userid");
			}else{
		%>
				<script>
					alert("로그인이 필요한 기능입니다.");
					location.href="index.jsp";
				</script>
		<%		
			}
		%>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
		<%
				request.setCharacterEncoding("utf-8");
				//String time=request.getParameter("time");
				String[] day=request.getParameterValues("day");
		%>
			<div id="header">
				<ul>
				<%
					for(int i=0; i<day.length; i++){
				%>
						<li id="<%=i %>">
							<a href='#' onclick="dayOnClick('<%=day[i]%>','<%=i %>')">
				<%
							out.print(day[i]);
				%>
							</a>
						</li>
				<%	
					}
				%>
				</ul>
			</div>
			<div id="main">
				<div id="choose">
					<p>1. 요일을 선택하세요.</p>
					<p>2. 운동을 선택하세요.</p>
					<ul>
						<li><a href="#" id="part1" onclick="showPart('all')">전체</a></li>
						<li><a href="#" id="part2" onclick="showPart('chest')">가슴</a></li>
						<li><a href="#" id="part3" onclick="showPart('back')">등</a></li>
						<li><a href="#" id="part4" onclick="showPart('shoulder')">어깨</a></li>
						<li><a href="#" id="part5" onclick="showPart('triceps')">삼두</a></li>
						<li><a href="#" id="part6" onclick="showPart('biceps')">이두</a></li>
						<li><a href="#" id="part7" onclick="showPart('leg')">하체</a></li>
					</ul>
					<div id="list">
						<ul>
												
						</ul>
					</div>
				</div>
				<form method="post" action="setRoutine.do">
					<p>3. 세트/중량/반복횟수를 입력하세요.</p>
					<p>4. 저장을 눌러 요일별 루틴을 완성하세요.</p>
					<ul id="put">
						<li id="plus">+</li>
						
					</ul>
					<input type="hidden" id="len" name="len" value="">
					<input type="hidden" name="id" value="${userid }">
					<input type="hidden" id="day" name="day" value="">
					<input type="hidden" id="arr" name="arr">
					<input type="submit" value="저장" onclick="return submitClick()">
					<input type="button" value="초기화">
				</form>
			</div>
		</div>
		<script>
			function dayOnClick(day, i){
				var li=document.getElementById(i);
				var lis=document.getElementsByTagName("li");
				for(var i=0; i<lis.length; i++){
					lis[i].style.backgroundColor="white";
				}
				li.style.backgroundColor="lightgray";
				$("#day").val(day);
				$("#put").html("<li id='plus'>+</li>");	//리스트 초기화
				num=1;									//리스트 길이
				arr=new Array();						//배열 초기화
			}
			var drag;
			function showPart(part){
				if($("#day").val()!=""){
					$.ajax({
						url:"ShowPart",
						method:"POST",
						data:{"part":part},
						async:true,
						success:function(response, status, xhr){
							var name=response.getElementsByTagName("name");
							var ul=document.getElementById("list").getElementsByTagName("ul")[0];
							ul.innerHTML="";
							for(var i=0; i<name.length; i++){
								ul.innerHTML+="<li draggable='true' class='drag'>"+name[i].firstChild.data+"</li>";
							}
							drag=document.getElementsByClassName("drag");
							dragEvent(drag);
						},
						error:function(xhr, status, errorMessage){
							alert("운동 불러오기 실패..");
						}
					});
				}
			}
			//드래그 앤 드롭 처리 
			
			function dragEvent(drag){
				for(var i=0; i<drag.length; i++){
					drag[i].addEventListener("dragstart",function(e){
						e.dataTransfer.setData("data",this.innerHTML)
						
					});
					
				}
			}
			
			var put=document.getElementById("put");
			var num=1;		//리스트 길이값
			var arr=new Array();
			
			put.addEventListener("dragover",function(e){
				
				e.preventDefault();
				//e.setAttribute("style","opacity:0.5");
				
			});
			put.addEventListener("drop",function(e){
				e.preventDefault();
				
				var plus=document.getElementById("plus");
				if(plus!=null){
					plus.remove();		//리스트 추가 시 +내용 없애기
				}
				var data=e.dataTransfer.getData("data")
				put.innerHTML+="<li id='drop' value='"+data+"'>"+data+
				"<div id='input'>세트<input type='text' name='sets"+num+"'>중량<input type='text' name='kg"+num+"'>횟수<input type='text' name='reps"+num+"'><div class='x'>X</div></div>"+"</li>";
				$("#len").val(num);
				arr.push(data);
				var str_arr=JSON.stringify(arr);
				$("#arr").val(str_arr);			//배열 히든태그에 추가
				num++;							//길이 늘려주기
				deleteLi();
			});
			
			$("#put").sortable({
				update : function(event, ui){
					console.log(event);
					console.log(ui);
					var page_value=new Array();
					$("#put li").each(function(){
						page_value.push($(this).attr("value"));
					});
					console.log(page_value);
					var str_value=JSON.stringify(page_value);
					$("#arr").val(str_value);
					
				}
			});
			//유효성 검사
			function submitClick(){
				var flag=true;
				$("form input[type='text']").each(function(){
					if($(this).val()==""){
						flag=false;
					}
				});
				if(flag==false){
					alert("세트/중량/반복횟수를 입력해주세요");
				}
				if($("form input[type='text']").length==0){
					alert("운동을 추가해 주세요");
					flag=false;
				}
				if($("#day").val()==""){
					alert("요일을 선택해 주세요");
					flag=false;
				}
				return flag;
			}
			$("form input[type='button']").click(function(){
				put.innerHTML="<li id='plus'>+</li>";
				$("#arr").val("");
				arr=new Array();		//배열 초기화
			});
			//리스트 삭제
			function deleteLi(){
				$(".x").each(function(index){
					$(this).click(function(){
						var lis=document.getElementById("put").getElementsByTagName("li");
						var data=lis[index].value;
						lis[index].remove();
						arr=new Array();
						$("#put li").each(function(){
							arr.push($(this).attr("value"));
						});
						var str_arr=JSON.stringify(arr);
						$("#arr").val(str_arr);
					});
				});
			}
			//이슈 1:리스트 삭제처리
			//이슈 2:sets kg reps input들 id 수정필요
		</script>
	</body>
</html>