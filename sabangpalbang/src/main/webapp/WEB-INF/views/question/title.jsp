<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<title>Insert title here</title>
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
            <li><a href="#" class="nav-link px-2">문의게시판</a></li>
            <li><a href="#" class="nav-link px-2">1:1 상담</a></li>
          </ul>

          <div class="col-md-3 text-end">
            <sec:authorize access="hasAuthority('USER')"> 
				<button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/mypage/likelist'">마이페이지</button>
				<form action="/logout" method="post" style="float:right">
				<button type="submit" class="btn btn-primary">로그아웃</button>
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    		</form>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
			  <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/manager/property/search'">관리자 페이지</button>
			  <form action="/logout" method="post" style="float:right">
			  <button type="submit" class="btn btn-primary">로그아웃</button>
			  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    	  </form>
			</sec:authorize>
          </div>
	</header>
</div>
      
<div class="container-fluid" style="padding-left:0!important;">
	<div class="col-sm-12 page">   
	<h3 style="padding-top:30px; margin-bottom:20px;">찜목록</h3>
	<table class="table">
		<thead>
			<tr>
				<th class="col" scope="col">글 번호</th>
			    <th class="col" scope="col">작성자</th>
			    <th class="col" scope="col">제목</th>
			    <th class="col" scope="col">등록날짜</th>
			
			</tr>
		</thead>
		<tbody id="list">
			<c:forEach items="${tlist}" var="title">
			<tr>
				<td class="col" scope="col">${title.question_id}</td>
				<td class="col" scope="col">${title.id}</td>
				<td class="col" scope="col"><a href="${title.question_id}">${title.title}</a></td>
				<td class="col" scope="col"><fmt:formatDate value="${title.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				
				<c:if test="${title.answer_id != 0}">(답변완료)</c:if><br>
				
				
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="search_box">
		
		<a href="http://localhost:8081/question/insert">글쓰기</a>
		<form action="search" method="get">
			<div class="container-fluid" style="--bs-gutter-x:0;">
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" id="mySelect" onchange="updateInputName()"
				style="width:110px; display:inline-block; padding-top:0.375rem; padding-bottom:0.375rem; font-size:1rem;">
				  <option value="title" selected>제목</option>
				  <option value="id" >작성자</option>
				</select>
				<input class="form-control me-2" type="text" id="myInput" style="display:inline; width:300px;">
				<input class="btn btn-outline-success" type="submit" value="검색" style="vertical-align:baseline;">
				</form>
				<button type="button" class="btn btn-outline-secondary" style="vertical-align:baseline; float:right"><a href="http://localhost:8081/question/insert" style="text-decoration-line:none;">글쓰기</a></button>
			</div>
	</div>
	</div>
</div>
<script>
  function updateInputName() {
    var selectElement = document.getElementById("mySelect");
    var inputElement = document.getElementById("myInput");
    var selectedValue = selectElement.value;
    inputElement.name = selectedValue;
  }
</script>


</body>
</html>