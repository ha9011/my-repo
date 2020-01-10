<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style>
   body{margin:0 5%;}
   #top{display:flex;}
      #img{margin-bottom:2%;width:70%;height:800px;overflow:hidden;border:none;}
         #mainimg{border:1px solid black;width:70%;height:40%;margin-bottom:10px;}
         #subimg{border:1px solid black;width:90%;height:57%;}
      #reservation{display:inline-flex;width:30%;height:300px;border:1px solid black;margin-left:2%;}
   
   #middle{display:flex;;margin-bottom:2%;;width:100%;height:50%;overflow:hidden;}
      #review{margin-bottom:2%;border:1px solid black;width:50%;height:48%;}
      #reple{margin-bottom:2%;border:1px solid black;width:50%;height:48%;margin-left:10px;}
      
   
   #bottom{width:100%;height:50%;overflow:hidden;border:1px solid black;}
 .detail{border:1px solid black;width:95%;height:230px;display:flex; margin:auto;}
		.inner{display:inline-flex;}
		.info{width:200px;height:150px;display:inline-flex;}
   #a1{ height :30%;
   }
</style>

</head>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<body>

<h1>예약 디테일 페이지 </h1>
<form action="">
      
   <div id="top">
         
      <div id="img">
            <div id = "mainimg">
              
            </div>
            
            <div id = imgs_wrap>
            
               <h1>슬라이드사진</h1>
            
           
            
            
            </div>
             <a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
							class="next" onclick="plusSlides(1)">&#10095; </a>
           
      </div>
            
      
            
            <div id="reservation">
               <h1>날짜 예약</h1> 
               <input type="text" name="daterange" id="a1" value="2020-01-03 ~ 2020-01-05">
               
            </div>
      
   </div>
      
      
      
      <div id= "middle">
      
         <div id="review">
            <h1>후기</h1>
         </div>
      
         <div id="reple">
            <h1>댓글 대댓글</h1>
         </div>
      
      </div>
      
      <div id = "bottom">
         <h1>주의사항</h1>
      </div>
      
      
   
</form>

<script>

console.dir($("a1"));


$(function() {
	  $('input[name="daterange"]').daterangepicker({	     
		 
		  opens: 'left'
	  }, function(start, end, label) {
		  
		  console.dir($(this));
	    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
	    $("#a1").val(start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'))
	  });
	});
	
	
	
	
	
	
	var $test=${result};
	
	var a = $('<div class="detail"></div>');
	
	console.log($test[0][0]["H_MAINPIC"]);
	var b = $('<div class="mainpic"><img width="200" height="150" alt=사진없음 src="'+$test[0][0]["H_MAINPIC"]+'"></div>');
	var c = $('<div class="info">'+'주소:  '+$test[0][0]["H_ADDRESS"]+'  '+$test[0][0]["H_DETAILADD"]+'<br>'
			+'숙박가능 날짜:  '+$test[0][0]["H_CHECKIN"]+'~'+$test[0][0]["H_CHECKOUT"]+'<br>'
			+'수용가능인원:  '+$test[0][0]["H_ATTENDANCE"]+'<br>'
			+'1박가격:  '+$test[0][0]["H_ONEPRICE"]+'<br>'
			+'방갯수:  '+$test[0][0]["H_ROOMS"]+'<br>'
			+'침대수:  '+$test[0][0]["H_BEDROOMS"]+'<br>'
			+'화장실:  '+$test[0][0]["H_TOLILET"]+'<br>'
			+'주차가능:  '+$test[0][0]["H_PARKABLE"]+'<br>'
			+'욕실:  '+$test[0][0]["H_BATHROOMS"]+'<br>'+
			'</div>')
	a.append(b);
	a.append(c);
	$("#mainimg").append(a);
	
	console.log($test);
	console.dir($test);
	console.log($test[0]);
	console.dir($test[0]);
	
	
	
	
	
	
	
	//하동원 detail 사진!
	
	
	var a = $test[0][0]["H_DETAILPICS"];
	var jbSplit = a.split(',');
	console.log(jbSplit);	
	var result = jbSplit.slice(0, jbSplit.length-1 )
	console.log(result);	

	let indexpic = [0,1,2];
	
	
	for(let i in result){
		if(i<=2){  // 3 이상일때
			$("#imgs_wrap").append( $('<div class="mySlides" style="display:inline-block"> <img width="100px" height="100px" src="'+result[i] +'" ></div>') );
				
		}else{
			$("#imgs_wrap").append( $('<div class="mySlides" style="display:none"> <img width="100px" height="100px" src="'+result[i] +'" ></div>')  );
			
		}
		
	}
	
	

	function readListURL(indexpic) {
		
		console.log("사진 변경 띠 " )
		
		let files1 = $(".mySlides");
		let total = files1.length;
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

	
	let plusSlides = (e)=>{
		console.log("화살표 눌렀습니다 : " + e)
		let files2 = $(".mySlides");   // myslides 모으기
		
		//console.log("list : " + list);

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
		
		console.log(e);
	}
	
	
	
</script>


</body>
</html>





