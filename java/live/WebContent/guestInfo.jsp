<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>

<style>
#body{margin:0,auto;}
	#header{width:1200px;height:300px;overflow:hidden;border:none;}
		#img{border:2px solid #0B3861;float:left;width:300px;height:280px;}
	#info{border:2px solid #0B3861;float:right;width:870px;height:280px;}
	
	#houseupload{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;}
	#myhouselist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;}
	#oo{visibility:hidden;}
	#info{font-size:20px;font-weight:bold;}

</style>

</head>
<body>
<div id="body">
<h1>게스트 마이페이지 </h1>
<form action="profileupdate" method="post"enctype="multipart/form-data">
		<input type="file" id="oo" name="propic" >
		
		<div id="header">
			
			
			<div id="img">
				
			</div>

			<div id="info">
				
			</div>
		
		</div>
</form>		
		
		<div id="houseupload">
			<h1>내 예약목록</h1>
		</div>
		
		<div id="myhouselist">
			<h1>내 숙박내역</h1>
		</div>
	
	
</div>
<script>
//---------------------------------------예상-----------------------------------------------------------------------------------------


var $test =${result};  
console.log("제이슨 변환 String -> obj");
console.log($test);
console.log($test[0][0]["PROFILE"]);

var propic = document.getElementById("img");

var a = $('<div class= "propic"><img id ="pro" width=300px height=250px src = "'+$test[0][0]["PROFILE"]+'"></div>');
var b = $('<button type="button" id ="change">사진변경</button>')
var c = $('<button id = "save">사진저장</button>')	
 	 b.on('click',function() {
 		 
		console.log("사진변경");
		
		$("#oo").click();
		
});
	

 	$("#img").append(a);
	$("#img").append(b);
	$("#img").append(c);

	
	
	
	function readURL(input) {
		
		 if (input.files && input.files[0]) {
			console.log(input.files[0]);
				  	
			 var reader = new FileReader();
		  
		  reader.onload = function (e) {
			  console.log(e);
				
		   $('#pro').attr('src', e.target.result);  
		  }
		  
		  reader.readAsDataURL(input.files[0]);
		
		 }
	}
	
	$("#oo").change(function(){
		readURL(this);
	})
	
	var c = $('<div class = "myinfo">'+"아이디:"+$test[0][0]["ID"]+"<br>"+"이름:"+$test[0][0]["NAME"]+"<br>"+"이메일:"+$test[0][0]["EMAIL"]+"<br>"+"전화번호:"+$test[0][0]["PHONE"]+"<br>"+'</div>')
		$("#info").append(c);
	

	
//---------------------------------------------------예상----------------------------------------------------------------------------------





























</script>

</body>
</html>