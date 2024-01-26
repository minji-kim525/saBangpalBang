<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modify Information</title>
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
    <form action="/update" method="post">
    	<div class="mb-3">
        	<label for="name">아이디</label>
            <input type="text" class="form-control" name="id" value="${user.id}"  readonly/>
        </div>
       	<div class="mb-3">
			<label for="email">이메일</label>
            <input type="text" class="form-control" name="email" value="${user.email}"/>
        </div>
        <div class="mb-3">
            <label for="password">새 비밀번호</label>
            <input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="새 비밀번호"/>
        </div>
        <div class="mb-3">
            <label for="cfpassword">비밀번호 확인</label>
            <input type="password" class="form-control" id="cfpassword" name="cfpassword" placeholder="비밀번호 확인" onKeyUp="fn_compare_pwd();"/>
	        <p id="result" style="font-size: 16px; margin-top:10px;"></p>
	    </div>
       
        
        <button class="btn btn-primary" type="submit">저장하기</button>
    </form>
    </div>
</div>
</body>

<script type="text/javascript">
var compare_result = false;
	function fn_compare_pwd(){
		var pwd1 = document.getElementById('newpassword');
		var pwd2 = document.getElementById('cfpassword');	
		var result = document.getElementById('result');	
	             
		if(pwd1.value == pwd2.value){
			compare_result = true;
			result.innerHTML = "비밀번호 일치";
			result.style.color = "green";
			return;
		}	
	    else{       
			compare_result = false;
	 		result.innerHTML = "비밀번호가 일치하지 않습니다";
	 		result.style.color = "red";
	 	}
	}

</script>
</html>