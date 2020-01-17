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
	#info{border:2px solid #0B3861;float:right;width:870px;height:280px;display:flex;}
	
	#requestlist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:30px;overflow:scroll;}
		.mainpic{display: inline-block; font-size:18px;border:1px solid #0B3861;margin:15px;}
	#houseupload{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
	#myhouselist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;text-align:center;}
	#checkoutlist{border:2px solid #0B3861;width:1200px;height:700px;margin-bottom:20px;overflow:scroll;}
		.checkout{margin-top:20px;}
		.mainbox{font-size:18px;margin-left:10px;border:1px solid #0B3861;margin:15px;}
		 .star_grade span{text-decoration: none;color: gray;}
   		 .star_grade span.on{color:red;}
	
	
	
	#oo{visibility:hidden;}
	#info{font-size:20px;font-weight:bold;}

h5{display:inline; margin-left:40px;}
.btn{float: right;margin-right:10px;width:70px;height:50px;}



body {
  font-family: sans-serif;
}

.modal-wrapper {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal {
  background: white;
  padding: 24px 16px;
  border-radius: 4px;
  width: 320px;
}

.modal-title {
  text-align:center;
  font-size: 15px;
  font-weight: bold;
}

.modal p {
  font-size: 16px;
}

.close-wrapper {
  text-align: right;
}

#star span{color:red;}

.button-3{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-3 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-3{
  width:140px;
  height:50px;
  bottom:-50px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-3:hover .eff-3{
  bottom:0;
}
.button-3:hover a{
  color:#fff;
}
.review{
	width:90%;
	height:40px;
}
.myinfo{
	margin:15px;
	font-size: 25px;
}
button{background-color: #0B243B;
	   color:white;
	   border: none;
}

.btn{margin-bottom:20px;}
</style>

</head>
<body>
	<form action="hostreview">
    <div class="modal-wrapper" style="display: none;">
      <div class="modal">
        <div class="modal-title">게스트에 대한 후기를 남겨주세요 </div>
        <div name="rgnum" value=rgnum></div>
        <input type="hidden" class="score" name="hscore" id="hscore">
       <input type="text" class="review" name="contents">
       <input type="hidden" class="hreview" name="hrgnum" id="hcontents">
        <div class="close-wrapper">
          <button id="conform" type="submit">확정</button>
           <button type="button" id="close">닫기</button>
        </div>
      </div>
    </div>
</form>

<div id="body">
<h1>호스트 마이페이지 </h1>
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
			<h1>요청받은 예약 리스트  </h1>
		</div>
		
		<div id="checkoutlist">
			<h1> 체크아웃한 게스트에게 후기를 남기세요 </h1>
			
		</div>
		
		<div id="houseupload">
			<h1>내 게시물 등록현황</h1>
		</div>
		
		<div id="myhouselist">
			<h1>내 집 목록 </h1>
		</div>
	
	
</div>
<div class="button-3">
    <div class="eff-3"></div>
    <a href="main.jsp"> 뒤로가기 </a>
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
	
	var d = $('<div class = "myinfo">'+"호스트 아이디:"+$test[0][0]["ID"]+"<br>"+"호스트 이름:"+$test[0][0]["NAME"]+"<br>"+"내 이메일:"+$test[0][0]["EMAIL"]+"<br>"+"내 전화번호:"+$test[0][0]["PHONE"]+"<br>"+'</div>')
		$("#info").append(d);
	

//--------------------------------------------------예상------------게스트 예약요청 ------------------------------------------------------------------------------

var $reList =${reserlist};  
console.log($reList);

var reservation = document.getElementById("requestlist");


for(intest in $reList ){
	
	var o= new Date($reList[intest][0]["R_CHECKOUT"]);
	var checkout=o.toLocaleDateString();
	console.log(checkout);

	var i= new Date($reList[intest][0]["R_CHECKIN"]);
	var checkin=i.toLocaleDateString();
	console.log(checkin);
	
	
	var a = $('<div class= "mainpic" style="display:flex;"><img id ="pro" width=150px height=70px src = "'+$reList[intest][0]["H_MAINPIC"]+'"></div>');
	var b = $('<div class= "request">'+
		" |예약 요청자:"+$reList[intest][0]["R_GUESTID"]+
		" |요청인원:"+$reList[intest][0]["R_PERSON"]+
		" |체크인날짜:"+checkin+
		" |체크아웃날짜:"+checkout+
		" |전체 가격:"+$reList[intest][0]["R_TOTALPRICE"]+"만원"+"&nbsp"+"&nbsp"+"&nbsp"+
		'</div>'); 
		
	
	
var c = $('<button class= "btn" name="'+$reList[intest][0]["R_RGNUM"]+'" id = "app">승인</button>')	
var d = $('<button class= "btn" name="'+$reList[intest][0]["R_RGNUM"]+'" id = "can">거절</button>')	


$("#requestlist").append(a);
a.append(b);
b.append(d);
b.append(c);

}




 var test = function(){
	console.log("ttt");
}



$("#requestlist").on('click','.btn',function() {
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
    url:'requestlist',//restful방식
    data:{data:result},
    //서버에서 받을때 
    dataType:"json",
    
    success:function(data){
    	console.log("ajax 성공")
    	
       console.log("승인해야할 것들");
       console.log(data);
       
    $('#requestlist').empty();
       
    for(intest in data){
    	
    	var o= new Date(data[intest][0]["R_CHECKOUT"]);
    	var checkout=o.toLocaleDateString();
    	console.log(checkout);

    	var i= new Date(data[intest][0]["R_CHECKIN"]);
    	var checkin=i.toLocaleDateString();
    	console.log(checkin);
    	
    	
    	var a = $('<div class= "mainpic" style="display:flex;"><img id ="pro" width=150px height=70px src = "'+data[intest][0]["H_MAINPIC"]+'"></div>');
    	var b = $('<div class= "request">'+
    		" |예약 요청자:"+data[intest][0]["R_GUESTID"]+
    		" |요청인원:"+data[intest][0]["R_PERSON"]+
    		" |체크인날짜:"+checkin+
    		" |체크아웃날짜:"+checkout+
    		" |전체 가격:"+data[intest][0]["R_TOTALPRICE"]+"만원"+"&nbsp"+"&nbsp"+"&nbsp"+
    		'</div>'); 
    		
    	
    	
    var c = $('<button class= "btn" name="'+data[intest][0]["R_RGNUM"]+'" id = "app">승인</button>')	
    var d = $('<button class= "btn" name="'+data[intest][0]["R_RGNUM"]+'" id = "can">거절</button>')	


    $("#requestlist").append(a);
    a.append(b);
    b.append(d);
    b.append(c);
    }
       
	},
	error:function(error){
    	console.log("ajax 실패")

		console.log(error);
	}
}); //ajax end  	

});
//--------------------------------------------------예상------------체크아웃 별점------------------------------------------------------------------------------

var $CL =${checkoutlist};  
console.log($CL);

var checkoutlist = document.getElementById("checkoutlist");
  
for(intest in $CL ){
	
	var out= new Date($CL[intest][0]["R_CHECKOUT"]);
	var checkout=out.toLocaleDateString();
	console.log(checkout);

	var ci= new Date($CL[intest][0]["R_CHECKIN"]);
	var checkin=ci.toLocaleDateString();
	console.log(checkin);
	
	
	var a = $('<div class= "mainbox" style="display:flex;"></div>');
	var b = $('<div class= "checkout">'+
		" 게스트 아이디:"+$CL[intest][0]["R_GUESTID"]+
		" |게스트 인원"+$CL[intest][0]["R_PERSON"]+
		" |체크인날짜:"+checkin+
		" |체크아웃날짜:"+checkout+"&nbsp"+"&nbsp"+"&nbsp"+
		'</div>'); 
	
	
	var c =$('<div>'+'<p style="display:inline-block" name="'+$CL[intest][0]["R_RGNUM"]+'" class="star_grade">'+'<span>★</span>'+'<span>★</span>'+'<span>★</span>'+'<span>★</span>'+'<span>★</span>'+'</p>'+'</div>');
	

	$("#checkoutlist").append(a);
	a.append(b);
	a.append(c);
	
	
	 
	 



}

$('.star_grade span').click(function(){ //별점 효과
	 $('.review').val("");
	 $('#star').empty();
	 $("#hcontents").val("");
	     
    $(this).parent().children("span").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
     $(this).addClass("on").prevAll("span").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
     //console.log($(this).parent().attr("name"));
    //#star_grade span.on
    var star=($(this).parent().children('.on').length);
    
    var rg=($(this).parent().attr("name"));
    $("#hcontents").val(rg);
    
    $("#hscore").val(star);
     
    //모달 실행하고 
	const close = document.getElementById("close");
	const modal = document.querySelector(".modal-wrapper");

	$("#star").append($(this).parent().children('.on').clone());
 	 modal.style.display = "flex";
	
		close.onclick = () => {
 	 modal.style.display = "none";
	};

     return false;
});














//--------------------------------------------------예상------------내 게시물 등록현황------------------------------------------------------------------------------

var $home =${hostH};  
console.log($home);

var houseup = document.getElementById("houseupload"); 


for(intest in $home ){
	var a = $('<div class= "mainpic"style="display:flex;"><img id ="pro" width=200px; height=100px;src = "'+$home[intest][0]["H_MAINPIC"]+'"></div>');
	
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



//--------------------------------------------------예상------------내 집 보유 리스트------------------------------------------------------------------------------

var $homeL =${hostHL};  
console.log("제이슨 변환 String -> obj");
console.log($homeL);

var myhome = document.getElementById("myhouselist"); 


for(intest in $homeL ){
	if(intest%4==0){
		var br = $('<br><br>');
		$("#myhouselist").append(br);
	}
	var a = $('<div class= "mainpic"style="margin:10px;"><img class= "mainpicc" name = '+$homeL[intest][0]["H_RGNUM"]+' id ="pro" width=200px height=100px src = "'+$homeL[intest][0]["H_MAINPIC"]+'"></div>');
	
	var b = $('<div class= "request" >'+
		" |주소:"+$homeL[intest][0]["H_ADDRESS"]+"<br>"+
		" |상세주소:"+$homeL[intest][0]["H_DETAILADD"]+
		'</div>'); 
	
$("#myhouselist").append(a);
	a.append(b);

	 $(".mainpicc").on('click', function() {

         console.log("z");
         console.log($(this).attr("name"));
         location.href="detailregiinfo?rgnum="+$(this).attr("name");
         
      });
}



//--------------------------------------------------예상------------내 집 보유 리스트 끝------------------------------------------------------------------------------
</script>

</body>
</html>