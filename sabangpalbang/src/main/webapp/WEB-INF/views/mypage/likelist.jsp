<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>찜목록</title>
</head>
<style>
	p {
		text-align:center;
		position:relative;
		top:15px;
	}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/navbar.css">
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
            <li><a href="#" class="nav-link px-2">1대1 상담</a></li>
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

  	<!-- 사이드바 -->
  	
	    <nav class="col-sm-3 sidenav">
	    <h4 style="margin-top:30px; text-align:center; margin-bottom:30px;">마이페이지</h4>
	    	  
		      <ul id="nav_side" class="nav nav-pills nav-stacked">
		        <li>아이디 = ${loginId}</li>
		        <li>Email = ${loginEmail}</li>
		        <li><a href="/check">회원정보 수정</a></li>
		        <li><a href="/delcheck">회원탈퇴</a></li>
		      </ul>
	    	
	    	  <hr class="hr-solid"/>
		      <ul id="nav_side2" class="nav nav-pills nav-stacked">
		        <li><a href="/mypage/likelist">찜목록</a></li>
		        <li><a href="/history">최근 본 내역</a></li>
		        <li><a href="/mypage/notify">알림</a></li>
		        <li><a href="/mypage/myupload">내가 올린 글</a></li>
		      </ul>
	    </nav>
    

 
	<div class="col-sm-9 page">
		<h3 style="padding-top:30px; margin-bottom:20px;">찜목록</h3>
		<div style="display:flex;">
		<c:if test="${listcheck!=0 }">
			<c:forEach items="${likelist}" var="like">
				<div class="card" style="width: 18rem; margin-right:50px; margin-bottom:50px;">
					<img src="/roomImg/${like.images.filename}" alt="" style="width:266px; height:200px;">
					<c:choose>
						<c:when test="${like.property_type_id==1}">
						<p>매매 </p>
						<p>${like.price}</p>
						<p>${like.pname}</p><br>
						</c:when>
						<c:when test="${like.property_type_id==2}">
						<p>전세 </p>
						<p>${like.deposit}</p>
						<p>${like.pname}</p><br>
						</c:when>
						<c:when test="${like.property_type_id==3}">
						<p>월세 </p>
						<p>${like.deposit} / ${like.month_price}</p>
						<p>${like.pname}</p><br>
						</c:when>
					</c:choose>
				
				</div>
			</c:forEach>
		</c:if>
		</div>
		<c:if test="${listcheck==0 }">
		찜목록이 없습니다.</c:if>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
      
     /*  $("#chagePrivate").click(function(){
    	  $("#updateform").submit();
    	  
      }); */

  </script>
</body>
</html>	