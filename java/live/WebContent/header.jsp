<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

</head>
<body>
	<c:if test="${id==null}">
		<form action="access" name="loginfrm" method="post">
        	
			아이디:<input type="text" name="id">
			비번:<input type="password" name="pw">
			<span>${msgAccess}</span>
			 
		</form>
	</c:if>	
	
</body>
</html>