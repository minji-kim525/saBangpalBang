<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
</head>
<body>
<div class="header">
        <header
          class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom" 
          style="margin-bottom:0!important;"
        >
          <div class="col-md-3 mb-2 mb-md-0">
	          <a
	              href="/"
	            >
	          <img src="/icon/logo.png" style="width:100px; height:60px; margin-left:50px;">
			  </a>
          </div>

          <ul id="navbar"
            class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0"
          >
            <li><a href="/map" class="nav-link px-2">지도</a></li>
            <li><a href="/transaction" class="nav-link px-2">실거래가 비교</a></li>
            <li><a href="/mypage/upload" class="nav-link px-2">방 내놓기</a></li>
            <li><a href="/question/title" class="nav-link px-2">문의게시판</a></li>
          </ul>

          <div class="col-md-3 text-end">
            <sec:authorize access="hasAuthority('USER')"> 
				<button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/mypage/likelist'">마이페이지</button>
				<form action="/logout" method="post" style="float:right">
				<button type="submit" class="btn btn-primary" style="margin-right:50px;">로그아웃</button>
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    		</form>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
			  <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/manager/property/search'">관리자 페이지</button>
			  <form action="/logout" method="post" style="float:right">
			  <button type="submit" class="btn btn-primary" style="margin-right:50px;">로그아웃</button>
			  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    	  </form>
			</sec:authorize>
          </div>
	</header>
</div>

<div class="container-fluid" style="padding-left:0!important;">
	<div class="container" style="margin-top:50px;">
	<h3 style="text-align:center; margin-bottom:30px;"><strong>답변 수정</strong></h3>
	<div class="card mb-4">
		<div class="card-body">   
			<c:if test="${content.title == null}">
				<%
				response.sendRedirect("title");
				%>
			</c:if>
			<div class="row">
				<div class="col-md-6 mb-3">
				글번호:${content.question_id}
				</div>
				<div class="col-md-6 mb-3">
				등록날짜:
				<fmt:formatDate value="${content.created_at}"
					pattern="yyyy-MM-dd HH:mm:ss" />
				</div>
			</div>
			<hr class="hr-solid"/>
			<div class="row">
				<div class="col-md-6 mb-3">
				질문유형:${content.question_type} 
				</div>
				<div class="col-md-6 mb-3">
				작성자:${content.id} 
				</div>
			</div>
			<hr class="hr-solid"/>
			<div class="mb-3">
				제목:${content.title}
			</div>
			<hr class="hr-solid"/>
			<div class="mb-3">
			내용:${content.content}
			</div>
		</div>
	</div>
	</div>
</div>


<div class="container-fluid" style="padding-left:0!important;">
	<div class="container">
		
		<form id="updateform" action="update" method="post">
			<textarea class="form-control" name="content" rows="10">${answer }</textarea>
			<%-- <input type="text" value="${answer}" name="content"> --%>
			<form:errors path="content"></form:errors>
			<input type="hidden" value="${answer_id}" name="answer_id">
			<input type="hidden" value="${question_id}" name="question_id">
			<input class="btn btn-outline-primary" type="submit" value="답변하기" id="updatebtn" style="margin-top:5px;"/>
			<input class="btn btn-outline-danger"  type="button" value="취소" id="cancelbtn" style="margin-top:5px;">
		</form>
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	

<script>
$(document).on('click', '#updatebtn', function(e) {
	 
	 e.preventDefault();
	 
	 Swal.fire({
		 
		   title: '수정 하시겠습니까?',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '수정', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   	

		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   $("#updateform").submit();
		   }
		   
		});

	});
	
$(document).on('click', '#cancelbtn', function(e) {
	 
	 e.preventDefault();
	 
	 Swal.fire({
		 
		   title: '취소 하시겠습니까?',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   	

		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   window.history.back();
		   }
		   
		});

	});
</script>
</body>
</html>