<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>내가 올린 글 조회</title>
</head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<body>
<div class="header">
        <header
          class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom" 
          style="margin-bottom:0!important; padding-bottom:0!important;"
        >
          <div class="col-md-3 mb-2 mb-md-0">
	          <a
	              href="/"
	            >
	          <img src="/icon/logo.png" style="width:100px; height:60px">
			  </a>
          </div>

          <ul
            class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0"
          >
            <li><a href="/map" class="nav-link px-2">지도</a></li>
            <li><a href="#" class="nav-link px-2">실거래가 비교</a></li>
            <li><a href="/mypage/upload" class="nav-link px-2">방 내놓기</a></li>
            <li><a href="#" class="nav-link px-2">문의게시판</a></li>
          </ul>

          <div class="col-md-3 text-end">
            <sec:authorize access="isAuthenticated()"> 
				<button type="button" class="btn btn-outline-primary me-2" onclick="location.href='user'">회원정보</button>
				
				<form action="/logout" method="post" style="float:right">
				<button type="submit" class="btn btn-primary">로그아웃</button>
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    		</form>
	    		
			</sec:authorize>
          </div>
        </header>
      </div>

<h3>내가 올린 방</h3>
<c:if test="${listcheck!=0 }">
	<c:forEach items="${list}" var="property">
		<span class ="card">
			<img src="/roomImg/${property.images.filename}" alt="">
			<c:choose>
				<c:when test="${property.property_type_id==1}">
				<p>매매 </p>
				<p>${property.price}</p>
				<p>${property.pname}</p><br>
				</c:when>
				<c:when test="${property.property_type_id==2}">
				<p>전세 </p>
				<p>${property.deposit}</p>
				<p>${property.pname}</p><br>
				</c:when>
				<c:when test="${property.property_type_id==3}">
				<p>월세 </p>
				<p>${property.deposit}</p>/
				<p>${property.month_price}</p>
				<p>${property.pname}</p><br>
				</c:when>
			</c:choose>
			<form method="post" id="updateform" action="/mypage/myupload">
			<input type="hidden" name="_method" value="put">
			<input type="hidden" name="property_service_id" value="${property.property_service_id}">
			<input type="hidden"  value="${property.private_property}">
			
				<c:choose>
 				<c:when test="${property.private_property==false}">
 					<button id="changePrivate" >비공개 전환</button>
				</c:when>
				<c:when test="${property.private_property==true}">
				 	<button id="notPrivate" >비공개 취소</button>
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
	$(document).ready(function() {
		 $(document).on('click', '#changePrivate', function() {
			if (confirm("해당 게시물을 비공개 하시겠습니까?") == true) { //확인
				$("#updateform").submit();
			} else { //취소
				return false;
			}

			});
	$(document).on('click', '#notPrivate', function() {
			if (confirm("해당 게시물을 공개 하시겠습니까?") == true) { //확인
				$("#updateform").submit();
			} else { //취소
				return false;
			}

		});
	});
	</script>

</body>
</html>
