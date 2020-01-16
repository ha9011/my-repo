<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주소로 장소 표시하기</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=54a97da9ea0c80921e6f0c3700f67b67&libraries=services"></script>

</head>
<style>
#map {
	width: 98%;
	height: 400px;
	border: none;
	text-align: right;
}

#outfrm {
	width: 600px;
	height: 950px;
	border: 1px solid #34495e;
	text-align: left;
	margin: 50px auto;
}

#innerfrm {
	margin: 10px;
}

#outputAddress {
	width: 100%;
	height: 400px;
}

.test {
	display: none;
}

#inputAddress {
	display: inline-block;
	width: 500px;
}
#signin{
background-color: #34495e;
}
#LSBtn {
background-color: #34495e;
	margin: 0 0 5px 0;
}

#firstsubmit {
	margin: 100px 0 0 0;
}

.button-3 {
  margin-right: 50px;
	width: 140px;
	height: 50px;
	border: 2px solid #34495e;
	position: relative;
	text-align: center;
	cursor: pointer;
	box-sizing: border-box;
	overflow: hidden;
	margin: 0 0 40px 50px;
}

.button-3 a {
padding: auto;
	font-family: arial;
	font-size: 16px;
	color: #34495e;
	text-decoration: none;
	line-height: 50px;
	transition: all .5s ease;
	z-index: 2;
	position: relative;
}

.eff-3 {
	width: 140px;
	height: 50px;
	bottom: -50px;
	background: #34495e;
	position: absolute;
	transition: all .5s ease;
	z-index: 1;
}

.button-3:hover .eff-3 {
	bottom: 0;
}
p{text-align:left;}
	#hf{margin-top:20px;
	background-color:#0B243B;
	color:white;
}
.button-3:hover a {
	color: #fff;
}
h3{text-align: center;
}

#menu{

float: right;
background-color: #0B243B;
height: 950px;
width: 225px;
text-align: center;
}

#big{
width : 2400px;
border-right: 1px solid 0B243B;
}
</style>

<body>

<div id="big">
<div id="menu">
<div class="button-3">
		<div class="eff-3"></div>
		<a href="main.jsp"> 뒤로가기 </a>
	</div>
<div class="button-3">
		<div class="eff-3"></div>
		<a href="main.jsp"> 메인페이지 </a>
	</div>
<div class="button-3">
		<div class="eff-3"></div>
		<a href="loginform.jsp"> 로그인 </a>
	</div>
<div class="button-3">
		<div class="eff-3"></div>
		<a href="signup.jsp"> 회원가입</a>
	</div>
<div class="button-3">
		<div class="eff-3"></div>
		<a href="main.jsp"> 살아보다 </a>
	</div>
	
	
	
	</div>
	
	<div id="outfrm">
	
		${id}님의 호스트 하우스 등록
		<form id="innerfrm" action="registHouse" method="post"
			enctype="multipart/form-data">
			<div>
				<div class="form-row">



					<div class="form-group">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">집
								메인 사진</label>
						</div>
						<input type="file" class="form-control-file" id="imgInput"
							name="mainpic" required /> <img id="image_section" width="100%"
							src="" alt="your image" />
					</div>




					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01" required>집
								유형</label>
						</div>
						<select name="housetype" class="custom-select"
							id="inputGroupSelect01">
							<option selected required>Choose...</option>
							<option value="1">아파트</option>
							<option value="2">주택</option>
						</select>
					</div>

					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01" required>수용
								인원</label>
						</div>
						<select name="attendanceNum" class="custom-select" id="selbox">
							<option selected required>Choose...</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="6">6</option>
							<option value="direct">직접입력</option>
						</select> <input type="text" name="attendanceDir" class="form-control"
							id="selboxDirect" placeholder="수용 가능 인원 직접입력">

					</div>
				</div>


				<div class="form-group">
					<label for="inputAddress" required>Address</label><br> <input
						type="text" class="form-control" id="inputAddress" name="address"
						placeholder="주소를 입력해주세요.">&nbsp;
					<button type="button" id="LSBtn" class="btn btn-primary">입력</button>
				</div>

				<div id="outputAddress" class="form-group test">
					<div class="test">입력한 주소의 위치</div>
					<div class="test" id="map"></div>
					<div class="test">
						<label class="test" for="exampleInputPassword1" required>상세주소</label>
						<input class=" form-control test" type="text"
							id="exampleInputPassword1" name="addressDetail"
							placeholder="ex) 102동 1001호">
					</div>

				</div>


			</div>
			<div id="firstsubmit">
				<button type="submit" id="signin"class="btn btn-primary">Sign in</button>
			</div>
			
		</form>

	</div>
	</div>

	
<div id ="hf">
	<div id="footer">	
	<br>
	<br>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;오시는 길 | 사이트맵  | 개인정보 처리 방침  | 영상정보처리기기 | 운영,관리방침이용약관 | 채용안내</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;업체명 : ㈜살아보다 사업자등록번호 : 111-11-11111
			주소 : 인천 남구 학익동 663-1 태승빌딩 5층 (1층 홈플러스) 전화번호 : 032-876-3332
			Copyrights(c) ㈜살아보다 </p>
			<h3>since 2020</h3>
	</div>
	</div>

	<!-- name : housetype // attendanceNum // attendanceDir // address //  addressDetail -->

</body>

<script>
function readURL(input) {
	 if (input.files && input.files[0]) {
	  var reader = new FileReader();
	  
	  reader.onload = function (e) {
	   $('#image_section').attr('src', e.target.result);  

	   $("#image_section").show();
	  }
	  
	  reader.readAsDataURL(input.files[0]);
	  }
	}
	  
	  
	  
	$("#imgInput").change(function(){
	   readURL(this);
	});

$(function(){

      //직접입력 인풋박스 기존에는 숨어있다가

$("#selboxDirect").hide();

$("#image_section").hide();


$("#selbox").change(function() {
       //직접입력을 누를 때 나타남

		if($("#selbox").val() == "direct") {

			$("#selboxDirect").show();

		}  else {

			$("#selboxDirect").hide();

		}

		

	}) 

});

$("#LSBtn").click(()=>{
	let locationSearch = $("#inputAddress").val();
	console.log("클릭확인")
	$(".test").css("display", "block");

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  




	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	//시흥시 서울대학로 278번길 19-13
	geocoder.addressSearch(locationSearch, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	    	

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">위치</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    
	      
	     }else{
	    	console.log("위치가 없거나, 제대로 검색해주세요")
	    }
	});    
	
	
	
})






</script>
</html>