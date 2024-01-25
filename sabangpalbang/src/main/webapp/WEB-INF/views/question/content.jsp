<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
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
            <li><a href="#" class="nav-link px-2">실거래가 비교</a></li>
            <li><a href="/mypage/upload" class="nav-link px-2">방 내놓기</a></li>
            <li><a href="/question/title" class="nav-link px-2">문의게시판</a></li>
            <li><a href="#" class="nav-link px-2">1:1 상담</a></li>
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
	<div class="col-sm-12 page">
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
		<form action="delete/${content.question_id}" method="post" >
			<input type="submit" value="삭제" class="btn btn-outline-danger" style="float:right;" 
				onclick="if(!confirm('정말로 삭제하시겠습니까?')){return false;}" />
		</form>
		<form action="update" method="post">
			<input type="hidden" value="${content.question_id}"
				name="question_id"> <input class="btn btn-outline-primary" type="submit" value="수정" style="float:right; margin-right:5px;"
				onclick="if(!confirm('수정하시겠습니까?')){return false;}" />
		</form>
	</c:if>
	</div>
</div>

<div class="container-fluid" style="padding-left:0!important; float:right; margin-top:30px;">
	<div class="col-sm-12 page">
	<h4 style="margin-left:15px;">답변</h4>
	<div class="card mb-4">
		<div class="card-body">

		<c:if test="${count != 0}">
			<c:forEach items="${alist}" var="alist">
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

				<c:if test="${role == 'ROLE_ADMIN'}">
					<form action="answer/updatepage" method="post" style="float:left; margin-right:10px;">
						<input type="hidden" value="${content.question_id}"
							name="question_id"> <input type="hidden"
							value="${alist.answer_id}" name="answer_id"> <input
							type="hidden" value="${alist.content}" name="content"> <input
							class="btn btn-outline-primary" type="submit" value="답변수정">
					</form>
					<form action="answerdelete" method="post">
						<input type="hidden" value="${alist.answer_id}" name="answer_id">
						<input type="hidden" value="${content.question_id}"
							name="question_id"> <input type="submit" class="btn btn-outline-danger" value="삭제"
							onclick="if(!confirm('정말로 삭제하시겠습니까?')){return false;}">
					</form>
				</c:if>
			</c:forEach>
		</c:if>
		</div>
	</div>
	<c:if test="${role == 'ROLE_ADMIN' and count == 0}">
		<form action="answer" method="post">
			<input type="hidden" value="${content.question_id}"
				name="question_id"> <input type="hidden"
				value="${content.title}" name="title"> <input type="hidden"
				value="${content.user_id}" name="user_id"> <input
				type="submit" value="답변하기" />

		</form>
	</c:if>
	</div>
</div>



</body>
</html>