<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#body {
	margin:1%;
}

#searchbox {
	float:left;
	border: 2px solid #0B3861;
	width: 34%;
	height: 60px;
	text-align: center;
	margin-top:50px;
}

input {
	border: none;
	width: 80%;
	height: 50px;
	font-size: 20px;
	font-weight: bold;
	margin-top: 1px;
}

button {
	float:right;
	margin-right:5px;
	margin-top:5px;
	background-color: #0B3861;
	border: none;
	width: 90px;
	height: 50px;
	color: white;
	font-weight: bold;
}

#middle {
	width: 100%;
	height: 100%;
	overflow: hidden;
	border: none;
}

#list {
	border:none;
	float: left;
	width: 42%;
	
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


#maplay {
	border-left:2px solid #0B3861;
	float: right;
	width: 56%;
}

#map{
	 margin-left:25px;
}


#rogo {
	float:left;
	width: 200px;
	height: 130px;
}


</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
			<a href="main.jsp"><img id="rogo" alt="살다로고" src="./img/살다.png"></a>
	

	<div id="body">
		
		<div id="searchbox">
			<input id="subsearch" type="text" name="destination"
				value=${destination}>
			<button type="button" id="btn1">검색</button>
		</div>

		<div id="middle">
			<div id="list"></div>


			<div id="maplay">
					<div id="map" style="width: 98%; height: 1000px;"></div>
			</div>
		</div>

	</div>
</body>
<script>
//---------------------------예상--------------------------------------------
	console.log("좋아요 리스트 ==");
	console.log('${searchLike}');
	
	
	
   var $test =${result};  
   console.log("제이슨 변환 String -> obj");
   console.log($test);
   
   var searchlist= document.getElementById("list");
   
   
   
   for(intest in $test ){  // 처음 화면 보여주기
      
      var a = $('<div class="out" name = '+$test[intest][0]["H_RGNUM"]+'></div>')
      
    
      //http://t1.daumcdn.net/mapjsapi/images/marker.png
      //http://i1.daumcdn.net/dmaps/apis/transparent.gif
      a.mouseover(function() {
         let b = $(this).attr("name");
         console.log("들어옴 : " + b);
         console.log(markers);
         for(i in markers){
            if(markers[i]["Wa"]===b){
               var x = markers[i]["pd"]["previousSibling"]["previousSibling"];
               //console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]);
               markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]="50px";
            //   console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["height"]);
               
               //29px, 42p
               markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"] = "rect(0px, 80px, 90px, 0px)"
               
               console.log("변경후 ");
               console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"]);
               console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]);
               
               markers[i]["pd"]["previousSibling"]["previousSibling"]["img"];
            }
         }
      } )
      
      a.mouseout(function() {
         let b = $(this).attr("name");
         console.log("나감 : " + b);
         for(i in markers){
            if(markers[i]["Wa"]===b){
               var x = markers[i]["pd"]["previousSibling"]["previousSibling"];
               console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]);
               markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]="29px";
               console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["height"]);
               
               //29px, 42p
               markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"] = "rect(0px, 29px, 42p, 0px)"
               
               console.log("변경후 ");
               console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"]);
               console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]);
               
               markers[i]["pd"]["previousSibling"]["previousSibling"]["img"];
            }
         }
      })
      
      var b = $('<div class="inner" ><img name = '+$test[intest][0]["H_RGNUM"]+' class="gg" width="200"height="150" alt=사진없음 src="'+$test[intest][0]["H_MAINPIC"]+'"></div>')
      
       $(document).on('click','.gg', function() {
                      console.log("zzzz");
                      console.log($(this).attr("name"));
                      location.href="detailregiinfo?rgnum="+$(this).attr("name");
                   } );
      
      var c = $('<div class="info">'+'주소지:'+$test[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+$test[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+$test[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+$test[intest][0]["H_ONEPRICE"]+'만원'+'</div>')
      
      a.append(b);
      a.append(c);
      
      var idcheck = '${id}';
      
      
      if(idcheck===''){ // 비로그인 //하트 안보이게
    	        console.log("하트 이미지 로그인 안됨")
     	  
      }else{  // 로그인 하트 보이게
    	  var likelistt = '${searchLike}';
    	  var likelist = JSON.parse(likelistt);

	        console.log("하트 이미지 로그인 됨")
	        console.log("해당 방 번호 : "+$test[intest][0]["H_RGNUM"])
	        
	        console.log("해당 방 번호 : "+ typeof $test[intest][0]["H_RGNUM"])
	        
	        console.log("해당 방 번호 : "+typeof likelist)
	        
	        
    	  if(likelist[$test[intest][0]["H_RGNUM"]]===1){ 
  	        console.log("로그인 하트")

  	        var d = $('<div style="text-align:right; width:220px"><div "class="like"><img class="likech" data-name = '+$test[intest][0]["H_RGNUM"]+' name="1" width="40" height="40" src="./img/like.png"></div><div>');
    	      
    	      a.append(d);
    	  }else if(likelist[$test[intest][0]["H_RGNUM"]]===0){
    		  console.log("로그인 하트X")
    		  var d = $('<div style="text-align:right; width:220px"><div "class="like"><img class="likech" data-name = '+$test[intest][0]["H_RGNUM"]+' name="0" width="40" height="40" src="./img/donlike.png"></div><div>');
    	      
    	      a.append(d);
    	  }else{
    		  console.log("로그인 하트Xx")
			  var d = $('<div style="text-align:right; width:220px"><div "class="like"><img class="likech" data-name = '+$test[intest][0]["H_RGNUM"]+' name="0" width="40" height="40" src="./img/donlike.png"></div><div>');
    	      
    	      a.append(d);
    	  }
      }
     
      
      
     
     
      console.log(a.attr("name"));
      
      
      $("#list").append(a)

           
   }
   
   
   
 
   
   $(document).on('click','.likech',function(){
	   	console.log($(this).attr("name"));
		console.log($(this).data("name"));
	   	
	 	if($(this).attr("name")==="1"){
	 		
	 		$(this).attr("name", "0");
	 		$(this).attr("src", "./img/donlike.png");
	 	}else{
	 		$(this).attr("name", "1");
	 		$(this).attr("src", "./img/like.png");
	 	}
	 	
	 	var likeval = $(this).attr("name");
	 	var likeid = '${id}';
	 	var likename = $(this).data("name")
	 	
	 	var likearr=[]
	 	likearr.push(likeval);
	 	likearr.push(likeid);
	 	likearr.push(likename);
	 	console.log("===ajax like 보낼 데이터 ====")
	 	console.log(likearr);
	 	
	 	var result = JSON.stringify(likearr);
	 	$.ajax({ // 업로드 요청 받아오는 ajax
	 	    type:'get',
	 	    url:'likechecked',//restful방식
	 	    data:{data:result},
	 	    //서버에서 받을때 
	 	    dataType:"html",
	 	    
	 	    success:function(data){
	 	    	console.log("ajax 성공")
	 	       
	 		},
	 		error:function(error){
	 	    	console.log("ajax 실패")
				console.log(error);
	 		}
	 	}); //ajax end  
   })
   
   
   
   
//ajax
  
      

     

      
    $('#btn1').click(function() {
      console.log("ajax검색");
      var a =$("#subsearch").val()
      
     $.ajax({
         type:'get',
         url:'changeSearch',//restful방식
         data:{data:a},
         //contentType:"application/json",
         //서버에서 받을때 
         dataType:"json",
         //callback 딴짓하다가 이벤트가 생길시 부름.
         success:function(data){
            console.log(data);
             
            $('#list').empty();
            $('#map').empty();
            
            for(intest in data ){
                  
                  var a = $('<div class="out" name = '+data[intest][0]["H_RGNUM"]+'></div>')
                  
                  var b = $('<div class="inner" ><img name = '+data[intest][0]["H_RGNUM"]+' class="gg" width="200"height="150" alt=사진없음 src="'+data[intest][0]["H_MAINPIC"]+'"></div>')
                  
                  var c = $('<div class="info">'+'주소지:'+data[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+data[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+data[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+data[intest][0]["H_ONEPRICE"]+'만원'+'</div>')
                 
                  a.append(b);
                  a.append(c);
                  
                  $(document).on('mouseover','.out',function() {
                      let b = $(this).attr("name");
                      console.log("들어옴 : " + b);
                      console.log(markers);
                      for(i in markers){
                         if(markers[i]["Wa"]===b){
                            var x = markers[i]["pd"]["previousSibling"]["previousSibling"];
                            //console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]);
                            markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]="50px";
                         //   console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["height"]);
                            
                            //29px, 42p
                            markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"] = "rect(0px, 80px, 90px, 0px)"
                            
                            console.log("변경후 ");
                            console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"]);
                            console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]);
                            
                            markers[i]["pd"]["previousSibling"]["previousSibling"]["img"];
                         }
                      }
                   } )
                   
                    $(document).on('mouseout','.out',function() {
                      let b = $(this).attr("name");
                      console.log("나감 : " + b);
                      for(i in markers){
                         if(markers[i]["Wa"]===b){
                            var x = markers[i]["pd"]["previousSibling"]["previousSibling"];
                            console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]);
                            markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]="29px";
                            console.dir(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["height"]);
                            
                            //29px, 42p
                            markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"] = "rect(0px, 29px, 42p, 0px)"
                            
                            console.log("변경후 ");
                            console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["clip"]);
                            console.log(markers[i]["pd"]["previousSibling"]["previousSibling"]["style"]["width"]);
                            
                            markers[i]["pd"]["previousSibling"]["previousSibling"]["img"];
                         }
                      }
                   })
                  
                  
                  
                  
                  
                  $(document).on('click','.gg', function() {
                      console.log("zzzz");
                      console.log($(this).attr("name"));
                      location.href="detailregiinfo?rgnum="+$(this).attr("name");
                   } );
                 
                 
                  
                  
                  
                  $("#list").append(a)
                 
               }
            
            
            //지도////////////
            

            console.log("=====하동원=========");
            let mapdetail =new Array;
            console.log(mapdetail);


            for(intest in data ){
               let innerList = new Array;
               
               innerList.push(data[intest][0]["H_RGNUM"]);
               innerList.push(data[intest][0]["H_ADDRESS"]);
               mapdetail.push(innerList);
            }

            console.log("========데이터구조[완]=========")
            console.log(mapdetail);

            let markers = [];
            let $testt = data
            let infowindow = new kakao.maps.InfoWindow({zIndex:1});





            let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
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

            for(let intest in $testt ){
               let innerList = new Array;
               //innerList.push($test[intest][0]["H_RGNUM"]);
               innerList.push($testt[intest][0]["H_ADDRESS"]);

               geocoder.addressSearch($testt[intest][0]["H_ADDRESS"], function(result, status ) {

                   // 정상적으로 검색이 완료됐으면 
               if (status === kakao.maps.services.Status.OK) {
                  console.log("돌기 :  "+ data[intest][0]["H_RGNUM"]);
                  let inner = new Array;
                  inner.push(result[0].y);
                  inner.push(result[0].x);
                  
                  displayMarker(result[0].y, result[0].x, data[intest][0]["H_RGNUM"]);    
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


            function displayMarker(y,x,reginum) {
                
                // 마커를 생성하고 지도에 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(y, x) ,
                    zIndex: reginum
                });
                
                markers.push(marker);
                

                // 마커에 클릭이벤트를 등록합니다
                kakao.maps.event.addListener(marker, 'click', function() {
                    // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
                      var content = '<div style="padding:5px;z-index:1;">zzzzzzzzzzzzzzzzzzzzzzzzzzzzzhh</div>';
                      console.dir(marker);
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                });
            }  

            console.log("==markers==");
            console.log(markers);

            console.log("==zzz==");



            
            
         },
         error:function(error){
            console.log(error);

         }
         
     })//ajax end
   }); 
   


   


      </script>



















<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=54a97da9ea0c80921e6f0c3700f67b67&libraries=services"></script>


<script>
//${result}
console.log("=====하동원 지도 부분 kakao=========");


let mapdetail =new Array;    // [[방번호, 주소],[방번호, 주소]...]
console.log(mapdetail);

var $test =${result}; 
for(intest in $test ){
   let innerList = new Array;
   
   innerList.push($test[intest][0]["H_RGNUM"]);
   innerList.push($test[intest][0]["H_ADDRESS"]);
   mapdetail.push(innerList);
}

console.log("========데이터구조[완]=========")
console.log(mapdetail);


//////


let markers = [];  // [[경도,위도],[경도,위도]...]

let $testt = ${result}
let infowindow = new kakao.maps.InfoWindow({zIndex:1});





let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
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

for(let intest in $testt ){
   let innerList = new Array;
   //innerList.push($test[intest][0]["H_RGNUM"]);
   innerList.push($testt[intest][0]["H_ADDRESS"]);

   geocoder.addressSearch($testt[intest][0]["H_ADDRESS"], function(result, status ) {

       // 정상적으로 검색이 완료됐으면 
   if (status === kakao.maps.services.Status.OK) {
      console.log("돌기 :  "+ $test[intest][0]["H_RGNUM"]);
      let inner = new Array;
      inner.push(result[0].y);
      inner.push(result[0].x);
      
      displayMarker(result[0].y, result[0].x, $test[intest][0]["H_RGNUM"]);    
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


function displayMarker(y,x,reginum) {  // 마커를 지도에 표시하는 것
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(y, x) ,
        zIndex: reginum
    });
    
    markers.push(marker);    // 경도 위도에 추가
    

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
          var content = '<div style="padding:5px;z-index:1;">zzzzzzzzzzzzzzzzzzzzzzzzzzzzzhh</div>';
          console.dir(marker);
        infowindow.setContent(content);
        infowindow.open(map, marker);
    });
}  

console.log("==markers==");
console.log(markers);

console.log("==zzz==");
console.dir($("#daum.maps.Marker.Area:1"));
console.log($("#daum.maps.Marker.Area:1"));


</script>

</html>