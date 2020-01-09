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
#header {
	width: 98%;
	height: 160px;
	border: none;
	text-align: right;
}

.log {
	text-align: right;
	display: inline;
}

.logout {
	text-align: right;
	display: none;
}

#rogo {
	float: left;
	width: 230px;
	height: 150px;
}

#middleback {
	width: 100%;
	height: 300px;
	background-image: url("./img/main.jpg");
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
	height: auto;
}

#searchhousefrm {
	background-color: rgba(0, 0, 0, 0.4);
}

.jib {
	display: none;
}
</style>


</head>

</head>


<body>
	<!-- 로그인 안된 경우  -->
	<div id="header">
		<!-- 아이디 비번 로그인 회원가입 입력-->
		<img id="rogo" alt="살다로고" src="./img/살다.png"> <a
			href="signup.jsp" class=log>회원가입</a> <a href="loginform.jsp"
			class=log>로그인</a>
		<!-- 호스트 로그인 된 경우 - 하동원  -->
		<a href="registHouse.jsp" class=jib>집등록</a> 
		<button class=logout id=logout onclick="logout_session();">로그아웃</button> 
		<button class=logout onclick="mypage_session();">마이페이지</button>>
	</div>




	<div id=middleback>
		<div id=middle>
			<!--중앙 박스(검색배경) -->
			<div id=searchBox>


				<div id=searchhousefrm>
					<!-- 체크박스, 검색어 입력 , 버튼, 달력-->
					<div>어디로 여행</div>
					<br>
					<!-- 미들 타이틀-->
					<form action="searchHouse" method="get">
						<input type="text" name="destination" placeholder="목적지"> <input
							type="date" name="checkin" placeholder="체크인"> <input
							type="date" name="checkout" placeholder="체크아웃"> <input
							type="text" name="person" placeholder="인원수">
						<button type="reset">초기화</button>
						<button type="submit">검색</button>
					</form>
				</div>

			</div>
		</div>
	</div>

</body>
<script>
//평민호
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
		if(id2 =="1"){
			console.log("게스트입니다");
			location.href = "registHouse.jsp";
		}else if (id2 == "2"){
			console.log("호스트입니다");
			location.href = "HostInfojsp.jsp";
		}else {
			console.log("어드민");
			location.href = "signup.jsp";
		}
		
	}

	//하동원

	/*   $("#registHouse").click(Function() {    // [host] '집등록' 버튼 누를 경우 
	 location.href="registHouse.jsp";
	 });   */

	//이예상

	//민호
</script>

</html>