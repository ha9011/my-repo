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

#body{margin-left:300px;overflow:scroll;}
	#header{width:1200px;height:300px;overflow:hidden;border:none;}
		#img{border:2px solid #0B3861;float:left;width:300px;height:280px;}
	#info{border:2px solid #0B3861;float:right;width:870px;height:280px;}
	
	#houseupload{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
	#houselist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
	#oo{visibility:hidden;}
	#info{font-size:20px;font-weight:bold;}

.btn{float: right;margin-right:10px;width:70px;height:50px;color:white;background-color:#0B243B;}
</style>


</head>
<body>
<div id="body">
<h1>관리자 마이페이지 </h1>
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
			<h1>업로드 승인</h1>
			
		</div>
		
		<div id="houselist">
			<h1>게시물 업로드 승인내역</h1>
			
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
	
	$("#oo").change(function(){ //--사진 변경되면서 클릭시 저장실행되는 것 
		readURL(this);
	})
	
	var d = $('<div class = "myinfo">'+"아이디:"+$test[0][0]["ID"]+"<br>"+"이름:"+$test[0][0]["NAME"]+"<br>"+"이메일:"+$test[0][0]["EMAIL"]+"<br>"+"전화번호:"+$test[0][0]["PHONE"]+"<br>"+'</div>')
		$("#info").append(d);
	
//--------------------------------------------------------------------------------------------------------------------------------------
</script>

<script>
var $test2 =${HU};
console.log($test2)
var houseup = document.getElementById("houseupload"); 


for(intest in $test2 ){
	var a = $('<div class= "mainpic"><img id ="pro" width=100px height=50px src = "'+$test2[intest][0]["H_MAINPIC"]+'"></div>');
	var b = $('<div class= "request">'+
		" |신청자:"+$test2[intest][0]["H_ID"]+
		" |주소:"+$test2[intest][0]["H_ADDRESS"]+
		" |상세주소:"+$test2[intest][0]["H_DETAILADD"]+
		" |인원수:"+$test2[intest][0]["H_ATTENDANCE"]+
		" |방 수:"+$test2[intest][0]["H_ROOMS"]+
		" |침실 수:"+$test2[intest][0]["H_BEDROOMS"]+
		" |화장실:"+$test2[intest][0]["H_TOLILET"]+
		" |샤워실:"+$test2[intest][0]["H_PARKABLE"]+
		" |주차장:"+$test2[intest][0]["H_PARKABLE"]+
		'</div>'); 
		
	
	
var c = $('<button class= "btn" name="'+$test2[intest][0]["H_RGNUM"]+'" id = "app">승인</button>')	
var d = $('<button class= "btn" name="'+$test2[intest][0]["H_RGNUM"]+'" id = "can">거절</button>')	


c.on("click",test);



$("#houseupload").append(a);
$("#houseupload").append(b);
b.append(c);
b.append(d);

}

var test = function(){
	console.log("ttt");
}



$("#houseupload").on('click','.btn',function() {
	console.log("클릭")
	console.log($(this).attr("name"));
	var app =$(this).attr("name");
	var can =$(this).html();
	
	var num = [];
	num.push(app);
	num.push(can);
	console.log(num);
	var result = JSON.stringify(num);

	console.log(result);
	
	 $.ajax({ // 업로드 요청 받아오는 ajax
    type:'get',
    url:'houseupload',//restful방식
    data:{data:result},
    //서버에서 받을때 
    dataType:"json",
    
    success:function(data){
    	console.log("ajax 성공")
    	
       console.log("승인해야할 것들");
       console.log(data);
       
    $('#houseupload').empty();
       
       for(intest in data ){
    	   //<img alt="ㅋㅋㅋㅋ" id ="pro" width=100px height=50px src = "'+data[intest][0]["H_MAINPIC"]+'">
    		var a = $('<div class= "mainpic"></div>');
    		var b = $('<div class= "request">'+
    			" |주소:"+data[intest][0]["H_ADDRESS"]+
    			" |상세주소:"+data[intest][0]["H_DETAILADD"]+
    			" |인원수:"+data[intest][0]["H_ATTENDANCE"]+
    			" |방 수:"+data[intest][0]["H_ROOMS"]+
    			" |침실 수:"+data[intest][0]["H_BEDROOMS"]+
    			" |화장실:"+data[intest][0]["H_TOLILET"]+
    			" |샤워실:"+data[intest][0]["H_PARKABLE"]+
    			" |주차장:"+data[intest][0]["H_PARKABLE"]+
    			'</div>'); 
    			
    	var c = $('<button class= "btn" name="'+data[intest][0]["H_RGNUM"]+'" id = "app">승인</button>')	
    	
    	var d = $('<button class= "btn" name="'+data[intest][0]["H_RGNUM"]+'" id = "can">거절</button>')	

    	
    	
		//c.on("click",test);
    	
    	
    	$("#houseupload").append(a);
    	$("#houseupload").append(b);
    	$("#houseupload").append(c);
    	$("#houseupload").append(d);
       
      
       } 
       
	},
	error:function(error){
    	console.log("ajax 실패")

		console.log(error);
	}
}); //ajax end  	

});


	
//---------------------------------------------------예상----------------------------------------------------------------------------------
//게시물 승인목록


</script>

</body>
</html>