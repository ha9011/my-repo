<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
body{display:table;margin-left:auto;margin-right:auto; }
	#header{width:1200px;height:300px;overflow:hidden;border:none;}
	#img{border:2px solid #0B3861;float:left;width:300px;height:280px;}
	#info{border:2px solid #0B3861;float:right;width:870px;height:280px;}
	
	#houseupload{border:1px solid black;width:1200px;height:700px;margin-bottom:20px;}
	#myhouselist{border:1px solid black;width:1200px;height:700px;margin-bottom:20px;}
	
	

</style>

</head>
<body>

<h1>관리자 관리페이지 </h1>
	<form action="HostInfo">
	
		<div id="header">
			
			<div id="img">
				<h1>프로필 사진 </h1> -- db에 기본 사진 불러옴
				<button>사진 변경</button>
			</div>
				
			<div id="info">
				<h1>관리자 정보 </h1>
			</div>
		
		</div>
		
		
		<div id="houseupload">
			<h1>호스트 업로드 요청 리스트</h1>
		</div>
		
		<div id="myhouselist">
			<h1>정산내역 신청 승인관리</h1>
		</div>
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</form>



</body>
</html>