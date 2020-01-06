<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
#outfrm {
	font-family: "문체부훈민정음";
	width: 600px;
	height: 900px;
	border: 1px solid gray;
	text-align: left;
	margin: 100px auto;
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

#LSBtn {
	margin: 0 0 5px 0;
}

#firstsubmit {
	margin: 100px 0 0 0;
}


</style>

<body>





	<div id="outfrm">
		${id}님의 호스트 하우스 등록
		<form id="innerfrm" action="registHouse" method="get">
			<div>
				<div class="form-row">

					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">주차
								가능 여부</label>
						</div>
						<select name="parkarea" class="custom-select"
							id="inputGroupSelect01">
							<option selected>Choose...</option>
							<option value="1">예</option>
							<option value="0">아니요</option>
						</select>
					</div>

					<!-- 				방 갯수 -->
					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">방
								갯수</label>
						</div>
						<select name="roomscnt" class="custom-select" id="selbox">
							<option selected>Choose...</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4개 이상</option>
						</select>
					</div>


					<!-- 				욕실 수 -->
					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">욕실
								수</label>
						</div>
						<select name="attendanceNum" class="custom-select" id="selbox">
							<option selected>Choose...</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4개 이상</option>
						</select>
					</div>


					<!-- 				침대 수 -->
					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">침대
								수</label>
						</div>
						<select name="attendanceNum" class="custom-select" id="selbox">
							<option selected>Choose...</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4개 이상</option>
						</select>
					</div>


					<!-- 				화장실 -->
					<div class="form-group col-md-6">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">화장실
								수</label>
						</div>
						<select name="attendanceNum" class="custom-select" id="selbox">
							<option selected>Choose...</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4개 이상</option>
						</select>
					</div>


					<!--사진첨부 -->
					<div class="form-group" style="width: 100%;">
						<label for="exampleFormControlFile1">Example file input</label> <input
							multiple="multiple" name="houseimg[]" type="file"
							class="form-control-file" id="imgInp">
					</div>


					<!--미리보기 -->
					<div>
						<div class="imgs_wrap"></div>

						<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
							class="next" onclick="plusSlides(1)">&#10095; </a>
					</div>

				</div>

				<br>

				<div style="text-align: center">
					<span class="dot" onclick="currentSlide(1)"></span> <span
						class="dot" onclick="currentSlide(2)"></span> <span class="dot"
						onclick="currentSlide(3)"></span>
				</div>

			</div>



			<div id="secondsubmit">
				<button type="submit" class="btn btn-primary">Sign in</button>
			</div>
		</form>

	</div>



	<!-- name : housetype // attendanceNum // attendanceDir // address //  addressDetail -->

</body>

<script>
let list ;
let indexpic ;
$(function() {
    $("#imgInp").on('change', function(){
        
    	indexpic = [0,1,2];
        readURL(this,indexpic);
        console.log(typeof list);
        console.log(list);
        
       // readListURL(list,indexpic);
        
    });
    
    
});




function readURL(input,indexpic) {
	
	
	let files = input.files;
	let total = input.files.length;
	list = total;
	let filesArr = Array.prototype.slice.call(files);  // 객체 -> 배열
	
	filesArr.forEach((e,i)=>{
		if(!e.type.match("image.*")){
			alert("이미지 확장자가 아닙니다.")
			return;
		}
		console.log(i);

		console.log(indexpic)
		console.log(indexpic.indexOf(i))
		
		let reader = new FileReader();
		if(indexpic.indexOf(i) !== -1){
		
			reader.onload = function(r){
				console.dir(r);
				
				let img_html = "<div class='mySlides pic"+i+"'  style='display:inline-block' >  <div class='numbertext'>"+(i+1)+" / "+total+"</div> "
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
	
	
//     if (input.files.length > 0) {
//     	var reader = new FileReader();

//     	console.dir("dir reader : "+input);
//     	console.dir(reader);
    		
//     	reader.onload = function (e) {
        
//     		$('#blah').attr('src', e.target.result);
//         }

//       reader.readAsDataURL(input.files[0]);
//     }
	return filesArr;
}

function readListURL(indexpic) {
	
	
	
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
	
</script>

</html>