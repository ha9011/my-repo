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
      #img{margin-bottom:2%;width:70%;height:50%;overflow:hidden;border:none;}
         #mainimg{border:1px solid black;width:70%;height:40%;margin-bottom:10px;}
      #reservation{display:inline-flex;width:30%;height:300px;border:1px solid black;margin-left:2%;margin-bottom:10px;}
      
  /*  #sldimg{margin-bottom:2%;width:70%;height:800px;overflow:hidden;border:none;} */
      #subimg{border:1px solid black;width:100%;height:40%;margin-bottom:10px;}
   
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

            <div id = "subimg">
               <h1>슬라이드사진</h1>
            </div>
           
      </div>
            
      
            
            <div id="reservation">
               <h1>예약<h1> 
               <input type="text" name="daterange" id="a1" value="예약날짜 선택">
               
            </div>
      
   </div>
     
       <div id = "subimg">
               <h1>슬라이드사진</h1>
            </div>
      
      
      <div id= "middle">
      
      
         <div id="review">
            <h1>후기</h1>
         </div>
      
         <div id="reple">
            <h1>댓글 대댓글</h1>
            <div id="showreple"></div><br>
            	<div id="rreple">aa</div>
            <div id="inputreple"><input type="text" id="input" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다.">
      <button type="button" id="replepush" >등록</button><input id="chc" type="checkbox" name="비밀" value="비밀글" >비밀글</div>
      	</div>

            
         </div>
      
      
      
      <div id = "bottom">
         <h1>주의사항</h1>
      </div>
      
      
   
</form>

<script>


console.dir($("a1"));

 var date = new Date();
 console.dir(date);
$(function() {
	
	  $('input[name="daterange"]').daterangepicker({     
		 
		 
		 minDate:new Date(),
		 maxDate: "4" 
		 
		 
		
	  }, function(start, end, label) {
		  
		console.dir($(this));
	    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
	    $("#a1").val(start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'))
	  });
	});

	
	for(i in ${reple}){
	
	   
	   var a = $('<div class="printreple"></div>');
	   
	   var b = $('<div class="reple">'+'댓글번호 :  '+${reple}[i][0]["RP_NUM"]+'아이디 :  '+${reple}[i][0]["RP_ID"]+'<br>'
			   +'     '+${reple}[i][0]["RP_TIME"]+'<br>'
	   				+'<div class innerreple>'+${reple}[i][0]["RP_CONTENT"]+'<br>'+${reple}[i][0]["RP_TYPE"]+'</div>'+'</div>')
			   
	   a.append(b);
	   
	   $("#showreple").append(a);
	
	}

	

$("#replepush").click(function() {
	  $("#showreple").empty();
	var type;
	if($("#chc").prop('checked')){
	 type=1;
	}else{
	 type=0;	
	}
	
	console.log($("#chc").prop('checked'));
	console.log("동작");
	var repledata = [];
	var id1 = '${id}';
	var temp = $("#input").val();
	var rep = $test[0][0]["H_RGNUM"];
	
	
	console.log(rep);
	console.log(id1);
	console.log(temp);
	

	repledata.push(type);
	repledata.push(rep);
	repledata.push(id1);
	repledata.push(temp);

	var $test=${result};

	
	console.log(repledata);
	
 	var result=JSON.stringify(repledata);
	
 	$.ajax({
		type : 'get',
		url : "inputreple",
		data : {reple : result},
		datatype:"json",
		
		//서블릿 성공시 돌아오는곳  $test[0][0]["H_RGNUM"];
		
		success:function(reple){
			var result = JSON.parse(reple);
			
			
			console.log(typeof result);
			console.log(result);
			console.dir(result);
			for(i in result){
				console.log(result[i]);
			   
			   var a = $('<div class="printreple"></div>');
			   
			   var b = $('<div class="reple">'+'댓글번호 :  '+result[i][0]["RP_NUM"]+'아이디 :  '+result[i][0]["RP_ID"]+'<br>'
					   +'     '+result[i][0]["RP_TIME"]+'<br>'
			   				+'<div class innerreple>'+result[i][0]["RP_CONTENT"]+'<br>'+result[i][0]["RP_TYPE"]+'</div>'+'</div>')
					   
			   a.append(b);
			   
			   $("#showreple").append(a);
			
			}
		}	,
		error:function(error){
			console.log(error);
		}
		
		
	});
 })





console.dir($("a1"));

 var date = new Date();
 console.dir(date);
$(function() {
   
     $('input[name="daterange"]').daterangepicker({     
       
       
       minDate:new Date(),
       maxDate: new Date(''),
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

</script>


</body>
</html>




