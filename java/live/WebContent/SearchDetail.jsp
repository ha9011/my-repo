<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	#body{margin:0 5%}
	#searchbox{border:3px solid #0B3861;width:600px;height:60px;text-align:center;margin-bottom:30px;}
	input{border:none;width:500px;height:50px;font-size:15px;font-weight:bold;margin-top:1px;}
	button{background-color:#0B3861;border:none;width:70px;height:50px;color:white;font-weight:bold;}
	#middle{width:100%;height:100%;overflow:hidden;border:none;}
	#list{border:none;float:left;width:40%;}
	.out{border:2px solid #0B3861;;width:100%;height:150px;display:flex;margin-bottom:10px;}
		.inner{display:inline-flex;}
		.info{margin-left:20px;width:200px;height:150px;display:inline-flex;font-size:20px;}
	
	#map{border:2px solid #0B3861;float:right;width:56%;}
	
	
	
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<div id = "body">
<h1>검색 키워드 입력후 보이는 창 </h1>
	
	<form action="SearchDetail" method="get">
			<div id="searchbox">
				<input type="text" name="destination" value=${destination}>
				<button type="submit">검색</button>
			</div>
			
			<div id="middle">
				<div id="list"></div>
				
				
				<div id="map">
				
					<h1>지도에 해당하는 위치를 포커싱</h1>
				
				</div>
			</div>
	</form>
</div>
</body>
<script>
	var $test =${result};  
	console.log("제이슨 변환 String -> obj");
	console.log($test);
	
	var searchlist= document.getElementById("list");
	
	
	
	for(intest in $test ){
		
		var a = $('<div class="out" name = '+$test[intest][0]["H_RGNUM"]+'></div>')
		var b = $('<div class="inner"><img width="200"height="150" alt=사진없음 src="'+$test[intest][0]["H_MAINPIC"]+'"></div>')
		var c = $('<div class="info">'+'주소지:'+$test[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+$test[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+$test[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+$test[intest][0]["H_ONEPRICE"]+'만원'+'</div>')
		a.append(b);
		a.append(c);
		a.on('click', function() {
			console.log($(this).attr("name"));
			location.href="detailregiinfo?id="+$(this).attr("name");
			
		} )
		
		console.log(a.attr("name"));
		$("#list").append(a)
		
		console.log($test[intest][0]["H_RGNUM"]);
		console.log($test[intest][0]["H_MAINPIC"]);
		console.log($test[intest][0]["H_ADDRESS"]);
		console.log($test[intest][0]["H_ROOMS"]);
		console.log($test[intest][0]["H_TOLILET"]);
		console.log($test[intest][0]["H_ONEPRICE"]);
		
	}
	




	
	
	///////////////////////////////////////////////// 하동원
	
	//${result}
	var mapdetail ="";
	
	for(intest in $test ){
		
		var a = {}
		console.log($test[intest][0]["H_RGNUM"]);
		console.log($test[intest][0]["H_MAINPIC"]);
		console.log($test[intest][0]["H_ADDRESS"]);
		console.log($test[intest][0]["H_ROOMS"]);
		console.log($test[intest][0]["H_TOLILET"]);
		console.log($test[intest][0]["H_ONEPRICE"]);
		
	}
	
	
	
	
	

</script>
</html>