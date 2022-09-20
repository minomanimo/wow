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
					alert("로그인 후 이용하실 수 있습니다.");
					location.href="index.jsp";
				</script>
		<%		
			}
		%>
		<div id="wrap">
			<div id="logo">
				<a href="index.jsp" style="display:inline-block">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</a>
			</div>
			<c:if test="${day.size() ne 0 }">
				<div id="header">
					<ul>
					<c:forEach items="${day }" var="day">
							<li>
								<a href='#' onclick="dayOnClick(event)">
									${day }
								</a>
							</li>
					</c:forEach>
					</ul>
				</div>
			</c:if>
			<div style="position:relative"><span id="opencheck">요일 선택</span>
				<div id="daycheck">
					<form method="get" action="routine.do">
						<span>운동 요일을 선택하세요.</span>
						<label for="mon">월<input type="checkbox" id="mon" value="월" name="day"></label>
						<label for="tue">화<input type="checkbox" id="tue" value="화" name="day"></label>
						<label for="wed">수<input type="checkbox" id="wed" value="수" name="day"></label>
						<label for="thu">목<input type="checkbox" id="thu" value="목" name="day"></label>
						<label for="fri">금<input type="checkbox" id="fri" value="금" name="day"></label>
						<label for="sat">토<input type="checkbox" id="sat" value="토" name="day"></label>
						<label for="sun">일<input type="checkbox" id="sun" value="일" name="day"></label>
						<input type="submit" value="확인">
						<input type="button" value="취소">
					</form>
				</div>
			</div>
			
		
			<div id="main">
				<div id="choose">
					<p>1. 요일을 선택하세요.</p>
					<p>2. 운동을 선택하세요.</p>
					<ul id="part">
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
					<input type="hidden" id="id" name="id" value="${userid }">
					<input type="hidden" id="day" name="day" value="">
					<input type="hidden" id="arr" name="arr">
					<input type="submit" value="저장" onclick="return submitClick()">
					<input type="button" value="초기화">
				</form>
			</div>
		</div>
		<script>
			var num=0;		//리스트 길이값
			var arr=new Array();
			function dayOnClick(event){
				
				$("#header li").each(function(){
					this.style.backgroundColor="white";
				});
				
				
				var a=event.target;
				var day=a.innerText;
				a.parentNode.style.backgroundColor="lightgray";
				$("#day").val(day);
				$("#put").html("<li id='plus'>+</li>");	//리스트 초기화
				num=0;									//리스트 길이
				arr=new Array();						//배열 초기화
				//루틴 리스트 불러오기
				var id=$("#id").val();
				$.ajax({
					url : "getRoutine.do",
					method : "POST",
					async : true,
					data : {
						"day" : day,
						"userid" : id
					},
					success : function(data){
						if(data.getElementsByTagName("name").length!=0){
							$("#plus").remove();
						}
						var name=data.getElementsByTagName("name");
						var idx=data.getElementsByTagName("idx");
						var sets=data.getElementsByTagName("sets");
						var kg=data.getElementsByTagName("kg");
						var reps=data.getElementsByTagName("reps");
						var name_arr=new Array();
						var put=document.getElementById("put");
						for(var i=0; i<name.length; i++){
							put.innerHTML+="<li id='drop' value='"+name[i].firstChild.data+"'>"+name[i].firstChild.data+
								"<div class='input'>세트<input type='text' value='"
								+sets[i].firstChild.data+"'>중량<input type='text' value='"
								+kg[i].firstChild.data+"'>횟수<input type='text' value='"
								+reps[i].firstChild.data+"'><div class='x'>X</div></div></li>";
							name_arr.push(name[i].firstChild.data);
							num++;
						}
						$("#len").val(num);
						var str_name=JSON.stringify(name_arr);
						$("#arr").val(str_name);
						deleteLi();
					},
					error : function(log){
						console.log("오류발생 : "+log)
					}
				});
				
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
								ul.innerHTML+="<li draggable='true' id='drag' class='drag'>"+name[i].firstChild.data+"</li>";
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
						var clone=this.cloneNode(true);
						
						clone.setAttribute("style","position:absolute; top:0px; left:-400px;list-style:none; color:white; background-color:#3BA683; width:290px; height:50px; line-height:50px; border-radius:7px;")
						document.body.appendChild(clone);
						e.dataTransfer.setDragImage(clone,0,0);
					});
					
				}
			}
			
			var put=document.getElementById("put");
			
			
			put.addEventListener("dragover",function(e){
				
				e.preventDefault();
				this.setAttribute("style","background-color:lightgray");
				//e.setAttribute("style","opacity:0.5");
				
			});
			put.addEventListener("dragleave",function(e){
				e.preventDefault();
				this.setAttribute("style","");
			});
			put.addEventListener("drop",function(e){
				e.preventDefault();
				this.setAttribute("style","");
				var plus=document.getElementById("plus");
				if(plus!=null){
					plus.remove();		//리스트 추가 시 +내용 없애기
				}
				var data=e.dataTransfer.getData("data")
				put.innerHTML+="<li id='drop' value='"+data+"'>"+data+
				"<div class='input'>세트<input type='text'>중량<input type='text'>횟수<input type='text'><div class='x'>X</div></div></li>";
				
				arr=new Array();
				$("#put li").each(function(){
					arr.push($(this).attr("value"));
				});
				
				var str_arr=JSON.stringify(arr);
				$("#arr").val(str_arr);			//배열 히든태그에 추가
				num++;							//length값 올리기
				$("#len").val(num);
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
				if(flag){
					var n=1;
					var name=["sets","kg","reps"];
					$(".input").each(function(){
						var input=this.getElementsByTagName("input");
						for(var i=0; i<input.length; i++){
							var inputVal=input[i].value;
							var newInput=document.createElement("input");
							newInput.setAttribute("type","hidden");
							newInput.setAttribute("value",input[i].value);
							newInput.setAttribute("name",name[i]+n);
							$("#put").append(newInput);
						}
						n++;
					});
				}
				return flag;
			}
			$("#main input[type='button']").click(function(){
				put.innerHTML="<li id='plus'>+</li>";
				$("#arr").val("");
				arr=new Array();		//배열 초기화
			});
			//리스트 삭제
			function deleteLi(){
				$(".x").each(function(index){
					$(this).click(function(){
						var li=this.parentNode.parentNode;
						li.remove();
						arr=new Array();
						$("#put li").each(function(){
							arr.push($(this).attr("value"));
						})
						var str_arr=JSON.stringify(arr);
						$("#arr").val(str_arr)
						num--;
						$("#len").val(num);
					});
				});
			}

			
			
			
			$("#opencheck").click(function(){
				$("#daycheck").attr("style","display:block");
			});
			$("#daycheck input[type='button']").click(function(){
				$("#daycheck").attr("style","");
			});
		</script>
	</body>
</html>
