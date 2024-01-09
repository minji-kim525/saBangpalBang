<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>내가 올린 글 조회</title>
</head>
<body>
<h3>내가 올린 방</h3>
<c:if test="${listcheck!=0 }">
	<c:forEach items="${list}" var="property">
		<span class ="card">
			<img src="/roomImg/${property.images.filename}" alt="">
			<c:choose>
				<c:when test="${property.property_type_id==1}">
				<p>매매 </p>
				</c:when>
				<c:when test="${property.property_type_id==2}">
				<p>전세 </p>
				</c:when>
				<c:when test="${property.property_type_id==2}">
				<p>월세 </p>
				</c:when>
			</c:choose>
			<p>${property.price}</p>
			<p>${property.pname}</p><br>
			<form method="post" id="updateform" action="/mypage/myupload">
			<input type="hidden" name="_method" value="put">
			<input type="hidden" name="property_service_id" value="${property.property_service_id}">
			<input type="hidden"  value="${property.private_property}">
			
				<c:choose>
 					<c:when test="${property.private_property==false}">
 					<button id="changePrivate" >비공개 전환</button>
					</c:when>
					<c:when test="${property.private_property==true}">
				 	<button id="changePrivate" >비공개 취소</button>
					</c:when>
				</c:choose>
			</form>
			</span>
		</c:forEach>
	</c:if>
	<c:if test="${listcheck==0 }">
업로드한 방이 없습니다.
</c:if>
	<h3>나의 문의</h3>

	<c:if test="${qlistcheck!=0 }">
		<c:forEach items="${qlist}" var="question">
		글번호:${question.question_id}
		작성자:${question.id}
		제목:<a href="${question.question_id}">${question.title}</a> 
		등록날짜:${question.created_at}<br>

		</c:forEach>
	</c:if>
	<c:if test="${qlistcheck==0 }">
	문의 내역이 없습니다.
	</c:if>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$("#changePrivate").click(function() {
				if (confirm("해당 게시물을 비공개 하시겠습니까?") == true) { //확인
					$("#chagePrivate").submit();
				} else { //취소
					return false;
				}

			});
		});
	</script>

</body>
</html>
