<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   #body{margin:0 5%}
   #searchbox{border:3px solid #0B3861;width:40%;height:60px;text-align:center;margin-bottom:30px;}
   input{border:none;width:500px;height:50px;font-size:15px;font-weight:bold;margin-top:1px;}
   button{background-color:#0B3861;border:none;width:70px;height:50px;color:white;font-weight:bold;}
   #middle{width:100%;height:100%;overflow:hidden;border:none;}
   #list{border:none;float:left;width:40%;}
   .out{border:2px solid #0B3861;;width:100%;height:150px;display:flex;margin-bottom:10px;}
      .inner{display:inline-flex;}
      .info{margin-left:20px;width:200px;height:150px;display:inline-flex;font-size:20px;}
   
   #map{border:2px solid #0B3861;float:right;width:56%;}
   
   
   
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<div id = "body">
<h1>검색 키워드 입력후 보이는 창 </h1>
   
  
        <div id="searchbox">
            <input id= "subsearch" type="text" name="destination" value=${destination}>
            <button type="button" id="btn1">검색</button>
         </div>
         
         <div id="middle">
            <div id="list">
            
            </div>
            
            
            <div id="maplay">
            


               <div id="map" style="width:50%;height:800px;">

               
               </div>
               
            </div>
         </div>
   
</div>
</body>
<script>
//---------------------------예상--------------------------------------------
   var $test =${result};  
   console.log("제이슨 변환 String -> obj");
   console.log($test);
   
   var searchlist= document.getElementById("list");
   
   
   
   for(intest in $test ){
      
      var a = $('<div class="out" name = '+$test[intest][0]["H_RGNUM"]+'></div>')
      
      var b = $('<div class="inner"><img class="gg" width="200"height="150" alt=사진없음 src="'+$test[intest][0]["H_MAINPIC"]+'"></div>')
      
      
      
      var c = $('<div class="info">'+'주소지:'+$test[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+$test[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+$test[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+$test[intest][0]["H_ONEPRICE"]+'만원'+'</div>')
      a.append(b);
      a.append(c);
      
      a.on('click', function() {
         console.log("z");
         console.log($(this).attr("name"));
         location.href="detailregiinfo?rgnum="+$(this).attr("name");
         
         
         
      } )
     
      console.log(a.attr("name"));
      
      
      $("#list").append(a)  //--------------검색 리스트 가져오는 것 
           
   }
   

   $('#btn1').click(function() {
      var a =$("#subsearch").val()
      

      a.on('click', function() {
         console.log("z");
         console.log($(this).attr("name"));
         location.href="detailregiinfo?rgnum="+$(this).attr("name");
         
      });
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

      
      $('#btn1').click(function() { //검색 버튼 클릭시 db에서 가져온 새 리스트를 뿌려줌 
      var a =$("#subsearch").val()
      
     $.ajax({
         type:'get',
         url:'changeSearch',//restful방식
         data:{data:a},
         //contentType:"application/json",
         //서버에서 받을때 
         //callback 딴짓하다가 이벤트가 생길시 부름.
         //서버에서 받을때 
         dataType:"json",
         success:function(data){
            console.log(data);
             
            $('#list').empty();
            $('#map').empty();
            
            for(intest in data ){
                  
                  var a = $('<div class="out" name = '+data[intest][0]["H_RGNUM"]+'></div>')
                  
                  var b = $('<div class="inner"><img class="gg" width="200"height="150" alt=사진없음 src="'+data[intest][0]["H_MAINPIC"]+'"></div>')
                  
                  
                  
                  var c = $('<div class="info">'+'주소지:'+data[intest][0]["H_ADDRESS"]+'<br>'+'방 개수:'+data[intest][0]["H_ROOMS"]+'<br>'+'화장실 개수:'+data[intest][0]["H_TOLILET"]+'<br>'+'1박 가격:'+data[intest][0]["H_ONEPRICE"]+'만원'+'</div>')
                  a.append(b);
                  a.append(c);
                  
                  a.on('click', function() {
                     console.log("z");
                     console.log($(this).attr("name"));
                     location.href="detailregiinfo?id="+$(this).attr("name");
                     
                     
                     
                  } )
                 
                  console.log(a.attr("name"));
                  
                  
                  $("#list").append(a)
                 
               }
            
            
            //지도////////////
            

            console.log("=====하동원=========");
            let mapdetail =new Array;
            console.log(mapdetail);


            for(intest in data ){
               let innerList = new Array;
               
               innerList.push($test[intest][0]["H_RGNUM"]);
               innerList.push($test[intest][0]["H_ADDRESS"]);
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
   
   
  
   
   
   
   













<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=54a97da9ea0c80921e6f0c3700f67b67&libraries=services"></script>

<script>
//${result}
console.log("=====하동원=========");
let mapdetail =new Array;
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

let markers = [];
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
console.dir($("#daum.maps.Marker.Area:1"));
console.log($("#daum.maps.Marker.Area:1"));



</script>

</html>