<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	
	#rogo{width:200px;height:150;display:table;margin-left:auto;margin-right:auto;}
	#main{width:500px;height:400px;background:#F2F2F2;display:table;margin-left:auto;margin-right:auto;text-align:center;}
	button{background-color:#0B243B;color:white;width:100px;height:60px;font-weight:bold;}
	#button{background-color:#0B243B;color:white;width:80px;height:60px;font-weight:bold;}
	#middle{border:none;margin-left:20px;font-size:20px;font-weight:bold;}
	

</style>

</head>

<body>
<a href="main.jsp"><img id="rogo" alt="살다로고" src="./img/살다.png"></a>
<div id="main">

	<form action="SearchId">

			<div>
				<a href="searchId.jsp">아이디 찾기|</a>
				<a href="searchPw.jsp">비밀번호 찾기</a>
				<h4>이름과 이메일 주소를 입력 후 "아이디 찾기"버튼을 클릭해 주시면 아이디를 찾을 수 있습니다.</h6>

		
				<div id="middle">
					이름<input name = "name"><br>
					이메일<input name = "email"><br>
				</div>
					&nbsp;
				    &nbsp;
				<div>
					<button id="open">아이디찾기</button>
					<input id="button" type=button value="뒤로가기" onClick="history.back();">
				</div>
				<div id="findid">찾는 ${id}
				</div>
			</div>
	</form>	
</div>


</body>

</html>