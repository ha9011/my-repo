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
	margin-left:300px;
	overflow:scroll;
}
.out {
	border-bottom:2px solid #0B3861;
	width: 90%;
	height: 150px;
	display: flex;
	margin-bottom: 10px;
}

.inner {
	display: inline-flex;
}

.info {
	margin-left: 20px;
	width: 200px;
	height: 150px;
	display: inline-flex;
	font-size: 20px;
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
	border:1px solid #0B3861;margin:15px;
	width:520px;
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

.myscore{
	display : inline-block;
	border : 2px solid black;
	padding : 5px;
	margin : 5px ;
	color : blue;
}

button{
	background-color: #0B243B;
	   color:white;
	   border: none;
}
.WriteReview{
	float:right; 
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

#imgs_wrap {
	display: inline-block;
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
		<form id="savepic" method="post"
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
		
		<div id="myhouselist">
			<h1>좋아요</h1>
			<div id="likehouse"></div>

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
							<form id="innerfrm" action="registGuestReview" method="post"
								enctype="multipart/form-data">
								<div>
									<div>
										<input type="text" name="hrenum" id="hrenum"> <input
											type="text" name="hscore" id="hscore">
									</div>
									<div id="reviewCont">
										<textarea id="tareviewCont" type="text" name="tareviewCont"
											;
											placeholder="댓글을 입력해주세요"
											style="width: 500px; height: 200px;"></textarea>

										<div id="reviewPic"
											style="border: 1px solid black; width: 500px">
											사진부탁해요
											<hr>
											<div class="form-group" style="width: 100%;">
												<label for="exampleFormControlFile1">Example file
													input</label> <input name="houseimg[]" type="file"
													class="form-control-file" id="imgInp" multiple>
											</div>
										</div>


										<div>

											<div class="imgs_wrap"></div>
											<a class="prev" onclick="plusSlides(-1)">&#10094;</a><a
												class="next" onclick="plusSlides(1)">&#10095; </a> <br>
											<p style="display: inline-block" name="shownum"
												class="star_grade">
												<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
											</p>
										</div>

									</div>


									<button id="goodreview"
										style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;">등록</button>
								</div>
							</form>
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
var c = $('<button type="button" id ="save">사진저장</button>')	
 	 b.on('click',function() {
 		 
		console.log("사진변경");
		
		$("#oo").click();
		
});
	

 	$("#img").append(a);
	$("#img").append(b);
	$("#img").append(c);

	
	
	
	function readURLpro(input) {
		
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
		readURLpro(this);
	})
	
	var d = $('<div class = "myinfo">'+"아이디:"+$test[0][0]["ID"]+"<br>"+"이름:"+$test[0][0]["NAME"]+"<br>"+"이메일:"+$test[0][0]["EMAIL"]+"<br>"+"전화번호:"+$test[0][0]["PHONE"]+"<br>"+'</div>')
	$("#info").append(d);
	
	var myscore = ${myscore};
	var e = $('<div class="myscore"> 총 리뷰 : ' +myscore[0][0]["GCNT"]+'개 | 총 점수 : '+myscore[0][0]["GAVG"]+'점</div>')
    $("#info").append(e);
	
	//내 점수 뽑기.
	
//---------------------------------------------------동원----------------------------------------------------------------------------------




//사진 미리보기 ....


let list ;
let indexpic = [0,1,2];

$(function() {
    $("#imgInp").on('change', function(){
        
    	indexpic = [0,1,2];
        readURL(this,indexpic);  // 사진 이미지 넣기
       
        
       //readListURL(list,indexpic);
        
    });
    
    
});

//업로드한 이미지 읽어서 쏴주기
function readURL(input,indexpic) {  
	
	
	let files = input.files;          
	let total = input.files.length;  //사진 갯수
	list = total;
	let filesArr = Array.prototype.slice.call(files);  // 객체 -> 배열
	
	filesArr.forEach((e,i)=>{
		if(!e.type.match("image.*")){
			alert("이미지 확장자가 아닙니다.")
			return;
		}
		console.log(i);
		
		console.log("이미지 변경시 indexpic ");
		console.log(i);
		console.log(e);
		console.log(indexpic)
		console.log(indexpic.indexOf(i))
		
		let reader = new FileReader();
		if(indexpic.indexOf(i) !== -1){
		
			reader.onload = function(r){
				console.dir(r);
				
				let img_html = "<div class='mySlides pic"+i+"'style='display:inline-block' >  <div class='numbertext'>"+(i+1)+" / "+total+"</div> "
				+ " <img width='100px' height='100px' src=\""+r.target.result+"\" /> </div>";
	     	//	var img_html = "<img width='100px' height='100px' src=\""+r.target.result+"\" /> </div>";
	     		
				$(".imgs_wrap").append(img_html);
			}
			reader.readAsDataURL(e)
			
		}else{
			reader.onload = function(r){
				console.dir(r);
				
				let img_html = "<div class='mySlides pic"+i+"' style='display:none'>  <div class='numbertext'>"+(i+1)+" / "+total+"</div> "
				+ " <img width='100px' height='100px' src=\""+r.target.result+"\" /> </div>";
	     	//	var img_html = "<img width='100px' height='100px' src=\""+r.target.result+"\" /> </div>";
	     		
				$(".imgs_wrap").append(img_html);
			}
			reader.readAsDataURL(e)
			
		}
		
	});
	
	
	return filesArr;
}

//파일 저장 누르기

$(document).on("click","#save",function(){
	alert("사진저장");
	
	var form = $('#savepic')[0];

    // FormData 객체 생성
    var formData = new FormData(form);

    // 코드로 동적으로 데이터 추가 가능.
//                formData.append("userId", "testUser!");

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "profileupdate",
        data: formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function (data) {
            console.log("SUCCESS : ", data);
        },
        error: function (e) {
            console.log("ERROR : ", e);
        }

	
	
})
})

function readListURL(indexpic) {    // 특정 놈 안보이고 보이게 하기, 버튼의 핵심;
	
	
	console.log("예 실행되니???");// .. 실행됨.
	let files1 = $(".mySlides"); // 긁어오기
	let total = files1.length; // 길이
	let filesArr = Array.prototype.slice.call(files1);  // 객체 -> 배열
	console.log(files1);
	
	console.log("========");
	
	
	filesArr.forEach((e,i)=>{
		
		if(i<3){
			console.log("존재 : " + i);
			$(e).css('display','inline-block');
			
		}else{
			console.log("존재x : " + i);
			$(e).css('display','none');
			
		}
	
	});
	
	
}


let plusSlides = (e)=>{   // 버튼 이벤트
	let files2 = $(".mySlides");
	//$(".imgs_wrap").empty();
	console.log("list : " + list);

	console.log("files : " + files2);
	
	if(e === -1){
		console.log("처음 : " + indexpic);
		indexpic = indexpic.map((v)=>{
			
				
				$(files2[files2.length-1]).insertBefore(files2[0]);
			
		});
		console.log("변경 : " + indexpic);
		
		readListURL(indexpic);
		
	}else if(e === 1){
		console.log("tset");
		console.log($(files2[0]));
		console.log("처음 : " + indexpic);
		indexpic = indexpic.map((v)=>{
			
				$(files2[0]).insertAfter(files2[files2.length-1]);
			
		});
		console.log("변경 : " + indexpic);
		readListURL(indexpic);
	}
	console.log(list);
	console.log(e);
}











//---------------------------------------------------------------------민호----------------------------게스트 예약진행중 취소 창 --------------------------

//
$('.star_grade span').click(function(){ //별점 효과
    $(this).parent().children("span").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
     $(this).addClass("on").prevAll("span").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
     //console.log($(this).parent().attr("name"));
    //#star_grade span.on
    var star=($(this).parent().children('.on').length);  // 점수 주기
    $("#hscore").val(star);
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


 


//[내 숙박내역]
var $test =${sleepwell}; // 내가 숙박했던 곳 다 나옴 ( 체크인 시간 지나면 쌓임 )    R_RGNUM // R_HREVIEW- 0또는1일때 이벤트 다르게
console.log("숙박내역에 따른 정보");
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

var c1 = $('<button name="'+$test[i][0]["R_RGNUM"]+'"class= "WriteReview">test</button>')	



if($test[i][0]["R_HREVIEW"]==1){
	c1.html("후기완료");
}else if($test[i][0]["R_HREVIEW"]==0){
	c1.html("후기작성");
}	 

a1.append(b1);		
a1.append(c1);

$("#sleepwell").append(a1);
	
}; 
 
//모달 열어 주기
$('.WriteReview').click(function(){
	$("#reviewPic").val("");
	$("#tareviewCont").val("");
	$("#hscore").val("");
	$(".star_grade").children("span").removeClass("on");
	$(".imgs_wrap").empty();
	console.log($(this).html());
	
	
	if($(this).html()==="후기작성"){
		$('#tareviewCont').attr('disabled', false);
		$("#goodreview").css("display","inline-block");
		$("#reviewPic").css("display","inline-block");
		
		$("#hrenum").val($(this).attr("name"));  // $(this).attr("name")몇번인지 보여주는거 
		
		$("#modal").show();
	
	}else{   // 후기완료인 버튼을 누를때, ajax로 긁어서 데이터 보여줘야함.
	
		
		var reservationNum = $(this).attr("name");
	
		$.ajax({
			type : 'get',
			url : "showreview",
			data : {showreview : reservationNum},
			datatype:"json",
			

			success:function(data){  
				console.log ("후기완료 버튼 AJAX 성공 ");
				var resultArr = JSON.parse(data);
				var ajaxCont = resultArr["GRV_CONTENT"];
				var ajaxpre = resultArr["GRV_PICS"].split(",");
				var ajaxPics = ajaxpre.slice(0,ajaxpre.length-1);
				var ajaxScore=  resultArr["GRV_SCORE"];

				console.log(ajaxCont);
				console.log("길이");
				console.log(ajaxPics);
				console.log(ajaxScore);
				
				$("#tareviewCont").val(ajaxCont); 
				 $('#tareviewCont').attr('disabled', true);
				$(".star_grade").children(":lt("+ajaxScore+")").addClass("on");
				
				console.log("ajaxPics 길이  : " + ajaxPics.length)
				for(let i in ajaxPics){
					console.log(ajaxPics[i])
					if(i<=2){  // 3 이상일때
						$(".imgs_wrap").append( $('<div class="mySlides" style="display:inline-block"> <img width="200px" height="200px" src="'+ajaxPics[i] +'" ></div>') );
							
					}else{
						$(".imgs_wrap").append( $('<div class="mySlides" style="display:none"> <img width="200px" height="200px" src="'+ajaxPics[i] +'" ></div>')  );
						
					}
					
				}
				list = ajaxPics.length;

				
				$("#goodreview").css("display","none");
				$("#reviewPic").css("display","none");
				
				
				$("#modal").show();
			//	$("#hrenum").val($(this).attr("name"));
				
				
				
			}	,
			error:function(error){ //에러시 에러 뜨게하기
				console.log(error);
			}
			
			
		});
	
	
	}
	
	

});







//모달 닫아주기
function closeModal() {
	$('.searchModal').hide();
};





//내 예약목록[95%완]
console.log("내 예약목록");
console.log(${MyReser});//예약 정보가 담겨있다
var $test1 =${MyReser}; //[내 예약 목록]가 담겨져 있다.   
console.log("예약정보 출력");



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

var e=$('<button style="height: 25px;"class="cancelRoom" id="showReserbtn'+$test1[i][0]["R_RGNUM"]+'" name="'+$test1[i][0]["R_RGNUM"]+'">'+"예약취소"+'</button>'); //예약취소
console.log(e);




if($test1[i][0]["R_TYPE"]==0){
	d="예약대기중"
}else if($test1[i][0]["R_TYPE"]==1){
	d="예약성공"
}else {
	e.prop("disabled", true);
	e.html("취소완료");
	
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
			console.log ("방취소성공?? ");
			
			$("#showReser"+by).text("예약취소");
			$("#showReserbtn"+by).prop("disabled", true);
			$("#showReserbtn"+by).html("취소완료");
			
			
			
		}	,
		error:function(error){ //에러시 에러 뜨게하기
			console.log(error);
		}
		
		
	});
});



//[찜 목록]

var $test2 =${likehouse}; //[내 예약 목록]가 담겨져 있다.   
console.log("예약정보 출력");

for(intest in $test2){
var checkin=new Date($test2[intest][0]["R_CHECKIN"]);  
var checkout=new Date($test2[intest][0]["R_CHECKOUT"]);

var checkintime=checkin.toLocaleDateString();
var checkouttime=checkout.toLocaleDateString();

var a = $('<div class="out" name = '+$test2[intest][0]["H_RGNUM"]+'></div>')

var b = $('<div class="inner" ><img name = '+$test2[intest][0]["H_RGNUM"]+' class="gg" width="200"height="150" alt=사진없음 src="'+$test2[intest][0]["H_MAINPIC"]+'"></div>')

var c = $('<div class="info">'+'주소지:'+$test2[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+$test2[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+$test2[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+$test2[intest][0]["H_ONEPRICE"]+'만원'+'</div>')

a.append(b);
a.append(c);


var e=$('<button style="height: 25px; "class="cancellike" id="cancellike'+$test2[intest][0]["H_RGNUM"]+'" name="'+$test2[intest][0]["H_RGNUM"]+'">'+"좋아요 삭제"+'</button>'); //예약취소
console.log(e);


		
	
$("#likehouse").append(a);		
c.after(e);		
	

}




//좋아요 삭제
$(document).on('click',".cancellike",function() {
	
	
	var cancellikelist = [];
	var by=$(this).attr("name");
	var id='${id}';

	cancellikelist.push(by);
	cancellikelist.push(id);
	
	
	var result = JSON.stringify(cancellikelist);
	console.log(by);

	console.log(result)
	
	
	console.log("=====")
	
	
	
	$.ajax({
		type : 'get',
		url : "cancellike",
		data : {cancellike : result},
		datatype:"json",
		

		success:function(cancellike){  
			$("#likehouse").empty();	
			console.log(cancellike);

			console.log(typeof cancellike);
			console.dir(cancellike);
			
			var result = JSON.parse(cancellike);
			
			for(intest in result){
				var checkin=new Date(result[intest][0]["R_CHECKIN"]);  
				var checkout=new Date(result[intest][0]["R_CHECKOUT"]);

				var checkintime=checkin.toLocaleDateString();
				var checkouttime=checkout.toLocaleDateString();

				var a = $('<div class="out" name = '+result[intest][0]["H_RGNUM"]+'></div>')

				var b = $('<div class="inner" ><img name = '+result[intest][0]["H_RGNUM"]+' class="gg" width="200"height="150" alt=사진없음 src="'+result[intest][0]["H_MAINPIC"]+'"></div>')

				var c = $('<div class="info">'+'주소지:'+result[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+result[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+result[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+result[intest][0]["H_ONEPRICE"]+'만원'+'</div>')

				a.append(b);
				a.append(c);


				var e=$('<button style="height: 25px; "class="cancellike" id="cancellike'+result[intest][0]["H_RGNUM"]+'" name="'+result[intest][0]["H_RGNUM"]+'">'+"좋아요 삭제"+'</button>'); //예약취소
				console.log(e);


						
					
				$("#likehouse").append(a);		
				c.after(e);		
			}
			
			
			
		}	,
		error:function(error){ //에러시 에러 뜨게하기
			console.log(error);
		}
		
		
	});
	
});




</script>

</body>
</html>