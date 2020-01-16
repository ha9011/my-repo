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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<body>
<a href="main.jsp"><img id="rogo" alt="살다로고" src="./img/살다.png"></a>
<div id="main">

	<form action="SearchPw">

			<div >
				<span><a href="SearchId.jsp">아이디 찾기</a></span>
				<span><a href="#">비밀번호 찾기</a></span>
				<h4>아이디,이름과 이메일 주소를 입력 후 "비밀번호 찾기"버튼을 클릭해 주시면 비밀번호를 찾을 수 있습니다.</h6>

		
				<div id="middle">
					아이디<input name ="id" id="id"><br>
			이름<input name ="name" id="name"><br>
			이메일<input name ="email" id="email"><br>
				</div>
					&nbsp;
				    &nbsp;
				<div>
					<button type="button" id="find">비밀번호 찾기</button>
					<input id="button" type=button value="뒤로가기" onClick="history.back();">
				</div>
				<div id="findpw">
				</div>
			</div>
	</form>	
</div>
</body>

<script type="text/javascript">

$("#find").click(function() { //find 아이디를 가진 버튼 클릭시 펑션 열린다
	
	
	var dummy=[];
	var id = $("#id").val(); //name에 id 아이디를 가진 벨류값 담고
	var name=$("#name").val();
	var email=$("#email").val();
	
	dummy.push(id);
	dummy.push(name);
	dummy.push(email);
	
	console.log(dummy);
	var result=JSON.stringify(dummy);
	
	$.ajax({ // 에이작스 열고
		type : 'get', //타입은 get 
		url : "SearchPw", // restFul 방식
		data : {data : result}, // cid를 data에 담는다 
		contentType : 'application/json; charset=UTF-8',
		datatype : "json", //datatype html

		
		//서블릿이 성공하면 다시 돌아오는것
		success : function(data) {
			console.log(data);
			if (data == "") {
				console.log(data);
				$("#findpw").html(data);
				 

			} else {
				console.log(data);
				$("#findpw").html(data);

			}
		}

		,
		error : function(error) {
			console.log(error);
		}

	});

})




</script>
</html>