<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div{
	text-align: center;
}

</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<div>
<form action="joinfrm">
<h1> 회원가입 </h1>
<input type="text" name="id" placeholder="아이디 입력"><br>
<input type="text" name="pw1" placeholder="비밀번호 입력"><br>
<input type="text" name="pw2" placeholder="비밀번호 재입력"><br>
<input type="text" name="name" placeholder="이름 입력"><br>
<input type="text" name="email" placeholder="이메일 입력"><br>
<input type="text" name="phonenum" placeholder="전화번호 입력"><br>
<input type="radio" name="h_or_g" value="1">게스트
<input type="radio" name="h_or_g" value="2">호스트

<hr>
<button type="submit">회원가입</button> 
</form>
<button id="cancel">취소</button>
</div>


</body>
<script type="text/javascript">


</script>
</html>