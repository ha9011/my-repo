<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
boby{background-color:#0B2161;}

</style>

</head>

<body>

<h1>아이디 찾기</h1>
<div>
	<form action="SearchId">
		
		<img id="rogo" alt="살다로고" src="./img/살다.png">
			<div id="main">
				<p>아이디 찾기|비밀번호 찾기</p>
				<h6>-이름과 이메일 주소를 입력 후 "아이디 찾기"버튼을 클릭해 주시면 아이디를 찾을 수 있습니다.</h6>
		
		
		
				<div id="middle">
					이름<input name = "name"><br>
					이메일<input name = "email"><br>
					<button>아이디찾기</button>
					<input type=button value="뒤로가기" onClick="history.back();">
				</div>
			</div>
	</form>	
	</div>

<div>${id}
</div>
</body>
</html>