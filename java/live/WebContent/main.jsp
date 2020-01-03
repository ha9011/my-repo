<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	#header{font-family:"문체부훈민정음";width:98%;height:160px;border:none;text-align:right;}
	.log{text-align:right;}
	#rogo{float:left;width:230px;height:150px;}
	#middleback{width:100%;height:300px;background-image:url("./img/main.jpg");background-repeat:no-repeat;background-size:100% 100%;}
	#middle{position:relative; color:white;width:100%; height: 100%;  }
	#searchBox{position:absolute;top:40%;left:30%;width:auto;height:auto}
	#searchhousefrm{background-color: rgba(0, 0, 0, 0.4);}
</style>


</head>
<body> 
		<!-- 로그인 안된 경우  -->
		<div id="header"><!-- 아이디 비번 로그인 회원가입 입력-->
		<img id="rogo" alt="살다로고" src="./img/살다.png">
			<a href="signup.jsp" class=log>회원가입</a>
			<a href="loginfrom.jsp"  class=log>로그인</a>
		</div>
		
<<<<<<< HEAD
		<div id=middleback>
		<div id=middle><!--중앙 박스(검색배경) --> 
			<div id=searchBox>
				
			
				<div id=searchhousefrm> <!-- 체크박스, 검색어 입력 , 버튼, 달력-->
				<div>어디로 여행 </div><br><!-- 미들 타이틀-->
				<form action="" method="get">
					<input type="text" name="destination" placeholder="목적지">
					<input type="date" name="checkin" placeholder="체크인">
					<input type="date" name="checkout" placeholder="체크아웃">
					<input type="text" name="destination" placeholder="목적지">
					<button type="reset">초기화</button>
					<button type="submit">검색</button>
				</form>
				</div>
=======
		
		<div id=middle><!--중앙 박스-->
			<h1>어디로 여행 </h1><br><!-- 미들 타이틀-->
			<div id=date> <!-- 목적지, 체크인&아웃 , 인원 검색 창 , 버튼-->
				
				<input type="text" value="목적지">
				
>>>>>>> 66eb53b256bc93ff15e9ffa3a0f4cb9f55f1a6af
			</div>
		</div>
		</div>
</body>
<script>


</script>

</html>