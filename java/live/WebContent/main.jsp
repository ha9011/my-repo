<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
body{overflow:scroll;
	 }
	 

#header {

	
	width: 100%;
	height: 160px;
	border: none;
	text-align: right;
}

.log {
	text-align: right;
	display: inline;
	color:white;
	text-decoration:none;
}

.logout {
	text-align: right;
	display: none;
	border:none;
	font-size:20px;
	color:white;
	background-color:#0B243B;
	
	
}

#rogo {
	float: left;
	width: 230px;
	height: 150px;
}

#middleback {
	
	width: 100%;
	height: 700px;
	background-image: url("./img/main2.jpg");
	background-repeat: no-repeat;
	background-size: 100% 100%;
}

#middle {
	
	position: relative;
	color: white;
	width: 100%;
	height: 100%;
	
}

#searchBox {
	position: absolute;
	top: 40%;
	left: 30%;
	width: auto;
	height:70%;
	text-align:center;
}

#searchhousefrm {
	background-color: rgba(0, 0, 0, 0.4);
}

.jib {
	display: none;
	color:white;
	text-decoration:none;
	
}

.btn{border:none;
	font-size:20px;
	color:white;
	background-color:#0B243B;
}

.input{width:200px;
	   height:30px;
	   color:gray;
}
/* --------------------------------------------header & middle end---------------------------------------------------------------------------- */
#hf{margin-top:20px;
	background-color:#0B243B;
	color:white;
}

#home{width:100%;
	  height:50%;
	  border:1px solid black;
	  display:flex;
}
#review{width:47%;
		height:45%;
		border:1px solid black;
		margin: auto;
}

#topstar{width:47%;
		height:45%;
		border:1px solid black;
		margin: auto;
}
#footer{margin-top:100px;
		width:100%;
		height:30%;
		text-align:center;
}

</style>




</head>


<body>
	<!-- 로그인 안된 경우  -->
	<div id="header">
		<!-- 아이디 비번 로그인 회원가입 입력-->
		<img id="rogo" alt="살다로고" src="./img/살다.png">
		 <button class="btn"><a href="signup.jsp" class=log>회원가입</a></button> 
		 <button class="btn"><a href="loginform.jsp"class=log>로그인</a></button>
		<!-- 호스트 로그인 된 경우 - 하동원  -->
		
		<button class=logout id=logout onclick="logout_session();">로그아웃</button> 
		<button class=logout onclick="mypage_session();">마이페이지</button>
		<button class ="btn"><a href="registHouse.jsp" class=jib>집등록</a></button>
	</div>




	<div id=middleback>
		<div id=middle>
			<!--중앙 박스(검색배경) -->
			
			<div id=searchBox>


				<div id=searchhousefrm>
					<!-- 체크박스, 검색어 입력 , 버튼, 달력-->
					<div><h1>어디로 여행가나요</h1></div>
					<br>
					<!-- 미들 타이틀-->
					<form action="searchHouse" method="get">
						<input class=input type="text" name="destination" placeholder="목적지"> 
						<input class=input type="date" name="checkin" placeholder="체크인"> 
						<input class=input type="date" name="checkout" placeholder="체크아웃"> 
						<input class=input type="text" name="person" placeholder="인원수">
						<button class="btn" type="reset">초기화</button>
						<button class="btn" type="submit">검색</button>
					</form>
				</div>

			</div>
		</div>
	</div>
	
	<div id ="hf">
	<div id ="home">
	
		<div id="review">
			<h1>후기 높은 숙소</h1>
		</div>
		
		<div id="topstar">
			<h1>별점 높은 숙소</h1>
		</div>
		
	</div>
	
	<div id="footer">
		<p>업체명 : ㈜살아보다 사업자등록번호 : 111-11-11111
			주소 : 인천 남구 학익동 663-1 태승빌딩 5층 (1층 홈플러스) 전화번호 : 032-876-3332
			Copyrights(c) ㈜살아보다 </p>
			<h3>since 2020</h3>
	</div>
	</div>	
			
			
			
			
</body>

<script>

//--------------평민호-----------------------------------------------------------------------------------------------------------
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
//--------민호----------------------------------------------------------------------------------------------------------------

//---------이예상-------------------------------------------------------------------------------------------------------------

//후기 높은 숙소 불러오기











//별점 높은 숙소 불러오기 








//---------이예상-------------------------------------------------------------------------------------------------------------


	
</script>

</html>