<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>WoW | Workout anyWay</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
		<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
	<body>
		<div id="wrap">
			<div id="head">
				<div id="logo">
					<h1>WoW</h1>
					<p>Workout anyWay</p>
				</div>
				<ul>
					<li><a href="community.do">커뮤니티</a></li>
					<li><a href="workout.do">운동</a></li>
					<li><a href="routine.do">루틴</a></li>
					<li><a href="today.do">투데이</a></li>
				</ul>
			</div>
			<%
				if(session.getAttribute("userid")!=null){
					String userid=(String)session.getAttribute("userid");
					int admin=(int)session.getAttribute("admin");
			%>
					<div id="member">
						<span><%=userid %>님, 안녕하세요.</span>
						<form method="post" action="logout.do">
							<input type=submit value="로그아웃">
						</form>
			<%
						if(admin==1){
			%>
							<a href="admin.jsp" id="admin">관리자 페이지</a>
			<%
						}
			%>
					</div>
			<%		
				}else{
			%>
					<div id="member">
						<span>로그인을 하면 더 많은 기능을 이용할 수 있습니다.</span>
						<form method="post" action="login.jsp">
							<input type="submit" value="로그인">
						</form>
					</div>
			<%
				}
			%>
			
			<div id="search">
				<p>지금 운동에 관련된 정보를 찾아보세요!</p>
				<form method="get" action="searchPage.do">
					<input type="text" name="search" placeholder="검색">
					<input type="submit" value="검색">
				</form>
			</div>
			<div id="chart" style="width: 79vw; height: 60vh; min-width: 400px; min-height: 300px;"></div>
			<div id="recommend">
				<div id="player"></div>
			</div>
			<div id="community">
				<div id="commuhead">
					<span>커뮤니티 인기글</span>
					<a id="more" href="community.do">+</a>
				</div>
				<ul>
					<c:forEach items="${list }" var="list">
						<li><a href="content.do?id=${list.getId() }&time=${list.getTime() }">${list.getTitle() }</a></li>
					</c:forEach>
				</ul>
			</div>	
			
			<div id="footer">
				<h1>WoW</h1>
				<p>Workout anyWay</p>
			</div>
		</div>
		<script>
			//iframeAPI생성
			var tag=document.createElement("script");
			tag.src="http://www.youtube.com/iframe_api";
			var firstScript=document.getElementsByTagName("script")[0];
			firstScript.parentNode.insertBefore(tag,firstScript);
			//iframe만들기
			var player;
			function onYouTubeIframeAPIReady(){
				player=new YT.Player("player",{
					//width:'720',
					//height:'405',
					videoId:'9lsqux_WcBo'
				});
				var iframe=document.getElementById("player");
				
				var responseH=iframe.offsetWidth*0.5625;
				iframe.setAttribute("height",responseH);
				window.addEventListener("resize",function(){
					responseH=iframe.offsetWidth*0.5625;
					iframe.setAttribute("height",responseH);
				})
			}
			
			//chart
			$.ajax({
				url:"totalVol.do",
				method:"GET",
				async:true,
				success:function(data){
					var all=data.getElementsByTagName("all")[0];
					var my=data.getElementsByTagName("my")[0];
					getChart(all, my);
					
				},
				error:function(log){
					console.log(log);
				}
			});
			function getChart(all,my){
				var days=all.getElementsByTagName("today");
				var alltotalvol=all.getElementsByTagName("total");
				
				
				
				const Chart=toastui.Chart;
				var data=null;
				const el=document.getElementById("chart");
				if(my!=undefined){
					var mytotalvol=my.getElementsByTagName("total");
					data={
						categories:[
							days[0].firstChild.data,
							days[1].firstChild.data,
							days[2].firstChild.data,
							days[3].firstChild.data,
							days[4].firstChild.data,
							days[5].firstChild.data,
							days[6].firstChild.data
						],
						series:[
							{
								name:'평균',
								data:[
									Number(alltotalvol[0].firstChild.data),
									Number(alltotalvol[1].firstChild.data),
									Number(alltotalvol[2].firstChild.data),
									Number(alltotalvol[3].firstChild.data),
									Number(alltotalvol[4].firstChild.data),
									Number(alltotalvol[5].firstChild.data),
									Number(alltotalvol[6].firstChild.data)
								]
							},
							{
								name:'나',
								data:[
									Number(mytotalvol[0].firstChild.data),
									Number(mytotalvol[1].firstChild.data),
									Number(mytotalvol[2].firstChild.data),
									Number(mytotalvol[3].firstChild.data),
									Number(mytotalvol[4].firstChild.data),
									Number(mytotalvol[5].firstChild.data),
									Number(mytotalvol[6].firstChild.data)
								]
							}
						]
					}
				}else{
					data={
							categories:[
								days[0].firstChild.data,
								days[1].firstChild.data,
								days[2].firstChild.data,
								days[3].firstChild.data,
								days[4].firstChild.data,
								days[5].firstChild.data,
								days[6].firstChild.data
							],
							series:[
								{
									name:'평균',
									data:[
										Number(alltotalvol[0].firstChild.data),
										Number(alltotalvol[1].firstChild.data),
										Number(alltotalvol[2].firstChild.data),
										Number(alltotalvol[3].firstChild.data),
										Number(alltotalvol[4].firstChild.data),
										Number(alltotalvol[5].firstChild.data),
										Number(alltotalvol[6].firstChild.data)
									]
								}
							]
						}
				}
				const options={
					chart:{
						title:"일별 볼륨 그래프",
						width:'auto',
						height:'auto'
					},
					series:{
						
						eventDetectType:'grouped'
					},
					
				}
				const chart=Chart.lineChart({el,data,options});
				
			}
	
			
		</script>
	</body>
</html>
