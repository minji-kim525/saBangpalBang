<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html>
<head>
<title>문의작성</title>
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
	
	<form:form action="/question/insert" method="post" modelAttribute="dto">

		<div class="mb-3"">
		<select name="question" class="form-select form-select-sm" aria-label=".form-select-sm example" 
		style="margin-top:15vh; margin-left:50px; display:inline-block; width:10%; font-size:1rem; padding-top:0.375rem; padding-bottom:0.375rem;">
					<option value="" selected >문의사항</option>
					<option value="사기">사기</option>
					<option value="월세/전세/매매">월세/전세/매매</option>
					<option value="지역">지역</option>
					<option value="기타">기타</option>
		</select>
		 <input name="title" class="form-control" placeholder="제목" style="display:inline-block; width:80.1%; margin-left:10px;">
			<form:errors path="title"></form:errors>
		</div>
		<div class="mb-3" style="width:91%; margin-left:50px;">
			내용 <textarea name="content" class="form-control" rows="10"></textarea>
			<form:errors path="content"></form:errors>
		</div>
		<input type="submit" value="등록" class="btn btn-outline-primary" style="margin-left:50px;">
		<input type="button" value="취소" class="btn btn-outline-danger" onclick="cancelUpdate()">
	</form:form>
	</div>
</div>	
	
	
	
	<script>
		function cancelUpdate() {
			if (confirm('취소하시겠습니까?')) {
				window.history.back();
			}
		}
	</script>	
	
	
	
	<script>
  const selectElement = document.querySelector('select[name="question"]');
  const submitButton = document.querySelector('input[type="submit"]');
  
  submitButton.addEventListener('click', function(event) {
    if (selectElement.value === '') {
      event.preventDefault(); // 기본 동작인 폼 제출을 막습니다.
      alert('문의사항을 선택해주세요.');
    }
  });
</script>
	

</body>
</html>