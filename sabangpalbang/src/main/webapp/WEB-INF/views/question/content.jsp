<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<!DOCTYPE html>
<html>
<head>
<title>문의</title>
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
          	<sec:authorize access="!isAuthenticated()"> 
	            <button type="button" class="btn btn-outline-primary me-2" onclick = "location.href = '/login'" >
	              로그인
	            </button>	        
            	<button type="button" class="btn btn-primary" onclick = "location.href = '/insert'" style="margin-right:50px;">회원가입</button>
            </sec:authorize>
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
	<h4 style="margin-left:15px;">문의</h4>
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
	
	<c:if test="${content.id == id || role == 'ROLE_ADMIN'}">
		<form action="delete/${content.question_id}" method="post" id="deleteform" >
			<input type="submit" value="삭제" id="deletebtn" class="btn btn-outline-danger" style="float:right;" 
				 />
		</form>
		<form action="update" id="updateform" method="post">
			<input type="hidden" value="${content.question_id}"
				name="question_id"> <input id="updatebtn"class="btn btn-outline-primary" type="submit" value="수정" style="float:right; margin-right:5px;"
				 />
		</form>
	</c:if>
	</div>
</div>

<div class="container-fluid" style="padding-left:0!important; float:right; margin-top:30px;">
	<div class="container">
	<h4 style="margin-left:15px;">답변</h4>
	<c:forEach items="${alist}" var="alist">
	<div class="card mb-4">
		<div class="card-body">

		<c:if test="${count != 0}">
			
			<div class="row">
				<div class="col-md-6 mb-3">
				등록날짜 : <fmt:formatDate value="${alist.created_at}"
							pattern="yyyy-MM-dd HH:mm:ss" />
				</div>
			</div>
			<hr class="hr-solid"/>
			<div class="mb-3">
				답변 : ${alist.content}
			</div>

				
			
		</c:if>
		</div>
		
	</div>
	
	<c:if test="${role == 'ROLE_ADMIN'}">
					<form action="answerdelete" id="deleteasform" method="post">
						<input type="hidden" value="${alist.answer_id}" name="answer_id">
						<input type="hidden" value="${content.question_id}"
							name="question_id"> <input type="submit" id="deleteanswer"class="btn btn-outline-danger" value="삭제" style="float:right;"
							>
					</form>
					<form action="answer/updatepage" id="updateasform" method="post">
						<input type="hidden" value="${content.question_id}"
							name="question_id"> <input type="hidden"
							value="${alist.answer_id}" name="answer_id"> <input
							type="hidden" value="${alist.content}" name="content"> <input
							class="btn btn-outline-primary" id="updateanswer" type="submit" value="답변수정" style="float:right; margin-right:5px;">
					</form>
					
				</c:if>
	</c:forEach>
	<c:if test="${role == 'ROLE_ADMIN' and count == 0}">
		<form action="answer" method="post">
			<input type="hidden" value="${content.question_id}"
				name="question_id"> <input type="hidden"
				value="${content.title}" name="title"> <input type="hidden"
				value="${content.user_id}" name="user_id"> <input
				class="btn btn-outline-primary" type="submit" value="답변하기" />

		</form>
	</c:if>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<script>
$(document).on('click', '#deleteanswer', function(e) {
	 
	 e.preventDefault();
	 
	 Swal.fire({
		 
		   title: '답변을 삭제 하시겠습니까?',
		   text: '삭제한 답변은 볼 수 없습니다.',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   	

		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		      $("#deleteasform").submit();
		   }
		   
		});

	});
	
$(document).on('click', '#deletebtn', function(e) {
	 
	 e.preventDefault();
	 
	 Swal.fire({
		 
		   title: '문의를 삭제 하시겠습니까?',
		   text: '삭제한 문의와 답변은 볼 수 없습니다.',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   	

		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		      $("#deleteform").submit();
		   }
		   
		});

	});
	
$(document).on('click', '#updatebtn', function(e) {
	 
	 e.preventDefault();
	 
	 Swal.fire({
		 
		   title: '해당 게시물을 수정 하시겠습니까?',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   	

		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		      $("#updateform").submit();
		   }
		   
		});

	});
	
$(document).on('click', '#updateanswer', function(e) {
	 
	 e.preventDefault();
	 
	 Swal.fire({
		 
		   title: '해당 답변을 수정 하시겠습니까?',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   	

		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		      $("#updateasform").submit();
		   }
		   
		});

	});
</script>


</body>
</html>