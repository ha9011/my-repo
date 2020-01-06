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