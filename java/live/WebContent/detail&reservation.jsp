<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<style>
#header {
	width: 100%;
	height: 160px;
	border: none;
	text-align: right;
}

.log {
	text-align: right;
	display: inline;
	color: white;
	text-decoration: none;
}

.logout {
	text-align: right;
	display: none;
	border: none;
	font-size: 20px;
	color: white;
	background-color: #0B243B;
}

button {
	border: none;
	font-size: 20px;
	color: white;
	background-color: #0B243B;
}

#rogo {
	float: left;
	width: 250px;
	height: 150px;
}

body {
	margin: 1%;
}

#top {
	border: none;
	width: 100%;
}

#img {
	margin-bottom: 2%;
	width: 100%;
	height: 50%;
	overflow: hidden;
	border: none;
}

#detail {
	border: none;
	width: 100%;
	height: 250px;
	display: flex;
	margin-left: 10px;
	float: left;
}

.info {
	font-size: 20px;
	width: 400px;
	height: 250px;
	display: inline-block;
	margin-left: 70px;
	color: #8F9090;
}

.mainpic {
	width: 400px;
	height: 250px;
	display: inline-block;
}

#mainimg {
	width: 50%;
}

#imgs_wrap {
	margin: 0 auto;
	display: inline-block;
}
/*  #sldimg{margin-bottom:2%;width:70%;height:800px;overflow:hidden;border:none;} */
#subimg {
	border: 1px solid black;
	width: 100%;
	height: 40%;
	margin-bottom: 10px;
}

#middle {
	height: 100%;
	display: flex;;
	margin: 10px 0px 10px 0px;
	width: 100%;
	height: 50%;
	border: none;
}

#rebottom {
	margin: 5px 5px 5px 5px;
	border: 5px solid #4774B5;
	width: 50%;
	height: 100%;
}

#review {
	margin: 10px;
	width: 97%;
	height: 60%;
	overflow: hidden;
	border: none;
}

#bottom {
	margin: 10px;
	width: 97%;
	height: 400px;;
	overflow: hidden;
	border-bottom:3px solid #D0D1D2;
}

#rightpart {
	margin: 5px 5px 5px 5px;
	border: 1px solid black;
	width: 50%;
	height: 50%;
}

#reservation {
	width: 38%;
	height: 250px;
	border: 2px solid #D0D1D2;
	text-align: center;
	float: right;
	margin-top: 10px;
	margin-left: 200px;
	color: #525354;
}

#reple {
	margin: 5px 5px 5px 5px;
	width: 50%;
	height: 90%;
	border: 5px solid #4774B5;
}

.replee{
	margin-left:50px; 

}

#replebox {
	margin: 15px;
	border: none;
}

.inner {
	display: inline-flex;
}

#imgdetail {
	text-align: center;
}

.mySlides {
	margin: 0px 20px
}

.nextbtn {
	font-size: 150px;
	display: inline-block;
}
/* ---------------------------------------------------------------------------------------------------- */
#reserInfoP {
	width: 100%;
	display: flex;
}

form {
	font-size: 25px;
}

.date {
	margin-bottom: 20px;
	height: 20px;
}

#nolist {
	display: flex;
}
#aa{margin:15px;}

.request{width:100%;
		 height:100px; 
}
	

</style>

</head>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>


<body>
	<div id="header">
		<!-- 아이디 비번 로그인 회원가입 입력-->
		<a href="main"><img id="rogo" alt="살다로고" src="./img/살다.png"></a>
		<button class="btn">
			<a href="signup.jsp" class=log>회원가입</a>
		</button>
		<button class="btn">
			<a href="loginform.jsp" class=log>로그인</a>
		</button>
		<!-- 호스트 로그인 된 경우 - 하동원  -->

		<button class=logout id=logout onclick="logout_session();">로그아웃</button>
		<button class=logout onclick="mypage_session();">마이페이지</button>
		<button class="btn">
			<a href="registHouse.jsp" class=jib>집등록</a>
		</button>
	</div>

	<div>
		<div id="top">
			<div id="img">
				<div id="imgdetail">
					<div class="nextbtn">
						<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
					</div>
					<div id=imgs_wrap></div>
					<div class="nextbtn">
						<a class="next" onclick="plusSlides(1)">&#10095; </a>
					</div>
				</div>
			</div>
			<div id="reserInfoP">
				<div id="mainimg"></div>
				<!--메인이미지 및 정보를 슬라이드 밑으로 가져와서 예약이랑 묶음 -->

				<div id="reservation">

					<h1>날짜를 선택해주세요</h1>
					<form action="reservation">
						<img alt="예약달력" width="30px" height="30px" src="./img/date1.JPG"><input
							class="date" type="text" name="sdate" id="datepicker1">
						~~ <img alt="예약달력" width="30px" height="30px"
							src="./img/date2.JPG"><input class="date" type="text"
							name="edate" id="datepicker2">
						<button type="button" id="dtcommit">날짜확정</button>
						<br> 총액 : <input name="tprice" type="text" id="totalprice"
							placeholder="">만원<br> 인원 : <input name="tperson"
							type="number" id="person" value="">명 <input type="hidden"
							name="hostid" id="hostid" value=${findhostid}> <input
							type="hidden" name="guestid" id="guestid" value=${id}> <input
							type="hidden" name="regnum" id="regnum" value=${rgnum}><br>
						<button style="width: 200px">예약하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>




	<div id="middle">

		<div id="rebottom">
			<div id="bottom">
				<div id="aa">
					<h1>유의사항</h1>
					<h4>체크인:오후 4:00 - 오후 10:00</h4>
					<h4>체크아웃:오전 11:00</h4>
					<div id="nolist">
						<div>
							<img width="50px;" height="50px;" src="./img/no.JPG">흡연금지
						</div>
						&nbsp&nbsp &nbsp &nbsp &nbsp
						<div>
							<img width="50px;" height="50px;" src="./img/nopet.JPG">애완동물
							출입금지
						</div>
						&nbsp&nbsp &nbsp &nbsp &nbsp
						<div>
							<img width="50px;" height="50px;" src="./img/party.png">파티금지
						</div>
						&nbsp&nbsp &nbsp &nbsp &nbsp
					</div>
					<h3>예약 취소</h3>
					<h3>48시간 동안 취소 수수료 없음</h3>
					<h4>그 이후로 체크인 5일 전까지 취소하면 서비스 수수료를 제외한 전액이 환불됩니다.</h4>
				</div>
			</div>
			<div id="review">
				<h1>후기</h1>
			</div>
		</div>



		<div id="reple">
			<div id="replebox">
				<h1>문의사항</h1>
				<hr>
				<div id="showreple"></div>
				<!-- 여기에 댓글이 들어감 -->
				<br>

				<div id="rreple"></div>
				<!-- 삭제 체크중 -->

				<div id=replepaging></div>
				<hr>
				<div id="inputreple">
					<input type="text" id="input"
						placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다.">
					<button type="button" id="replepush">등록</button>
					<input id="chc" type="checkbox" name="비밀" value="비밀글">비밀글
				</div>
			</div>
		</div>
	</div>


	<script>


	
////////////페이지 부를때 바로 부르는 댓글

	for(i in ${reple}){
		console.log(${reple}.length);
		console.log(Math.ceil(${reple}.length/10));  // 페이지 수 // 10페이지당 1개
		
		
		
	   if(i <=9){  // 10페이지부터 보여주기  - 시작점  총 10개
		   var a = $('<div class="printreple"></div>');
		   
		   var b = $('<div class="reple">'+'댓글번호 :  '+${reple}[i][0]["RP_NUM"]+'아이디 :  '+${reple}[i][0]["RP_ID"]+${reple}[i][0]["RP_TIME"]+'<br>'
		   				+${reple}[i][0]["RP_CONTENT"]+'<br>'
		   				+'<button id="'+${reple}[i][0]["RP_NUM"]+'" class="rreplebtn">'+'답글'+'</button>'+'<br>'+'</div>');
		   				
		   var c = $('<div class="rreple" id="rreple'+${reple}[i][0]["RP_NUM"]+'"></div>');
		   var d = 	$('<div class="rreplecnt" id="rreplecnt'+${reple}[i][0]["RP_NUM"]+'"></div>');    // 댓글 쓰면 가장 마지막 페이지로 전환
		  
		   
		   c.append(d);			
		   
		   
//	  	   				+'<div class="rreple" id="rreple'+${reple}[i][0]["RP_NUM"]+'"><div><input type="text" id="rreplecontent'+${reple}[i][0]["RP_NUM"]'">'
//	  	   				+'<button class="rrepleput" id="'+${reple}[i][0]["RP_NUM"]+'">'+'등록'+'</button></div></div>'); 
		   		
		   console.log("--")
		   console.log(b);
		   
		   a.append(b);
		   a.append(c);	
		   $("#showreple").append(a);
	   }	   
	   
	}
	
	// 페이징 id = replepaging
	$("#replepaging").append($("<span class='pgbtn' name='Opage"+1+"'> << </span>"));
	$("#replepaging").append($("<span class='pgbtn' name='minus'> * </span>"));
	for(var i = 1 ; i <= Math.ceil(${reple}.length/10) ; i ++){
		if(i<=5){  
		$("#replepaging").append($("<span class='pgbtn' name='page"+i+"'> "+i+" </span>"));
		}  
	}
	$("#replepaging").append($("<span class='pgbtn' name='plus'> * </span>"));
	$("#replepaging").append($("<span class='pgbtn' name='Opage"+Math.ceil(${reple}.length/10)+"'> >> </span>"));
	$("#replepaging").children(":eq(2)").css("color","red");  // 처음 페이지만
	
	console.log("버튼테스트");
	console.log($("#replepaging").children());
	
	
	//페이지 클릭!!할때 이벤트변화
	let currentreplepage = 1;  // 현재 페이지
	let overMove=0;
	$("#replepaging").on("click",'.pgbtn',function(){
		
		var clickpage = $(this).attr("name");
		console.log(clickpage);
		console.log(clickpage);
		//currentreplepage 현재페이지
		if(clickpage==="plus"){
			if(currentreplepage===Math.ceil(${reple}.length/10)){
				
			}else{
				currentreplepage++;
			}
			
		}else if(clickpage==="minus"){
			if(currentreplepage===1){
				
			}else{
				currentreplepage--;
			}
			
			
		}else{
			if(clickpage.slice(0, 1)==="O"){
				console.log("ggggggggggggggggggg")
				overMove=1;
				currentreplepage = Number(clickpage.slice(5, clickpage.length));
			}else{
				console.log("hhhhhhhhhhhh")
				currentreplepage = Number(clickpage.slice(4, clickpage.length));
					
			}
			
		}
		console.log(currentreplepage)  // 현재 페이지;;
		
		
		var list = [];  // [현재 숙소 번호 , 현재 페이지]
		var pagergnum = ${rgnum};
		list.push(pagergnum);
		list.push(currentreplepage);
		
		var listString = JSON.stringify(list);
		$.ajax({
			type : 'get',
			url : "pagereple",
			data : {reple : listString},
			datatype:"json",
			
			//서블릿 성공시 돌아오는곳  $test[0][0]["H_RGNUM"];
			
			success:function(jsondata){
			
				console.log("paging 성공 AJAX")
				
				console.log(jsondata)
				var data = JSON.parse(jsondata);
				//비워야할곳 찾자...
				 $("#showreple").empty();
				
				// 해당 지역에 페이징한 데이터 넣기
				for(i in data){
					console.log(data.length);
					console.log(Math.ceil(data.length/10));  // 페이지 수 // 10페이지당 1개
					
					
					
				   if(i <=9){  // 10페이지부터 보여주기  - 시작점  총 10개
					   var a = $('<div class="printreple"></div>');
					   
					   var b = $('<div class="reple">'+'댓글번호 :  '+data[i][0]["RP_NUM"]+'아이디 :  '+data[i][0]["RP_ID"]+data[i][0]["RP_TIME"]+'<br>'
					   				+data[i][0]["RP_CONTENT"]+'<br>'
					   				+'<button id="'+data[i][0]["RP_NUM"]+'" class="rreplebtn">'+'답글'+'</button>'+'<br>'+'</div>');
					   				
					   var c = $('<div class="rreple" id="rreple'+data[i][0]["RP_NUM"]+'"></div>');
					   var d = 	$('<div class="rreplecnt" id="rreplecnt'+data[i][0]["RP_NUM"]+'"></div>');    // 댓글 쓰면 가장 마지막 페이지로 전환
					  
					   
					   c.append(d);			
					   
					   
//				  	   				+'<div class="rreple" id="rreple'+${reple}[i][0]["RP_NUM"]+'"><div><input type="text" id="rreplecontent'+${reple}[i][0]["RP_NUM"]'">'
//				  	   				+'<button class="rrepleput" id="'+${reple}[i][0]["RP_NUM"]+'">'+'등록'+'</button></div></div>'); 
					   		
					   console.log("--")
					   console.log(b);
					   
					   a.append(b);
						a.append(c);	
					   $("#showreple").append(a);
				   }	   
				   
					
					
				}
				
				// 버튼 모양 바꾸기 1,2,last-1, last 고정 나머지만 변동  // 현재 페이지
				//Math.ceil(${reple}.length/10) 라스트 페이지
				console.log("ajax 넘어오고나서  현재페이지 : " + currentreplepage)
				console.log("막페이지 : " + Math.ceil(${reple}.length/10))
				console.log("overmove : " + overMove)
				
				if(currentreplepage === 1 || currentreplepage === 2 ||  currentreplepage === Math.ceil(${reple}.length/10)-1 || currentreplepage === Math.ceil(${reple}.length/10)){
					if(currentreplepage===1){
						if(overMove===1){
							$("#replepaging").empty();  // 버튼 칸 비우고 
							$("#replepaging").append($("<span class='pgbtn' name='Opage"+1+"'> << </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='minus'> * </span>"));
							 
							$("#replepaging").append($("<span class='pgbtn' name='page"+currentreplepage+"'> "+currentreplepage+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage+1)+"'> "+(currentreplepage+1)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage+2)+"'> "+(currentreplepage+2)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage+3)+"'> "+(currentreplepage+3)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage+4)+"'> "+(currentreplepage+4)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='plus'> * </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='Opage"+Math.ceil(${reple}.length/10)+"'> >> </span>"));
							
						}
						$("#replepaging").children().css("color","black");
						$("#replepaging").children(":eq(2)").css("color","red");
					}else if(currentreplepage===2){
						$("#replepaging").children().css("color","black");
						$("#replepaging").children(":eq(3)").css("color","red");
					}else if(currentreplepage===Math.ceil(${reple}.length/10)){
						if(overMove===1){
							$("#replepaging").empty();  // 버튼 칸 비우고 
							$("#replepaging").append($("<span class='pgbtn' name='Opage"+1+"'> << </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='minus'> * </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage-4)+"'> "+(currentreplepage-4)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage-3)+"'> "+(currentreplepage-3)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage-2)+"'> "+(currentreplepage-2)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage-1)+"'> "+(currentreplepage-1)+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='page"+currentreplepage+"'> "+currentreplepage+" </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='plus'> * </span>"));
							$("#replepaging").append($("<span class='pgbtn' name='Opage"+Math.ceil(${reple}.length/10)+"'> >> </span>"));
							
						}
						$("#replepaging").children().css("color","black");
						$("#replepaging").children(":eq(6)").css("color","red");
					}else if(currentreplepage===Math.ceil(${reple}.length/10)-1){
						$("#replepaging").children().css("color","black");
						$("#replepaging").children(":eq(5)").css("color","red");
					}
				}else{ // 이놈일때만 페이지 버튼 이동  currentreplepage 이놈 기준으로 양 옆 +-2;
					
					$("#replepaging").empty();  // 버튼 칸 비우고 
					$("#replepaging").append($("<span class='pgbtn' name='Opage"+1+"'> << </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='minus'> * </span>"));
					 
					$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage-2)+"'> "+(currentreplepage-2)+" </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage-1)+"'> "+(currentreplepage-1)+" </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='page"+currentreplepage+"'> "+currentreplepage+" </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage+1)+"'> "+(currentreplepage+1)+" </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='page"+(currentreplepage+2)+"'> "+(currentreplepage+2)+" </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='plus'> * </span>"));
					$("#replepaging").append($("<span class='pgbtn' name='Opage"+Math.ceil(${reple}.length/10)+"'> >> </span>"));
					
					$("#replepaging").children(":eq(4)").css("color","red");  // 처음 페이지만
				
				}
				
				
				
			}	,
			error:function(error){
				console.log(error);
			}
			
			
		});
	})
	
	
	
	
	
	
	
	
	//대댓창 보여주는 펑션	AJAX	
	 $(document).on("click",".rreplebtn",function(){  //답글창 누르면 나옴   --> ajax로 바꿔줄것. 댓글 나오도록 하는 것 !!
		 	var rrpbtn = $(this).text();	

			var temp = $(this).attr('id');  // 해당 댓글 번호 
			console.log($(this).attr('id'));
			$('#rreple'+$(this).attr('id')).css("display", "block"); 
			
			
	 		if(rrpbtn==="답글" ){
	 			$.ajax({
					type : 'get',
					url : "showrreple",
					data : {replenum : temp},
					datatype:"json",
					
					//서블릿 성공시 돌아오는곳  $test[0][0]["H_RGNUM"];
					
					success:function(rreple){
					
						
					var obj=JSON.parse(rreple);
						
						console.log(typeof obj);
						console.log(obj);
						console.dir(obj);
						console.log("나와줘제발22");
						
						for(i in obj){
							
						   
						   
						   var a = $('<div class="replee"><img width="20px"height="20px" src="./img/reple.png">'+"&nbsp"+'댓글번호 :  '+obj[i][0]["RRP_NUM"]+"<br>"+'아이디 :  '+obj[i][0]["RRP_ID"]+'<br>'
								   +'             '+obj[i][0]["RRP_TIME"]+'<br>'
						   				+'<div class=innerreple>'+obj[i][0]["RRP_CONTENT"]+'<br>'+obj[i][0]["RRP_RP_NUM"]+'</div>'+'</div>')
								   
						   $("#rreplecnt"+temp).append(a);
						   
						   
						}
						
						var d= $('<input type="text" id="rreplecontent'+temp+'" ><button class="rrepleput" id="'+temp+'">'+'등록'+'</button>');
						$("#rreplecnt"+temp).after(d);
						
						//대댓글 디비에 보내기 성공했음	(ajax)
						$(".rreple").on('click','.rrepleput',function() {
							
							
							$("#rreplecnt").empty();   // rreplecnt <- 대댓글이 쌓이는 곳 // 댓글 쓰면 타 댓글 다 사라지고 보여짐 일단 몰라
							var temp =$(this).attr('id');
							var a=$("#rreplecontent"+temp).val();
							console.log(a);
							
							var rrepledata=[];
							
							
							rrepledata.push(a);
							rrepledata.push(temp);
							
							var result=JSON.stringify(rrepledata);
							
							$.ajax({
								type : 'get',
								url : "inputrreple",
								data : {rreple : result},
								datatype:"json",
								
								//서블릿 성공시 돌아오는곳  $test[0][0]["H_RGNUM"];
								
								success:function(rreple){
								
									$("#rreplecnt"+temp).empty();
								var obj=JSON.parse(rreple);
									
									console.log(typeof obj);
									console.log(obj);
									console.dir(obj);
									for(i in obj){
										console.log("나와줘제발");
										console.log(obj[i][0]["RRP_CONTENT"]);
									   
									   
									   var a = $('<div class="replee">'+'댓글번호 :  '+obj[i][0]["RRP_NUM"]+'아이디 :  '+obj[i][0]["RRP_ID"]+'<br>'
											   +'     '+obj[i][0]["RRP_TIME"]+'<br>'
									   				+'<div class=innerreple>'+obj[i][0]["RRP_CONTENT"]+'<br>'+obj[i][0]["RRP_RP_NUM"]+'</div>'+'</div>')
											   
									   $("#rreplecnt"+temp).append(a);
									   
									   console.log("test======temp : " + temp);
									   console.dir($("#rreplecnt"+temp));
									
									}
								}	,
								error:function(error){
									console.log(error);
								}
								
								
							});
							
						}) 
						
					}	,
					error:function(error){
						console.log(error);
					}
					
					
				});
	 			
	 			
	 			$(this).text("답글닫기");
	 		}else{
	 			
	 			 $("#rreplecnt"+temp).empty();
	 			 $("#rreplecontent"+temp).detach();
	 			$(".rrepleput").detach();
	 			
	 			
	 			$(this).text("답글");
	 		}
		   	
			
			
			 
			 
			 
	 });
	
	

	
 

	
	

//[댓글 입력]
$("#replepush").click(function() { //아이디 리플푸쉬를 갖고 있는 버튼 클릭시 클릭 이벤트를 준다
	console.log("총 페이지 : " + Math.ceil(${reple}.length/10));
	  $("#showreple").empty(); //쇼리플창  초기화 해주는 곳
	var type; //비밀인지 아닌지 타입을 담을 변수
	//
	if($("#chc").prop('checked')){ //체크박스 값을 담는다
	 type=1;
	}else{
	 type=0;	
	} 
	console.log($("#chc").prop('checked')); // 체크박스 동작 확인
	//
	
	var repledata = []; //리플데이터를 키 데이터 형식으로 넣어줄 틀
	var id1 = '${id}'; //리플 아이디 아마세션에서 뽑아온 이엘
	var temp = $("#input").val(); //리플컨텐츠
	var rep = $test[0][0]["H_RGNUM"]; //리플 방넘버
	
	console.log("=====================ajax")
	console.log($test)
	console.log(rep);
	console.log(id1);
	console.log(temp); // 만든 값들을 출력한다
	

	repledata.push(type); //배열에 필요한 값들 넣어주기
	repledata.push(rep);
	repledata.push(id1);
	repledata.push(temp);
	repledata.push(Math.ceil((${reple}.length+1)/10));
	console.log(repledata); // 마지막으로 만들어진 배열을 확인해본다
	
 	var result=JSON.stringify(repledata); //배열을 같은 오브잭트 형식을  스트링파이를  이용해서 스트링으로 바꾸고 리설트에 삽입 
	
 	$.ajax({//에이작스 시작 // 입력과 출력을 한번에 가능함 ??
		type : 'get',  
		url : "inputreple",
		data : {reple : result}, //리플 이엘에 리설트가 담아진다
		datatype:"json",    //여기까지 하고 서블릿으로 간다
							
							//서블릿 성공하고 여기로 돌아온다  $test[0][0]["H_RGNUM"];
		
		success:function(reple){   //서블릿에서의 과정들 성공후에 돌아온다 리설트리턴 값에는 객체화 된 엠리스트가 돌아온다 
			
			var result = JSON.parse(reple); //리서트 제이슨으로 파싱한다-->파싱은 스트링을 오브젝트 형태로 바꿔준다.   
			
			// **댓글 찍고, 마지막 페이지에서 보여줘야함!!!!
			
			console.log(typeof result); //리설트에 타입을 알아보기 위해
			console.log(result); // 단순 리설트 값
			console.dir(result); // 상세하게 뜯어보기
			for(i in result){ // i에 리설트를 다 담고
				console.log(result[i]);
			   
				   var a = $('<div class="printreple"></div>');
				   
				   var b = $('<div class="reple">'+'댓글번호 :  '+result[i][0]["RP_NUM"]+'아이디 :  '+result[i][0]["RP_ID"]+result[i][0]["RP_TIME"]+'<br>'
				   				+result[i][0]["RP_CONTENT"]+'<br>'
				   				+'<button id="'+result[i][0]["RP_NUM"]+'" class="rreplebtn">'+'답글'+'</button>'+'<br>'+'</div>');
				   				
				   var c = $('<div class="rreple" id="rreple'+result[i][0]["RP_NUM"]+'"></div>');
				   var d = 	$('<div class="rreplecnt" id="rreplecnt'+result[i][0]["RP_NUM"]+'"></div>');    // 댓글 쓰면 가장 마지막 페이지로 전환
				  
				   
				   c.append(d);			
				   
			   		
				   console.log("--")
				   console.log(b);
				   
				   a.append(b);
					a.append(c);	
				   $("#showreple").append(a);
			
			   
			}
			   
			   $("#replepaging").empty();  // 버튼 칸 비우고 
				$("#replepaging").append($("<span class='pgbtn' name='Opage"+1+"'> << </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='minus'> * </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='page"+(Math.ceil((${reple}.length+1)/10)-4)+"'> "+(Math.ceil((${reple}.length+1)/10)-4)+" </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='page"+(Math.ceil((${reple}.length+1)/10)-3)+"'> "+(Math.ceil((${reple}.length+1)/10)-3)+" </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='page"+(Math.ceil((${reple}.length+1)/10)-2)+"'> "+(Math.ceil((${reple}.length+1)/10)-2)+" </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='page"+(Math.ceil((${reple}.length+1)/10)-1)+"'> "+(Math.ceil((${reple}.length+1)/10)-1)+" </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='page"+Math.ceil((${reple}.length+1)/10)+"'> "+Math.ceil((${reple}.length+1)/10)+" </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='plus'> * </span>"));
				$("#replepaging").append($("<span class='pgbtn' name='Opage"+Math.ceil((${reple}.length+1)/10)+"'> >> </span>"));
				$("#replepaging").children().css("color","black");
				$("#replepaging").children(":eq(6)").css("color","red");
			   
			   
			
		}	,
		error:function(error){ //에러시 에러 뜨게하기
			console.log(error);
		}
		
		
	});
 })



   
   
   
   
   
   /////////////////////////////디테일 방정보 보여주기
   var $test=${result}; //프로덕트 엠엠에서 방정보를 담은 리설트 이엘 갖고 온것 
   
   var a = $('<div id="detail"></div>'); // DIV새엇ㅇ
   
   //console.log($test[0][0]["H_MAINPIC"]);
   var b = $('<div class="mainpic"><img width="400px" height="250" alt=사진없음 src="'+$test[0][0]["H_MAINPIC"]+'"></div>');
   var c = $('<div class="info"><img alt=집 width="30px" height="25px" src="./img/house.JPG">'+'&nbsp'+'&nbsp'+'주소:  '+$test[0][0]["H_ADDRESS"]+'  '+$test[0][0]["H_DETAILADD"]+'<br>'
         //+'숙박가능 날짜:  '+$test[0][0]["H_CHECKIN"]+'~'+$test[0][0]["H_CHECKOUT"]+'<br>'
         +'<img alt=돈 width="25px" height="20px" src="./img/money.JPG">' +'&nbsp'+'&nbsp'+'1박가격:  '+$test[0][0]["H_ONEPRICE"]+'만원'+'<br>'
         +'<img alt=사람 width="25px" height="30px" src="./img/person.JPG">' +'&nbsp'+'&nbsp'+'수용가능인원:  '+$test[0][0]["H_ATTENDANCE"]+'<br>'
         +'<img alt=주차장 width="30px" height="25px" src="./img/parking.JPG">'+'&nbsp'+'&nbsp' +'주차가능:  '+$test[0][0]["H_PARKABLE"]+'<br>'
         +'<img alt=방 width="30px" height="25px" src="./img/bed.JPG">'+'&nbsp'+'&nbsp'+'방갯수:  '+$test[0][0]["H_ROOMS"]+'&nbsp'
         +'& 침대수:  '+$test[0][0]["H_BEDROOMS"]+'<br>'
         +'<img alt=화장실 width="25px" height="30px" src="./img/tolilet.JPG">'+'&nbsp'+'&nbsp'+'화장실:  '+$test[0][0]["H_TOLILET"]+'<br>'
         +'<img alt=욕실 width="25px" height="30px" src="./img/bath.JPG">'+'&nbsp'+'&nbsp'+'욕실:  '+$test[0][0]["H_BATHROOMS"]+'<br>'+
         '</div>')
         
         
   $("#totalprice").attr('placeholder', 'PRICE PER night : '+$test[0][0]["H_ONEPRICE"] +"원"  ); 
   $("#person").attr('placeholder', '최대인원 : '+$test[0][0]["H_ATTENDANCE"] +"명"  ); // 넘길때 이벤트 줘야함.
   
   
   
   a.append(b);
   a.append(c);
   $("#mainimg").append(a); //완성 형태를 원하는 곳에 뿌려주기
   

   
   //인원 버튼 
   $("#person").keyup(function(){
	   console.log(typeof $test[0][0]["H_ATTENDANCE"])
	   if($(this).val()>Number($test[0][0]["H_ATTENDANCE"])){
		   alert("수용인원을 초과하였습니다. 최대인원 : "+$test[0][0]["H_ATTENDANCE"]);   
		   $(this).val("")	;
		   $(this).focus()	;
	   }else{
		      
	   }
	    
   })
  
   
   
   

	
	//하동원 detail 사진!
	
	//사진 넣기
	var a = $test[0][0]["H_DETAILPICS"];
	var jbSplit = a.split(',');
	console.log(jbSplit);	
	var result = jbSplit.slice(0, jbSplit.length-1 )
	console.log(result);	

	let indexpic = [0,1,2];
	 
	
	for(let i in result){
		if(i<=2){  // 3 이상일때
			$("#imgs_wrap").append( $('<div class="mySlides" style="display:inline-block"> <img width="500px" height="400px" src="'+result[i] +'" ></div>') );
				
		}else{
			$("#imgs_wrap").append( $('<div class="mySlides" style="display:none"> <img width="500px" height="400px" src="'+result[i] +'" ></div>')  );
			
		}
		
	}
	
	

	function readListURL(indexpic) {
		
		console.log("사진 변경 띠 " )
		
		let files1 = $(".mySlides");
		let total = files1.length;
		let filesArr = Array.prototype.slice.call(files1);  // 객체 -> 배열
		console.log(files1);
		
		console.log("========");
		
		
		filesArr.forEach((e,i)=>{
			
			if(i<3){
				console.log("존재 : " + i);
				$(e).css('display','inline-block');
				
			}else{
				console.log("존재x : " + i);
				$(e).css('display','none');
				
			}
		
		});
		
		
	}

	
	let plusSlides = (e)=>{
		console.log("화살표 눌렀습니다 : " + e)
		let files2 = $(".mySlides");   // myslides 모으기
		
		//console.log("list : " + list);

		console.log("files : " + files2);
		
		if(e === -1){
			console.log("처음 : " + indexpic);
			indexpic = indexpic.map((v)=>{
				
					
					$(files2[files2.length-1]).insertBefore(files2[0]);
				
			});
			console.log("변경 : " + indexpic);
			
			readListURL(indexpic);
			
		}else if(e === 1){
			console.log("tset");
			console.log($(files2[0]));
			console.log("처음 : " + indexpic);
			indexpic = indexpic.map((v)=>{
				
					$(files2[0]).insertAfter(files2[files2.length-1]);
				
			});
			console.log("변경 : " + indexpic);
			readListURL(indexpic);
		}
		
		console.log(e);
	}
	
	
	var disabledDays = [];  //"2020-01-15"
		
	$(document).ready(function(){
		$("#datepicker1").datepicker({
			
		 	dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		  
		    minDate:new Date(),
		    maxDate: new Date($test[0][0]["H_CHECKOUT"].substr(0,10)),
			beforeShowDay:function(date){
		        var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
		        return [ disabledDays.indexOf(string) == -1 ]
		    },
 		    onSelect: function(dateText) {  
		    	console.log(typeof dateText)
		    	console.log(dateText)  // 2020-01-21
		    	var select = new Date(dateText);
		    	
		    	if(a=="Invalid Date"){
		    		
		    	}else{
		    		$("#datepicker1").datepicker('option', 'minDate', new Date(dateText));
		    		$("#datepicker2").datepicker('option', 'minDate', new Date(dateText));
	    			
		    		
		    		for(i in disabledDays){
		    			var ss = new Date(disabledDays[i])
		    			console.log(select.getDate());
		    			console.log(ss.getDate());
		    			console.log(ss.getDate()-select.getDate())
		    			if(ss.getDate()-select.getDate()>0){ //양수일때  // 1일차이일때 이벤트도 줘야함.
		    				$("#datepicker1").datepicker('option', 'maxDate', new Date(disabledDays[i]));
		    				$("#datepicker2").datepicker('option', 'maxDate', new Date(disabledDays[i]));
		    				break;
		    			}else{ //음수일때
		    				
		    			}
		    			
		    		}
		    		
		    	}
		    	
 		    }



			});
		
		
	$("#datepicker2").datepicker({
			
		 	dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		  
		    minDate:new Date(),
		    maxDate: new Date($test[0][0]["H_CHECKOUT"].substr(0,10)),
			beforeShowDay:function(date){
		        var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
		        return [ disabledDays.indexOf(string) == -1 ]
		    },
 		    onSelect: function(dateText) {  
		    	console.log(dateText)
		    	var a = new Date(disabledDays[0]);
		    	
 		    }



			});
			
			
		
	});
	
	$('#dtcommit').on('click',function(){
		console.log("testtest");
		
		var sdate = $('#datepicker1').val();  
		var ddate = $('#datepicker2').val();  
		  
		var ar1 = sdate.split('-');
	    var ar2 = ddate.split('-');  
	    
	    var da1 = new Date(ar1[0], ar1[1], ar1[2]);
	    var da2 = new Date(ar2[0], ar2[1], ar2[2]);
		  
	    var dif = da2 - da1;
	    var cDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	    var cMonth = cDay * 30;// 월 만듬
	    var cYear = cMonth * 12; // 년 만듬
		
	    if(sdate && ddate){
			console.log(parseInt(dif/cDay))
			$("#totalprice").val(parseInt(dif/cDay)*$test[0][0]["H_ONEPRICE"]);
		 } 

	})
	
	
var listDate = [];
var checkeddate = ${checkDate};
for(i in checkeddate){
	
	var st = new Date(checkeddate[i][0]);

	var smonth = st.getUTCMonth() + 1; //months from 1-12
	var sday = st.getUTCDate();
	var syear = st.getUTCFullYear();
	if(smonth<10){
		st = syear + "-0" + smonth + "-" + sday;
			
	}else{
		st = syear + "-" + smonth + "-" + sday;
		
	}
	console.log("st : " +st)
	//
	var ed = new Date(checkeddate[i][1]);

	var emonth = ed.getUTCMonth() + 1; //months from 1-12
	var eday = ed.getUTCDate();
	var eyear = ed.getUTCFullYear();

	if(emonth<10){
		ed = eyear + "-0" + emonth + "-" + eday;
			
	}else{
		ed = eyear + "-" + emonth + "-" + eday;
		
	}
	
	console.log("ed : " +ed)
	//
	getDateRange(st,ed,disabledDays)	
}


	function getDateRange(startDate, endDate, listDate){

        var dateMove = new Date(startDate);
        var strDate = startDate;

        if (startDate == endDate){

            var strDate = dateMove.toISOString().slice(0,10);

            listDate.push(strDate);

        }else{

            while (strDate < endDate){

                var strDate = dateMove.toISOString().slice(0, 10);

                listDate.push(strDate);

                dateMove.setDate(dateMove.getDate() + 1);

            }

        }

        return listDate;

    };
   
	
	console.log(disabledDays);


	console.log("????");
	console.log(${findhostid})
	//----------------------------------------------------------------------------------------------------------------------------------------------
	
	
	var reviewdetail= ${reviewdetail};
	console.log(reviewdetail);

	 var tophouse = document.getElementById("review");


	 for(intest in reviewdetail ){
		 
			var a = $('<div class= "mainpic"style="display:flex; margin:10px;"><img class= "mainpicc" name = '+reviewdetail[intest][0]["H_RGNUM"]+' id ="pro" width=150px height=80px src = "'+reviewdetail[intest][0]["H_MAINPIC"]+'"></div>');
			
			var b = $('<div class= "request" >'+
				" |주소:"+reviewdetail[intest][0]["H_ADDRESS"]+"<br>"+
				" |상세주소:"+reviewdetail[intest][0]["H_DETAILADD"]+"<br>"+
				" |후기내용:"+reviewdetail[intest][0]["GRV_CONTENT"]+
				"★"+"("+reviewdetail[intest][0]["GRV_SCORE"]+")"+
				
				'</div>'); 
			
		$("#review").append(a);
			a.append(b);

			 $(".mainpicc").on('click', function() {

		         console.log("z");
		         console.log($(this).attr("name"));
		         location.href="detailregiinfo?rgnum="+$(this).attr("name");
		         
		      });
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>
	<!-- -------------------------------------------------------------------------------------------------------------------------------------------------- -->
	<script>//header 부분 
var id2="";


window.onload = function () {
	
	 var id1='<%=(String) session.getAttribute("id")%>'; 
	 console.log('${sessionScope.id}');
	 console.log(id1);
	 console.log("-------------")
	 var ocn=document.getElementsByClassName("log");


	 var ocn3=document.getElementsByClassName("logout")
	 
	 id2='<%=session.getAttribute("membertype")%>';
		console.log(id2);
		console.log("-------------")
		var ocn2 = document.getElementsByClassName("jib");

		if (id1 != "null") {
			console.log(id1);
			console.log(ocn);
			console.log("zzzzzzzzzzzzzzzzzzzzz");
			ocn[0].style.display = 'none';
			ocn[1].style.display = 'none';
			ocn3[0].style.display = 'inline';
			ocn3[1].style.display = 'inline';

		} //집등록 버튼 

		if (id2 == "1") {
			console.log("-------------")

			ocn2[0].style.display = 'none';
		} else if (id2 == "2") {
			console.log(ocn2);
			console.log(id2);
			console.log(typeof id2);
			ocn2[0].style.display = 'block';
		} else
			ocn2[0].style.display = 'none';

	}

	function logout_session() {
		console.log("logout");
		location.href = 'logout'; //url logout 쏴주기
	}
	
	function mypage_session() {
		
		alert("마이페이지로 이동");
		
		if(id2 =="1"){
			console.log("게스트입니다");
			location.href = "guestInfo";
		}else if (id2 == "2"){
			console.log("호스트입니다");
			location.href = "HostInfo";
		}else {
			console.log("어드민");
			location.href = "AdminInfo";
		}
		
	}


	
	

</script>



</body>
</html>




