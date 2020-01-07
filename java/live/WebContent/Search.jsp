<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	#searchbox{border:3px solid #0B3861;width:600px;height:60px;text-align:center;margin-bottom:30px;}
	input{border:none;width:500px;height:50px;font-size:15px;font-weight:bold;margin-top:1px;}
	button{background-color:#0B3861;border:none;width:70px;height:50px;color:white;font-weight:bold;}
	#middle{width:100%;height:100%;overflow:hidden;border:none;}
	#list{border:2px solid #0B3861;float:left;width:48%;}
	#map{border:2px solid #0B3861;float:right;width:51%;}
	

</style>



</head>
<body>
<h1>검색 키워드 입력후 보이는 창 </h1>
	
	<form action="Search" method="get">
			<div id="searchbox">
				<input type="text" name="destination" value="destination">
				<button type="submit">검색</button>
			</div>
			
			<div id="middle">
				<div id="list">
					<h1>검색어 바탕으로 정보 불러와서 뿌려줌</h1>
				</div>
				
				
				<div id="map">
					<h1>지도에 해당하는 위치를 포커싱</h1>
				</div>
			</div>
	</form>

</body>
</html>