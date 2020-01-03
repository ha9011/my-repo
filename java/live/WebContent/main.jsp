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
	#middle{display:inline-block;color:white;width:100%;height:1000px;background-image:url("./img/main.jpg");background-repeat:no-repeat;background-size:100%;}
</style>


</head>
<body> 
		<!-- 로그인 안된 경우  -->
		<div id="header"><!-- 아이디 비번 로그인 회원가입 입력-->
		<img id="rogo" alt="살다로고" src="./img/살다.png">
			<a href="signup.jsp" class=log>회원가입</a>
			<a href="loginfrom.jsp"  class=log>로그인</a>
		</div>
		
		
		<div id=middle><!--중앙 박스-->
			<h1>어디로 여행 </h1><br><!-- 미들 타이틀-->
			<div id=date> <!-- 목적지, 체크인&아웃 , 인원 검색 창 , 버튼-->
				
				<input type="text" value="목적지">
				
			</div>
	
		</div>
			
</body>
<script>


</script>

</html>