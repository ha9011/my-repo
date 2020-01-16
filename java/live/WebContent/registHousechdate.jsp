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
#outfrm {
	width: 600px;
	height: 1200px;
	border: 1px solid gray;
	text-align: left;
	margin: 100px auto;
}

button{
	color: white;
	background-color: #0B243B;
}
</style>

<body>





	<div id="outfrm">
		${id}님의 호스트 하우스 등록
		<form id="innerfrm" action="registHousechdate" method="post">
			몇일부터 : <input type='date' name='mindate' /><br> 몇일까지 : <input
				type='date' name='maxdate' /><br> 1박 당 가격<input type="number"
				name='oneprice' placeholder="원" />
			<button>개발</button>

			<div><input type="hidden" value="${reginum}" name="reginum">
					</div>


			<div>
				<input type="hidden" value="${parkarea}" name="parkarea">
			</div>

			<div>
				<input type="hidden" value="${roomscnt}" name="roomscnt">
			</div>

			<div>
				<input type="hidden" value="${bathcnt}" name="bathcnt">
			</div>

			<div>
				<input type="hidden" value="${bedcnt}" name="bedcnt">
			</div>

			<div>
				<input type="hidden" value="${toiletcnt}" name="toiletcnt">
			</div>
			
			<div>
			
				<input type="hidden" value="${housetype}" name="housetype">
			</div>

			<div>
				<input type="hidden" value="${attendance}" name="attendance">
			</div>

			<div>
				<input type="hidden" value="${address}" name="address">
			</div>

			<div>
				<input type="hidden" value="${addressDetail}" name="addressDetail">
			</div>

			<div>
				<input type="hidden" value="${realFileName}" name="realFileName">
			</div>
			
			<div>
				<input type="hidden" value="${picscollect}" name="picscollect">
			</div>

			
					
			<button>완료</button>
		</form>

	</div>


</body>

<script>
	
</script>
</html>