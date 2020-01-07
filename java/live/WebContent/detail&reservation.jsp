<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
#pic {
   border: blue solid 1px;
}

#middle {
   width: 100%;
   height: 100%;
   overflow: hidden;
   border: none;
}

#list {
   border: 2px solid #0B3861;
   float: left;
   width: 48%;
}

#map {
   border: 2px solid #0B3861;
   float: right;
   width: 51%;
}

#whogi {
   border: 2px solid #0B3861;
   float: left;
   width: 100%;
   height: 400px;
}

#reply {
   border: 2px solid #0B3861;
   float: left;
   width: 48%;
}

#rreply {
   border: 2px solid #0B3861;
   float: right;
   width: 48%;
}

#you {
   border: 2px solid #0B3861;
   float: left;
   width: 100%;
}

#후기{
   border: 2px solid #0B3861;
   float: left;
   width: 48%;
   height: 400px;
}

#id{
   border: 2px solid #0B3861;
   float: left;
   width: 48%;
   height: 400px;
   
}
#alert{
 border: 2px solid #0B3861
}

</style>

</head>
<body>

   <form action="detailGS" method="get">
      
      
      <div id="pic">숙소사진 출력창</div>
      
      
      
      <div id="middle">
         <div id="list">
            <h1>검색정보 불러와서 뿌려줌</h1>
         </div>


         <div id="map">
            <h1>날짜선택 예약 창</h1>
         </div>

      </div>
      
      
      
      <div id="whogi">
         
         <div id="후기">
            <h1>후기창</h1>
         </div>


         <div id="id">
            <ul>
               <li>화장실이 몇개입니까</li>
                 <ul>
                 <li>충분</li>
                 </ul>
           </ul>
         </div>
        
      </div>
      
   </form>
  <div id="alert">주의사항 </div>



</body>
</html>