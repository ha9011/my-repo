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
	#list{border:2px solid #0B3861;float:left;width:40%;}
	.out{border:1px solid black;width:100%;height:200px;display:flex;}
		.inner{display:inline-flex;}
		.info{width:200px;height:150px;display:inline-flex;}
	
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
				<div id="list">
					
					
				</div>
				
				
				<div id="maplay">
				
					<div id="map" style="width:500px;height:400px;"></div>
				
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
		var c = $('<div class="info">'+$test[intest][0]["H_ADDRESS"]+'<br>'+$test[intest][0]["H_ROOMS"]+'<br>'+$test[intest][0]["H_TOLILET"]+'<br>'+$test[intest][0]["H_ONEPRICE"]+'</div>')
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
	console.log("=====하동원=========");
	let mapdetail =new Array;
	console.log(mapdetail);
	
	
	for(intest in $test ){
		let innerList = new Array;
		
		innerList.push($test[intest][0]["H_RGNUM"]);
		innerList.push($test[intest][0]["H_ADDRESS"]);
		mapdetail.push(innerList);
	}
	
	console.log("========데이터구조[완]=========")
	console.log(mapdetail);
	
	
	
	

</script>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=54a97da9ea0c80921e6f0c3700f67b67&libraries=services"></script>

<script>
let $testt = ${result}
var infowindow = new kakao.maps.InfoWindow({zIndex:1});





var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
let map = new kakao.maps.Map(mapContainer, mapOption); 


// 주소-좌표 변환 객체를 생성합니다
let geocoder = new kakao.maps.services.Geocoder();



// 여기서 포문 돌리면 됨//


console.log("=====");
let wedokuyngdo =new Array;
let bounds = new kakao.maps.LatLngBounds();
console.log(wedokuyngdo);
//주소로 좌표를 검색합니다

for(intest in $testt ){
	let innerList = new Array;
	//innerList.push($test[intest][0]["H_RGNUM"]);
	innerList.push($testt[intest][0]["H_ADDRESS"]);

	geocoder.addressSearch($testt[intest][0]["H_ADDRESS"], function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	if (status === kakao.maps.services.Status.OK) {
		console.log("돌기");
		let inner = new Array;
		inner.push(result[0].y);
		inner.push(result[0].x);
		
		

	        
	            displayMarker(result[0].y, result[0].x);    
	            bounds.extend(new kakao.maps.LatLng(result[0].y, result[0].x));
	              

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	      
		
		
		
		map.setBounds(bounds);
		console.log(inner);
		wedokuyngdo.push(inner);
	} 
	
	    
	});  

}




console.log("===위도 경도==");
console.log(wedokuyngdo);

for(i in wedokuyngdo){

	console.log("test");

	console.log("위도 : " +i[0]);
	console.log("경도 : " +i[1]);
}


function displayMarker(y,x) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(y, x) ,
  		zIndex: "하동원"
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
       	var content = '<div style="padding:5px;z-index:1;">zzzzzzzzzzzzzzzzzzzzzzzzzzzzzhh</div>';
       	console.dir(marker);
        infowindow.setContent(content);
        infowindow.open(map, marker);
    });
}  




</script>


</html>