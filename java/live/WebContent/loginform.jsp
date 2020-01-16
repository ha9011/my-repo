<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	a{text-decoration:none}
	
 	
 	#rogo{width:200px;height:150;display:table;margin-left:auto;margin-right:auto;}
	#box{width:350px;height:300px;background:#F2F2F2;display:table;margin-left:auto;margin-right:auto;}
	
	
	#title{text-align:left;border-bottom:1px solid black;margin-left:20px;margin-right:20px;}
	#input{border:none;margin-left:20px;font-size:20px;font-weight:bold;}
	#login{color:white;width:80px;height:60px;background-color:#0B243B;}
	#search{text-align:center;}
	button{color:white;font-size:20px;font-weight:bold;width:150px;height:50px;background-color:#0B243B;display:table;margin-left:auto;margin-right:auto;}
	
	#hf{margin-top:20px;
	background-color:#0B243B;
	color:white;
}
	#boong{
	display: block;
	width: 100%;
	height: 200px;
	
	}
	#footer{margin-top:100px;
		width:100%;
		height:200px;
		text-align:center;
}
p{text-align:left;}
</style>

</head>
<body>


	<a href="main.jsp"><img id="rogo" alt="살다로고" src="./img/살다.png"></a>
	
	<div id=box>
	<div id= title>
	<h3>회원 로그인</h3>
	</div>

	<form action ="access" method="post"> <!--access(로그인)으로 이동-->
		&nbsp;
		&nbsp;
		&nbsp;
		<div id="input" style="display:flex">
			<div style="display:inline-block;text-align:right;">
			<div>
			ID&nbsp;&nbsp;<input type="text" name="id" id="idput" required></input>
			</div>
			
			<div>
			PW&nbsp;<input type="text" name="pw" required></input>
			</div>
			</div>
			
			<div style="display:inline-block;">
			<input id="login" type="submit" value="로그인">
			</div>
			
		</div>
		</form>
		&nbsp;
		&nbsp;
		&nbsp;
		<div id=search>
		&nbsp;
		<a href="SearchId.jsp">아이디찾기</a>&nbsp;|
		<a href="SearchPw.jsp">비밀번호 찾기</a><br>
		</div>
		&nbsp;
		&nbsp;
		<a href="signup.jsp"><button>회원가입</button></a>
		
	
	
	</div>
	<div id ="boong"></div>
	<div id ="hf">
	<div id="footer">	
	<br>
	<br>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;오시는 길 | 사이트맵  | 개인정보 처리 방침  | 영상정보처리기기 | 운영,관리방침이용약관 | 채용안내</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;업체명 : ㈜살아보다 사업자등록번호 : 111-11-11111
			주소 : 인천 남구 학익동 663-1 태승빌딩 5층 (1층 홈플러스) 전화번호 : 032-876-3332
			Copyrights(c) ㈜살아보다 </p>
			<h3>since 2020</h3>
	</div>
	</div>
<script>
	var frm=document.joinform;
	//frm.longth(); 활용해서 반복문으로 값을 입력했는지 확인
	
	
	
	
</script>



</body>
</html>