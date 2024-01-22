<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>사용자 관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/navbar.css">
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
            <li><a href="#" class="nav-link px-2">1대1 상담</a></li>
          </ul>

          <div class="col-md-3 text-end">
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

  	<!-- 사이드바 -->
    <nav class="col-sm-3 sidenav">
    <h4 style="margin-top:30px; text-align:center; margin-bottom:30px;">관리자</h4>
	      <ul id="nav_side" class="nav nav-pills nav-stacked">
	        <li>아이디 = ${loginId}</li>
	        <li>Email = ${loginEmail}</li>
	      </ul>
    	
    	  <hr class="hr-solid"/>
	      <ul id="nav_side2" class="nav nav-pills nav-stacked">
	        <li><a href="/manager/property/search">매물 관리</a></li>
	        <li><a href="/manager/confirm/search">승인 요청</a></li>
	        <li><a href="/manager/users/search">사용자 관리</a></li>
	        <li><a href="#">문의</a></li>
	        <li><a href="#">1대1 상담</a></li>
	      </ul>
    </nav>
    
<div class="col-sm-9 page">
	<h3 style="padding-top:30px; margin-bottom:20px;">사용자 관리</h3>
	<c:if test="${listcheck!=0 }">
	            <section>
	                <!--/* 검색 */-->
	                <div class="search_box">
	                    <form action="search" method="get" id="searchForm">
	                        <div class="container-fluid" style="--bs-gutter-x:0;">
	                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="searchType"
		                            style="width:110px; display:inline-block; padding-top:0.375rem; padding-bottom:0.375rem; font-size:1rem;">
	                                <option value="" ${searchDto.searchType == "" ? 'selected' : ''}>전체 검색</option>
	                                <option value="id" ${searchDto.searchType == "id" ? 'selected' : ''}>아이디</option>
	                                <option value="email" ${searchDto.searchType == "email" ? 'selected' : ''}>이메일</option>
	                            </select>
	                            <input class="form-control me-2" type="text" id="keywordForm" name="keyword" placeholder="키워드를 입력해 주세요." title="키워드 입력"
	                              aria-label="Search" value="${searchDto.keyword}" style="display:inline; width:300px;"/>
	                            <button class="btn btn-outline-success" type="button" id="search_submit" style="vertical-align:baseline;"><span class="skip_info">검색</span></button>
	                        </div>
	                    </form>
	                </div>
	
	                <!--/* 리스트 */-->
	                <table class="table">
	                   <%--  <colgroup style="border: 1px solid black;">
	                        <col style="width:50px;"/><col style="width:7.5%;"/><col style="width:auto;"/><col style="width:10%;"/><col style="width:15%;"/><col style="width:7.5%;"/>
	                    </colgroup> --%>
	                    <thead>
	                        <tr>
	<!--                             <th scope="col"><input type="checkbox"/></th>
	 -->                        <th class="col" scope="col" style="padding-left:0!important;">번호</th>
	                            <th class="col" scope="col">아이디</th>
	                            <th class="col" scope="col">이메일</th>
	                        </tr>
	                                     
	  					</thead>
	  					<tbody id="list">
	                        <c:forEach items="${list}" var="users" varStatus="i">
							<tr>
								<td class="col" scope="col" style="padding-left:0!important;"><a href ="">${pagination.totalRecordCount - ((searchDto.page - 1) * searchDto.recordSize)-i.index}</a></td>
								<td class="col"  scope="col">${users.id}</td>
								<td class="col" scope="col">${users.email}</td>
								<td class="col" scope="col">
									<form method="post" id="deleteform" action="/manager/users/search">
										<input "form-control me-2" type="hidden" name="_method" value="delete">
										<button class="btn btn-outline-danger" id="deleteId" name="user_id" value="${users.user_id}" >삭제</button>
									
									</form>
								
								</td>
							</tr>
							</c:forEach>
						 </tbody>
	                </table>
	 
				 </section>
	     <!--/* 페이지네이션 렌더링 영역 */-->
	    <div class="paging">
		<jsp:include page="../paging.jsp" flush="true">
		<jsp:param value="${searchDto.searchType}" name="searchType"/>
		<jsp:param value="${searchDto.keyword}" name="searchType"/>
		<jsp:param value="${searchDto.page}" name="page"/>
		<jsp:param value="${pagination.startPage}" name="startPage"/>
		<jsp:param value="${pagination.endPage}" name="endPage"/>
		<jsp:param value="${pagination.existPrevPage}" name="existPrevPage"/>
		<jsp:param value="${pagination.existNextPage}" name="existNextPage"/>
		</jsp:include>
		</div>
	</c:if>
	<c:if test="${listcheck==0 }">
	등록된 사용자가 없습니다.
	</c:if>	


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>


	
	$("#search_submit").click(function(){
	  	  $("#searchForm").submit();
	});
      
      $("#deleteform").click(function(){
    	  if (confirm("정말 삭제하시겠습니까?") == true){    //확인
        	  $("#deleteform").submit();
    		 }else{   //취소
    		     return false;
    		 }
    	  
      });
  



  </script>

</body>
</html>
