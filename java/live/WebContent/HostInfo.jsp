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

#body{margin:0,auto;overflow:scroll;}
	#header{width:1200px;height:300px;overflow:hidden;border:none;}
		#img{border:2px solid #0B3861;float:left;width:300px;height:280px;}
	#info{border:2px solid #0B3861;float:right;width:870px;height:280px;}
	
	#requestlist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
	#houseupload{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
	#myhouselist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
	#oo{visibility:hidden;}
	#info{font-size:20px;font-weight:bold;}

h5{display:inline; margin-left:40px;}

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
		
		<div id="requestlist">
			<h1>게스트 예약 요청 </h1>
		</div>
		
		<div id="houseupload">
			<h1>업로드 요청 리스트</h1>
		</div>
		
		<div id="myhouselist">
			<h1>내 보유 집 목록 </h1>
		</div>
	
	
</div>
<script>
//---------------------------------------예상------------마이페이지 정보-----------------------------------------------------------------------------


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
	
	$("#oo").change(function(){//--사진 변경되면서 클릭시 저장실행되는 것 
		readURL(this);
	})
	
	var d = $('<div class = "myinfo">'+"아이디:"+$test[0][0]["ID"]+"<br>"+"이름:"+$test[0][0]["NAME"]+"<br>"+"이메일:"+$test[0][0]["EMAIL"]+"<br>"+"전화번호:"+$test[0][0]["PHONE"]+"<br>"+'</div>')
		$("#info").append(d);
	

	
//---------------------------------------------------예상------------마이페이지 정보 보여주기 끝----------------------------------------------------------------------


//--------------------------------------------------예상------------게스트 예약요청 ------------------------------------------------------------------------------





//--------------------------------------------------예상------------게스트 예약요청  끝------------------------------------------------------------------------------


//--------------------------------------------------예상------------내 게시물 등록현황------------------------------------------------------------------------------

var $home =${hostH};  
console.log("제이슨 변환 String -> obj");
console.log($home);

var houseup = document.getElementById("houseupload"); 


for(intest in $home ){
	var a = $('<div class= "mainpic"style="display:flex;"><img id ="pro" width=100px height=50px src = "'+$home[intest][0]["H_MAINPIC"]+'"></div>');
	
	var b = $('<div class= "request" >'+
		" |주소:"+$home[intest][0]["H_ADDRESS"]+
		" |상세주소:"+$home[intest][0]["H_DETAILADD"]+
		" |인원수:"+$home[intest][0]["H_ATTENDANCE"]+
		" |방 수:"+$home[intest][0]["H_ROOMS"]+
		" |침실 수:"+$home[intest][0]["H_BEDROOMS"]+
		" |화장실:"+$home[intest][0]["H_TOLILET"]+
		" |샤워실:"+$home[intest][0]["H_PARKABLE"]+
		" |주차장:"+$home[intest][0]["H_PARKABLE"]+
		"<h5>ㆍㆍㆍ승인대기중ㆍㆍㆍ</h5>"+
		'</div>'); 
	
		




$("#houseupload").append(a);
	a.append(b);

}



//--------------------------------------------------예상------------내 게시물 등록현황 끝------------------------------------------------------------------------------

//--------------------------------------------------예상------------내 집 보유 리스트------------------------------------------------------------------------------




//--------------------------------------------------예상------------내 집 보유 리스트 끝------------------------------------------------------------------------------


</script>

</body>
</html>






