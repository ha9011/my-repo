
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#main{
	margin-left:40px;

}
div {
	
	background-color: #F2F2F2;
	width: 500px;
	color: black;
}

hr {
	color: gray;
	width: 400px;
}
.btn{border:none;
	font-size:20px;
	color:white;
	background-color:#0B243B ;
}
#checkid {
	text-align: center;
}

#boot {
	align-content: center;
}
#boot{
	font-size: 20px; color : black;
	margin: auto;
	background-color:#F2F2F2;
}

#middle {
	width:600px;
	font-size: 20px; color : black;
	margin: auto;
	background-color:#F2F2F2;
}
#checkid{
font-size: 20px; color : black;
	margin: auto;
	background-color:#F2F2F2;
}
#boot{
	align-content:center;
}

#middle{
		margin:auto;
}
#rogo {
	margin-left:150px;
	width: 250px;
	height: 150px;
}


</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	
	<div id="middle">
		<form action="joinfrm">
			<div>
			<a href="main.jsp"><img id="rogo" alt="살다로고" src="./img/살다.png"></a>
			</div><br>
			<div id ="main">
			* 아이디 <br>
			<br>
			<input type="text" name="id" placeholder="아이디 입력" id="id"
				minlength="6" maxlength="20">
			<button type="button" class="btn" id="same">중복확인</button>
			<div id="checkid"></div>
			<hr>
			* 비밀번호<br>
			<br>
			<input type="password" name="pw1" id="pw1" minlength="3"
				maxlength="20" placeholder="비밀번호 입력"> <span
				id="alert-success"
				style="display: none; color: blue; font-weight: bold;">비밀번호가
				일치합니다.</span>
			<hr>
			* 비밀번호 확인 <br>
			<br> <input type="password" name="pw2" id="pw2" minlength="3"
				maxlength="20" placeholder="비밀번호 재입력"> <span
				id="alert-danger"
				style="display: none; color: #d92742; font-weight: bold;">비밀번호가
				일치하지 않습니다.</span>
			<hr>
			* 이름 <br>
			<br>
			<input type="text" name="name" placeholder="이름 입력">
			<hr>
			* 성별 <br>
			<br> <input type="radio" name="gender" value="1" checked>남자
			<input type="radio" name="gender" value="2">여자
			<hr>
			* 이메일 <br>
			<br>
			<input type="text" name="email" placeholder="이메일 입력">
			<hr>
			* 전화번호 <br>
			<br>
			<input type="text" name="phonenum" placeholder="전화번호 입력">
			<hr>
			<input type="radio" name="h_or_g" value="1" checked>게스트 <input
				type="radio" name="h_or_g" value="2">호스트

			<DIV ID="boot">
				<hr>
				<button type="submit" id="join" class="btn">회원가입</button>
				<button id="cancel" type="button" href="main화면으로 보내자" class="btn">취소</button>
			</DIV>
			</div>
		</form>

	</div>



</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#same").click(function() { //same 아이디를 가진 버튼 클릭시 펑션 열린다
		var cid = $("#id").val(); //cid에 id 아이디를 가진 벨류값 담고
		$.ajax({ // 에이작스 열고
			type : 'get', //타입은 get 
			url : "duplicateID", // restFul 방식
			data : {
				data : cid
			}, // cid를 data에 담는다 
			contentType : 'application/json; charset=UTF-8',
			datatype : "html", //datatype html

			//서블릿이 성공하면 다시 돌아오는것
			success : function(data) {
				console.log(data);
				if (data == "없음") {
					$("#checkid").html("사용가능한 아이디입니다.");

				} else {

					$("#checkid").html("이미 존재하는 아이디입니다.");

				}
			}

			,
			error : function(error) {
				console.log(error);
			}

		});

	})

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