<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	body{margin:0 5%;}
	#top{display:flex;}
		#img{margin-bottom:2%;width:70%;height:800px;overflow:hidden;border:none;}
			#mainimg{border:1px solid black;width:70%;height:40%;margin-bottom:10px;}
			#subimg{border:1px solid black;width:90%;height:57%;}
		#reservation{display:inline-flex;width:30%;height:300px;border:1px solid black;margin-left:2%;}
	
	#middle{display:flex;;margin-bottom:2%;;width:100%;height:50%;overflow:hidden;}
		#review{margin-bottom:2%;border:1px solid black;width:50%;height:48%;}
		#reple{margin-bottom:2%;border:1px solid black;width:50%;height:48%;margin-left:10px;}
		
	
	#bottom{width:100%;height:50%;overflow:hidden;border:1px solid black;}
	
	
</style>

</head>
<body>

<h1>예약 디테일 페이지 </h1>
<form action="">
		
	<div id="top">
			
		<div id="img">
				<div id = "mainimg">
					<h1>메인사진</h1>
				</div>
				<div id = "subimg">
					<h1>슬라이드사진</h1>
				</div>
		</div>
				
		
				
				<div id="reservation">
					<h1>날짜 예약</h1> 
				</div>
		
	</div>
		
		
		
		<div id= "middle">
		
			<div id="review">
				<h1>후기</h1>
			</div>
		
			<div id="reple">
				<h1>댓글 대댓글</h1>
			</div>
		
		</div>
		
		<div id = "bottom">
			<h1>주의사항</h1>
		</div>
		
		
	
</form>

<script>

</script>


</body>
</html>