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
	overflow: scroll;
	border: 2px solid #0B3861;
	width: 1200px;
	height: 700px;
	margin-bottom: 20px;
	border: 2px solid #0B3861;
}

.review {
	display: flex;
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

<!--모달창 -->
<style>
/* The Modal (background) */
.searchModal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 10; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.search-modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 70%; /* Could be more or less, depending on screen size */
	
}
 .star_grade span{text-decoration: none;color: gray;}
          .star_grade span.on{color:red;}
        
        
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
			<div id="sleepwell"></div>
		</div>

		<!--모달 만들기  -->
		<div id="modal" class="searchModal">
			<div class="search-modal-content">
				<div class="page-header">
					<h1>숙박후기</h1>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<h2>고객님의 목소리를 들려주세요.</h2>
							</div>
							<div>
							
							<div id="reviewCont"><textarea type="text" placeholder="댓글을 입력해주세요" style= "width:500px; height: 200px;"></textarea>
							<div id="reviewPic" style="border: 1px solid black; width:500px">사진부탁해요</div>
							<div><p style="display:inline-block" name="shownum" class="star_grade"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></p></div>
							</div>
							
							<button id="goodreview" 
								style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;">등록</button>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<div></div>
				<div
					style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
					onClick="closeModal();">
					<span class="pop_bt modalCloseBtn" style="font-size: 13pt;">닫기
					</span>
				</div>
			</div>
		</div>

<div class="button-3">
    <div class="eff-3"></div>
    <a href="main.jsp"> 뒤로가기 </a>
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


$('.star_grade span').click(function(){ //별점 효과
    $(this).parent().children("span").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
     $(this).addClass("on").prevAll("span").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
     //console.log($(this).parent().attr("name"));
    //#star_grade span.on
    var star=($(this).parent().children('.on').length);
});
    //모달 실행하고 
    
  /*   $.ajax({ // 업로드 요청 받아오는 ajax
    type:'get',
    url:'hostreview',//restful방식
    data:{data:star},
    //서버에서 받을때 
    dataType:"json",
    
    success:function(data){
       console.log("ajax 성공")
       
       console.log("승인해야할 것들");
       console.log(data);
       

    });

 */






var $test =${sleepwell}; //내정보 다 담겨 있는거지   
console.log("");
console.log($test);

for (i in $test){
	var checkin=new Date($test[i][0]["R_CHECKIN"]);
	var checkout=new Date($test[i][0]["R_CHECKOUT"]);

	var checkintime=checkin.toLocaleDateString();
	var checkouttime=checkout.toLocaleDateString();
	
var a1 = $('<div class= "review"><img id ="Homepic" width=300px height=250px src = "'+$test[i][0]["H_MAINPIC"]+'"></div>');
var b1 = $('<div id="reviewCont">'+'<div id="ReviewCont1">'+'방 등록번호:  '+$test[i][0]["R_H_RGNUM"]+'<br>'+
'호스트아이디:  '+$test[i][0]["R_HOSTID"]+'<br>'+'  인원수:  '+$test[i][0]["R_PERSON"]+'<br>'
+'체크인:  '+checkintime+'<br>'+'  체크아웃:  '+checkouttime+'<br>'+'  총가격:  '+$test[i][0]["R_TOTALPRICE"]+'</div>');
var c1 = $('<button class= "WriteReview">후기작성</button>')	
 		 
a1.append(b1);		
a1.append(c1);

$("#sleepwell").append(a1);


	 
	
	$('.WriteReview').click(function(){
	$("#modal").show();
	});
	function closeModal() {
	$('.searchModal').hide();
	};
}; 
 






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
});





</script>

</body>
</html>