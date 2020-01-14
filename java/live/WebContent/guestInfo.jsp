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
#body {
	margin: 0, auto;
}

#header {
	width: 1200px;
	height: 300px;
	overflow: hidden;
	border: none;
}

#img {
	border: 2px solid #0B3861;
	float: left;
	width: 300px;
	height: 280px;
}

#info {
	border: 2px solid #0B3861;
	float: right;
	width: 870px;
	height: 280px;
}

#houseupload {
	overflow: scroll;
	border: 2px solid #0B3861;
	width: 1200px;
	height: 700px;
	margin-bottom: 20px;
	border: 2px solid #0B3861;
}

#myhouselist {
	border: 2px solid #0B3861;
	width: 1200px;
	height: 700px;
	margin-bottom: 20px;
}

#oo {
	visibility: hidden;
}

#info {
	font-size: 20px;
	font-weight: bold;
}

.GuestReser {
	border: none;
	display: flex;
	width: 90%;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	margin-bottom: 10px;
}

.ShowGuestReser {
	width: 200px;
}

#GuestCont {
	width: 600px;
}
</style>

</head>
<body>
	<div id="body">
		<h1>게스트 마이페이지</h1>
		<form action="profileupdate" method="post"
			enctype="multipart/form-data">
			<input type="file" id="oo" name="propic">

			<div id="header">


				<div id="img"></div>

				<div id="info"></div>

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


var $test =${result}; //내정보 다 담겨 있는거지   
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
	

	
//---------------------------------------------------예상----------------------------------------------------------------------------------






//---------------------------------------------------------------------민호----------------------------게스트 예약진행중 취소 창 --------------------------


console.log(${MyReser});//예약 정보가 담겨있다
var $test1 =${MyReser}; //내정보 다 담겨 있는거지   
console.log("예약정보 출력");
console.log($test);


for(i in $test1){
var checkin=new Date($test1[i][0]["R_CHECKIN"]);
var checkout=new Date($test1[i][0]["R_CHECKOUT"]);

var checkintime=checkin.toLocaleDateString();
var checkouttime=checkout.toLocaleDateString();


var a = $('<div class= "GuestReser"></div>');
var b = $('<div class= "ShowGuestReser"><img id ="Rspic" width=200px height=150px src = "'+$test1[i][0]["H_MAINPIC"]+'"></div>'
		+'<div id="GuestCont">'+'방 등록번호:  '+$test1[i][0]["R_H_RGNUM"]+'<br>'+
		'호스트아이디:  '+$test1[i][0]["R_HOSTID"]+'<br>'+'  인원수:  '+$test1[i][0]["R_PERSON"]+'<br>'
		+'체크인:  '+checkintime+'<br>'+'  체크아웃:  '+checkouttime+'<br>'+'  총가격:  '+$test1[i][0]["R_TOTALPRICE"]+'</div>');
var c =$('<div style="margin-top : 50px;" id="showReser'+$test1[i][0]["R_RGNUM"]+'"><div>'); 
var d; 		 //예약상태창
var e=$('<button style="height: 25px;"class="cancelRoom" name="'+$test1[i][0]["R_RGNUM"]+'">'+"예약취소"+'</button>'); //예약취소
console.log(e);




if($test1[i][0]["R_TYPE"]==0){
	 d="예약대기중"
}else if($test1[i][0]["R_TYPE"]==1){
	d="예약성공"
}else {
	d="예약취소"
} 		 


c.append(d);

a.append(b);
a.append(c);
		
	
$("#houseupload").append(a);		
c.after(e);		
	

}


$(".cancelRoom").click(function() {
	var by=$(this).attr("name");
	
	
	
	
	console.log(by);
	$.ajax({
		type : 'get',
		url : "cancelroom",
		data : {cancel : by},
		datatype:"json",
		

		success:function(cancel){  
			console.log ("방취소성공 ");
			$("#showReser"+by).text("예약취소");
			
			
		}	,
		error:function(error){ //에러시 에러 뜨게하기
			console.log(error);
		}
		
		
	});


})





</script>

</body>
</html>