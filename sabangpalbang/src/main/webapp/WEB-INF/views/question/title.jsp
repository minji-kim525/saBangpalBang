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
	<div class="container">   
	<h3 style="padding-top:30px; margin-bottom:30px; text-align:center;">문의게시판</h3>
	<table class="table">
		<thead>
			<tr>
				<th class="col" scope="col">글 번호</th>
				<th class="col" scope="col">문의사항</th>
			    <th class="col" scope="col">작성자</th>
			    <th class="col" scope="col">제목</th>
			    <th class="col" scope="col">등록날짜</th>
			
			</tr>
		</thead>
		<tbody id="list">
			<c:forEach items="${list}" var="title" varStatus="i">
			<tr>
				<td class="col" scope="col">${pagination.totalRecordCount - ((searchDto.page - 1) * searchDto.recordSize)-i.index}</td>
				<td class="col" scope="col">${title.question_type}</td>
				<td class="col" scope="col">${title.id}</td>
				<td class="col" scope="col"><a href="${title.question_id}">${title.title}</a> <c:if test="${title.answer_id != 0}">(답변완료)</c:if> </td>
				<td class="col" scope="col"><fmt:formatDate value="${title.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				
				
				
				
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="search_box">
	
		<form action="title" method="get" id="searchForm">
			<div class="container-fluid" style="--bs-gutter-x:0;">
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="searchType" id="mySelect" 
				style="width:110px; display:inline-block; padding-top:0.375rem; padding-bottom:0.375rem; font-size:1rem; margin-left:10px;">
					<option value="" ${searchDto.searchType == "" ? 'selected' : ''}>전체검색</option>
				  <option value="writer"
						${searchDto.searchType == "writer" ? 'selected' : ''}>작성자</option>
				  <option value="name"
						${searchDto.searchType == "name" ? 'selected' : ''}>제목</option>
				</select>
				<input class="form-control me-2" type="text" id="keywordForm" name="keyword"
					placeholder="키워드를 입력해 주세요." title="키워드 입력"
					value="${searchDto.keyword}" style="display:inline; width:300px;"/>
				<button class="btn btn-outline-success" type="button" id="search_submit" style="vertical-align:baseline;"><span class="skip_info">검색</span></button>
				</form>
				<button type="button" class="btn btn-outline-secondary" style="color:blue; vertical-align:baseline; float:right" onClick="location.href='http://localhost:8081/question/insert'">글쓰기</button>
			</div>
	</div>
	</div>
</div>

	<jsp:include page="../paging.jsp" flush="true">
		<jsp:param value="${searchDto.searchType}" name="searchType" />
		<jsp:param value="${searchDto.keyword}" name="searchType" />
		<jsp:param value="${searchDto.page}" name="page" />
		<jsp:param value="${pagination.startPage}" name="startPage" />
		<jsp:param value="${pagination.endPage}" name="endPage" />
		<jsp:param value="${pagination.existPrevPage}" name="existPrevPage" />
		<jsp:param value="${pagination.existNextPage}" name="existNextPage" />
	</jsp:include>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$("#search_submit").click(function() {
			$("#searchForm").submit();
		});
	</script>


</body>
</html>