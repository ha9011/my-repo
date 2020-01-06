<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

div {
	text-align: auto;
	background-color: #FFD1B7;
	width: 500px;
}

hr {
	color: gray;
	width: 400px;
}

#boot{align-content:center;}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

	<div>
		<form action="joinfrm">
			<h1>회원가입</h1>



			<pre>
* 아이디                <input type="text" name="id" placeholder="아이디 입력"
					minlength="6" maxlength="20"><button type="button" id="same">중복확인</button> 
				<hr>
* 비밀번호		<input type="password" name="pw1" id="pw1" minlength="3"
					maxlength="20" placeholder="비밀번호 입력">  <span
					id="alert-success"
					style="display: none; color: blue; font-weight: bold;">비밀번호가 일치합니다.</span>
				<hr>
* 비밀번호 확인		<input type="password" name="pw2" id="pw2" minlength="3"
					maxlength="20" placeholder="비밀번호 재입력">  <span
					id="alert-danger"
					style="display: none; color: #d92742; font-weight: bold;">비밀번호가 일치하지 않습니다.</span>
				<hr>
* 이름 			<input type="text" name="name" placeholder="이름 입력">
				<hr>
* 이메일		<input type="text" name="email" placeholder="이메일 입력">
				<hr>
* 전화번호		<input type="text" name="phonenum" placeholder="전화번호 입력">
				<hr>
			<input type="radio" name="h_or_g" value="1" >게스트     <input type="radio" name="h_or_g" value="2">호스트
</pre>
			<DIV ID="boot">
				<hr>
				<button type="submit">회원가입</button>
				<button id="cancel" type="button" href="main화면으로 보내자">취소</button>
			</DIV>
		</form>

	</div>
	


</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	
	var btn1=document.getElementById("same");
	
	btn1.addEventListener("click",Function({
		console.log("gg");
	}));




	$("#pw1").keyup(function() {
		var pwd1 = $("#pw1").val();
		var pwd2 = $("#pw2").val();
		if (pwd1 !== "" || pwd2 !== "") {
			if (pwd1 === pwd2) {
				$("#alert-success").css('display', 'inline-block');
				$("#alert-danger").css('display', 'none');
			} else {
				$("#alert-success").css('display', 'none');
				$("#alert-danger").css('display', 'inline-block');
			}
		}

	});
	$("#pw2").keyup(function() {
		var pwd1 = $("#pw1").val();
		var pwd2 = $("#pw2").val();
		if (pwd1 != "" || pwd2 != "") {
			if (pwd1 === pwd2) {
				$("#alert-success").css('display', 'inline-block');
				$("#alert-danger").css('display', 'none');
			} else {
				$("#alert-success").css('display', 'none');
				$("#alert-danger").css('display', 'inline-block');
			}
		}

	});
</script>

</html>
