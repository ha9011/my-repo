<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>





</style>


</head>

<body>
	<div id="main">
	<form action="SearchPw">
		<h1>비밀번호 찾기</h1>
			<div id="input">
	
			아이디<input name ="id"><br>
			이름<input name ="name"><br>
			이메일<input name ="email"><br>
	
			<button>비밀번호 찾기</button>
			<input type=button value="뒤로가기" onClick="history.back();">
	
			</div>
	
	</form>
	</div>

<div>${pw}
</div>	
	
</body>
</html>