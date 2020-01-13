<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<style>
body {
	margin: 0 5%;
}

#top {
	display: flex;
}

#img {
	margin-bottom: 2%;
	width: 70%;
	height: 50%;
	overflow: hidden;
	border: none;
}

#mainimg {
	border: 1px solid black;
	width: 70%;
	height: 40%;
	margin-bottom: 10px;
}

#reservation {
	display: inline-flex;
	width: 30%;
	height: 300px;
	border: 1px solid black;
	margin-left: 2%;
	margin-bottom: 10px;
}

/*  #sldimg{margin-bottom:2%;width:70%;height:800px;overflow:hidden;border:none;} */
#subimg {
	border: 1px solid black;
	width: 100%;
	height: 40%;
	margin-bottom: 10px;
}

#middle {
	display: flex;;
	margin-bottom: 2%;;
	width: 100%;
	height: 50%;
	overflow: hidden;
}

#review {
	margin-bottom: 2%;
	border: 1px solid black;
	width: 50%;
	height: 48%;
}

#reple {
	margin-bottom: 2%;
	border: 1px solid black;
	width: 50%;
	height: 48%;
	margin-left: 10px;
}

#bottom {
	width: 100%;
	height: 50%;
	overflow: hidden;
	border: 1px solid black;
}

.detail {
	border: 1px solid black;
	width: 95%;
	height: 230px;
	display: flex;
	margin: auto;
}

.inner {
	display: inline-flex;
}

.info {
	width: 200px;
	height: 150px;
	display: inline-flex;
}

#a1 {
	height: 30%;
}
</style>

</head>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>


<body>

	<h1>예약 디테일 페이지</h1>
	<form action="">
		<div>
			<div id="top">

				<div id="img">
					<div id="mainimg"></div>

					<div id=imgs_wrap>

						<h1>슬라이드사진</h1>





					</div>
					<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
						class="next" onclick="plusSlides(1)">&#10095; </a>

				</div>


			</div>

			<div id="reservation">

				<h1>예약</h1>
				<input type="text" id="datepicker1"> ~
   				 <input type="text" id="datepicker2">

			</div>

		</div>

		<div id="subimg">
			<h1>슬라이드사진</h1>
		</div>


		<div id="middle">


			<div id="review">
				<h1>후기</h1>
			</div>

			<div id="reple">
				<h1>댓글 대댓글</h1>
				<div id="showreple"></div>
				<br>
				<div id="rreple">aa</div>
				<div id="inputreple">
					<input type="text" id="input"
						placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다.">
					<button type="button" id="replepush">등록</button>
					<input id="chc" type="checkbox" name="비밀" value="비밀글">비밀글
				</div>
			</div>


		</div>



		<div id="bottom">
			<h1>주의사항</h1>
		</div>



	</form>

	<script>
	
	for(i in ${reple}){
	
	   
	   var a = $('<div class="printreple"></div>');
	   
	   var b = $('<div class="reple">'+'댓글번호 :  '+${reple}[i][0]["RP_NUM"]+'아이디 :  '+${reple}[i][0]["RP_ID"]+'<br>'
			   +'     '+${reple}[i][0]["RP_TIME"]+'<br>'
	   				+'<div class innerreple>'+${reple}[i][0]["RP_CONTENT"]+'<br>'+${reple}[i][0]["RP_TYPE"]+'</div>'+'</div>')
			   
	   a.append(b);
	   
	   $("#showreple").append(a);
	

	   
	}

	

$("#replepush").click(function() {
	
	var $test=${result};
	
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
	
	console.log("=====================ajax")
	console.log($test)
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
	
	
	var disabledDays = [];  //"2020-01-15"
		
	$(document).ready(function(){
		$("#datepicker1, #datepicker2").datepicker({
			
		 	dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		  
		    minDate: new Date(),
		    maxDate: new Date($test[0][0]["H_CHECKOUT"].substr(0,10)),
			beforeShowDay:function(date){
		        var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
		        return [ disabledDays.indexOf(string) == -1 ]
		    },
// 		    onSelect: function(dateText) {  
// 		    	console.log(disabledDays[0])
// 		    	var a = new Date(disabledDays[0]);
// 		    	$("#datepicker1").datepicker('option', 'maxDate', new Date(disabledDays[0]));
//            }



			});
		
	});
	
	
	
	 var listDate = [];
	function getDateRange(startDate, endDate, listDate){

        var dateMove = new Date(startDate);
        var strDate = startDate;

        if (startDate == endDate){

            var strDate = dateMove.toISOString().slice(0,10);

            listDate.push(strDate);

        }else{

            while (strDate < endDate){

                var strDate = dateMove.toISOString().slice(0, 10);

                listDate.push(strDate);

                dateMove.setDate(dateMove.getDate() + 1);

            }

        }

        return listDate;

    };
   

    

    getDateRange('2017-02-01', '2017-02-05', listDate);

	
	console.log(listDate);

	
</script>



</body>
</html>




