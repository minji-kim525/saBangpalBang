<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>찜목록</title>
</head>
<body>
<h3>찜목록</h3>
<c:if test="${listcheck!=0 }">
	<c:forEach items="${likelist}" var="like">
		<span class ="card">
			<img src="/roomImg/${like.images.filename}" alt="">
			<c:choose>
				<c:when test="${like.property_type_id==1}">
				<p>매매 </p>
				</c:when>
				<c:when test="${like.property_type_id==2}">
				<p>전세 </p>
				</c:when>
				<c:when test="${like.property_type_id==2}">
				<p>월세 </p>
				</c:when>
			</c:choose>
			<p>${like.price}</p>
			<p>${like.pname}</p><br>
			<%-- <form method="post" id="updateform" action="/mypage/myupload/1">
			<input type="hidden" name="_method" value="put">
			<input type="hidden" name="property_service_id" value="${property.property_service_id}">
			<input type="hidden"  value="${property.private_property}">
			
				<c:choose>
 					<c:when test="${property.private_property==false}">
 					<button id="chagePrivate" >비공개 전환</button>
					</c:when>
					<c:when test="${property.private_property==true}">
				 	<button id="chagePrivate" >비공개 취소</button>
					</c:when>
				</c:choose>
			</form> --%>
		
		</span>
	</c:forEach>
</c:if>
<c:if test="${listcheck==0 }">
찜목록이 없습니다.</c:if>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
      
     /*  $("#chagePrivate").click(function(){
    	  $("#updateform").submit();
    	  
      }); */

  </script>
</body>
</html>	