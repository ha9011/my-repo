<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<style>
   body{margin:0 5%;}
  #top{border : 1px solid black; width:100%;}
   #img{margin-bottom:2%;width:100%;height:50%;overflow:hidden;border:none;}
   #detail{border:1px solid black;width:95%;height:250px; display:flex; margin : 10px auto;}	
   .info{width:400px; height:250px; display:inline-block; margin : 0px 0px 0px 20px}
   .mainpic{width:250px; height:250px; display:inline-block;}
   #mainimg{}
      
    #imgs_wrap{margin : 0 auto; display : inline-block;}  
  /*  #sldimg{margin-bottom:2%;width:70%;height:800px;overflow:hidden;border:none;} */
    #subimg{border:1px solid black;width:100%;height:40%;margin-bottom:10px;}
   
   #middle{display:flex;; margin :10px 0px 10px 0px ; width:100% ; height:50%; border : 1px solid black}
   
   #review{margin : 5px 5px 5px 5px; border:1px solid black; width:50%; height:50%;}
   #rightpart{margin : 5px 5px 5px 5px; border:1px solid black; width:50%; height:50%;}
   #reservation{margin : 5px 5px 5px 5px; width:97%; height:200px; border:1px solid black;text-align: center;}
   #reple{margin : 5px 5px 5px 5px; width:97%; height:50%; border:1px solid black;}
      
   
   #bottom{width:100%;height:50%;overflow:hidden;border:1px solid black;}
 
      .inner{display:inline-flex;}
      
  
   #imgdetail{text-align: center; }
	.mySlides{margin : 0px 20px}
	.nextbtn{display : inline-block;}

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
	
		<div>
			<div id="top">

				<div id="img">
					<div id="mainimg"></div>
					
					<div id="imgdetail">
					<div class="nextbtn">
					<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
					</div>
					<div id=imgs_wrap>

					</div>
					<div class="nextbtn">
					 <a	class="next" onclick="plusSlides(1)">&#10095; </a>
					 </div>
					</div>
				</div>


			</div>

			

		</div>

		


		<div id="middle">


			<div id="review">
				<h1>후기</h1>
			</div>

			
			<div id="rightpart">
			<div id="reservation">

				<h1>예약</h1>
				<form>
				<input type="text" id="datepicker1"> ~
   				<input type="text" id="datepicker2">
   				<input type="text" id="datepicker2">
   				
   				<button>예약하기</button>
				</form>
			</div>

			<div id="reple">
				<h1>문의사항</h1>
				<hr>
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

		</div>



		<div id="bottom">
			<h1>주의사항</h1>
		</div>




	<script>


	
////////////페이지 부를때 바로 부르는 댓글
	for(i in ${reple}){
	
	   
	   var a = $('<div class="printreple"></div>');
	   
	   var b = $('<div class="reple">'+'댓글번호 :  '+${reple}[i][0]["RP_NUM"]+'아이디 :  '+${reple}[i][0]["RP_ID"]+${reple}[i][0]["RP_TIME"]+'<br>'
	   				+${reple}[i][0]["RP_CONTENT"]+'<br>'
	   				+'<button id="'+${reple}[i][0]["RP_NUM"]+'" class="rreplebtn">'+'답글'+'</button>'+'<br>'+'</div>');
	   				
	   var c = $('<div class="rreple" id="rreple'+${reple}[i][0]["RP_NUM"]+'"></div>');
	   var d = 	$('<div class="rreplecnt" id="rreplecnt'+${reple}[i][0]["RP_NUM"]+'"></div>');
	  
	   
	   c.append(d);			
	   
	   
//  	   				+'<div class="rreple" id="rreple'+${reple}[i][0]["RP_NUM"]+'"><div><input type="text" id="rreplecontent'+${reple}[i][0]["RP_NUM"]'">'
//  	   				+'<button class="rrepleput" id="'+${reple}[i][0]["RP_NUM"]+'">'+'등록'+'</button></div></div>'); 
	   				
	   				
	   		
	   console.log("--")
	   console.log(b);
	   
	   a.append(b);
		a.append(c);	
	   $("#showreple").append(a);
	

	   
	}
	
	
	//대댓창 보여주는 펑션	AJAX	
	 $(".rreplebtn").on("click",function(){  //답글창 누르면 나옴   --> ajax로 바꿔줄것. 댓글 나오도록 하는 것 !!
		 
			var temp = $(this).attr('id');  // 해당 댓글 번호 
			console.log($(this).attr('id'));
			$('#rreple'+$(this).attr('id')).css("display", "block");   	
			
			$.ajax({
				type : 'get',
				url : "showrreple",
				data : {replenum : temp},
				datatype:"json",
				
				//서블릿 성공시 돌아오는곳  $test[0][0]["H_RGNUM"];
				
				success:function(rreple){
				
					
				var obj=JSON.parse(rreple);
					
					console.log(typeof obj);
					console.log(obj);
					console.dir(obj);
					console.log("나와줘제발22");
					
					for(i in obj){
						
					   
					   
					   var a = $('<div class="replee">'+'댓글번호 :  '+obj[i][0]["RRP_NUM"]+'아이디 :  '+obj[i][0]["RRP_ID"]+'<br>'
							   +'     '+obj[i][0]["RRP_TIME"]+'<br>'
					   				+'<div class=innerreple>'+obj[i][0]["RRP_CONTENT"]+'<br>'+obj[i][0]["RRP_RP_NUM"]+'</div>'+'</div>')
							   
					   $("#rreplecnt"+temp).append(a);
					   
					   
					}
					
					var d= $('<input type="text" id="rreplecontent'+temp+'" ><button class="rrepleput" id="'+temp+'">'+'등록'+'</button>');
					$("#rreplecnt"+temp).after(d);
					
					//대댓글 디비에 보내기 성공했음	(ajax)
					$(".rreple").on('click','.rrepleput',function() {
						
						
						$("#rreplecnt").empty();   // rreplecnt <- 대댓글이 쌓이는 곳 // 댓글 쓰면 타 댓글 다 사라지고 보여짐 일단 몰라
						var temp =$(this).attr('id');
						var a=$("#rreplecontent"+temp).val();
						console.log(a);
						
						var rrepledata=[];
						
						
						rrepledata.push(a);
						rrepledata.push(temp);
						
						var result=JSON.stringify(rrepledata);
						
						$.ajax({
							type : 'get',
							url : "inputrreple",
							data : {rreple : result},
							datatype:"json",
							
							//서블릿 성공시 돌아오는곳  $test[0][0]["H_RGNUM"];
							
							success:function(rreple){
							
								$("#rreplecnt"+temp).empty();
							var obj=JSON.parse(rreple);
								
								console.log(typeof obj);
								console.log(obj);
								console.dir(obj);
								for(i in obj){
									console.log("나와줘제발");
									console.log(obj[i][0]["RRP_CONTENT"]);
								   
								   
								   var a = $('<div class="replee">'+'댓글번호 :  '+obj[i][0]["RRP_NUM"]+'아이디 :  '+obj[i][0]["RRP_ID"]+'<br>'
										   +'     '+obj[i][0]["RRP_TIME"]+'<br>'
								   				+'<div class=innerreple>'+obj[i][0]["RRP_CONTENT"]+'<br>'+obj[i][0]["RRP_RP_NUM"]+'</div>'+'</div>')
										   
								   $("#rreplecnt"+temp).append(a);
								   
								   console.log("test======temp : " + temp);
								   console.dir($("#rreplecnt"+temp));
								
								}
							}	,
							error:function(error){
								console.log(error);
							}
							
							
						});
						
					}) 
					
				}	,
				error:function(error){
					console.log(error);
				}
				
				
			});
			 
			 
			 
	 });
	
	

	
 

	
	


$("#replepush").click(function() { //아이디 리플푸쉬를 갖고 있는 버튼 클릭시 클릭 이벤트를 준다
	  $("#showreple").empty(); //쇼리플창  초기화 해주는 곳
	var type; //비밀인지 아닌지 타입을 담을 변수
	//
	if($("#chc").prop('checked')){ //체크박스 값을 담는다
	 type=1;
	}else{
	 type=0;	
	} 
	console.log($("#chc").prop('checked')); // 체크박스 동작 확인
	//
	
	var repledata = []; //리플데이터를 키 데이터 형식으로 넣어줄 틀
	var id1 = '${id}'; //리플 아이디 아마세션에서 뽑아온 이엘
	var temp = $("#input").val(); //리플컨텐츠
	var rep = $test[0][0]["H_RGNUM"]; //리플 방넘버
	
	console.log("=====================ajax")
	console.log($test)
	console.log(rep);
	console.log(id1);
	console.log(temp); // 만든 값들을 출력한다
	

	repledata.push(type); //배열에 필요한 값들 넣어주기
	repledata.push(rep);
	repledata.push(id1);
	repledata.push(temp);
	
	console.log(repledata); // 마지막으로 만들어진 배열을 확인해본다
	
 	var result=JSON.stringify(repledata); //배열을 같은 오브잭트 형식을  스트링파이를  이용해서 스트링으로 바꾸고 리설트에 삽입 
	
 	$.ajax({//에이작스 시작 // 입력과 출력을 한번에 가능함 ??
		type : 'get',  
		url : "inputreple",
		data : {reple : result}, //리플 이엘에 리설트가 담아진다
		datatype:"json",    //여기까지 하고 서블릿으로 간다
							
							//서블릿 성공하고 여기로 돌아온다  $test[0][0]["H_RGNUM"];
		
		success:function(reple){   //서블릿에서의 과정들 성공후에 돌아온다 리설트리턴 값에는 객체화 된 엠리스트가 돌아온다 
			var result = JSON.parse(reple); //리서트 제이슨으로 파싱한다-->파싱은 스트링을 오브젝트 형태로 바꿔준다.   
			
			
			console.log(typeof result); //리설트에 타입을 알아보기 위해
			console.log(result); // 단순 리설트 값
			console.dir(result); // 상세하게 뜯어보기
			for(i in result){ // i에 리설트를 다 담고
				console.log(result[i]);
			   
			   var a = $('<div class="printreple"></div>'); //div생성하는 a 변수
			   
			   var b = $('<div class="reple">'+'댓글번호 :  '+result[i][0]["RP_NUM"]+'아이디 :  '+result[i][0]["RP_ID"]+'<br>'
					   +'     '+result[i][0]["RP_TIME"]+'<br>'
			   				+'<div class innerreple>'+result[i][0]["RP_CONTENT"]+'<br>'+result[i][0]["RP_TYPE"]+'</div>'+'</div>')
					   //필요한 데이터를 필요한 형태로 출력하는 b 변수
			   a.append(b); //a에 b를 넣는다. 필요한 정보의 형태를 다 만든거
			   
			   $("#showreple").append(a); //출력하고자 하는 부분에 완성된 a변수를 뿌려준다
			
			}
		}	,
		error:function(error){ //에러시 에러 뜨게하기
			console.log(error);
		}
		
		
	});
 })



   
   
   
   
   
   /////////////////////////////디테일 방정보 보여주기
   var $test=${result}; //프로덕트 엠엠에서 방정보를 담은 리설트 이엘 갖고 온것 
   
   var a = $('<div id="detail"></div>'); // DIV새엇ㅇ
   
   //console.log($test[0][0]["H_MAINPIC"]);
   var b = $('<div class="mainpic"><img width="250" height="250" alt=사진없음 src="'+$test[0][0]["H_MAINPIC"]+'"></div>');
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
   $("#mainimg").append(a); //완성 형태를 원하는 곳에 뿌려주기
   

  
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

	
	//하동원 detail 사진!
	
	
	var a = $test[0][0]["H_DETAILPICS"];
	var jbSplit = a.split(',');
	console.log(jbSplit);	
	var result = jbSplit.slice(0, jbSplit.length-1 )
	console.log(result);	

	let indexpic = [0,1,2];
	
	
	for(let i in result){
		if(i<=2){  // 3 이상일때
			$("#imgs_wrap").append( $('<div class="mySlides" style="display:inline-block"> <img width="200px" height="200px" src="'+result[i] +'" ></div>') );
				
		}else{
			$("#imgs_wrap").append( $('<div class="mySlides" style="display:none"> <img width="200px" height="200px" src="'+result[i] +'" ></div>')  );
			
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




