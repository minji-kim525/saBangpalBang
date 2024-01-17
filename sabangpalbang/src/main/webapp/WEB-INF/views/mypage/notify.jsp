<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">

<title>알림</title>
<style>
	* {
	 font-family:'S-CoreDream-3Light';
	}
	
	@font-face {
     font-family: 'S-CoreDream-3Light';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}



	.card {
	 	cursor: pointer;
	  position: relative;
	  border-bottom: 1px solid #ccc;
	  padding: 10px;
	  margin-bottom: 10px; 
	}
	.card:hover {
	  background-color: #f5f5f5;
	  border-color: #333; 
	}
	.unread-indicator {
	  width: 10px;
	  height: 10px;
	  border-radius: 50%;
	  background-color: red;
	  position: absolute; /* 상대 위치 지정 */
	  top: 10px;
	  right: 10px;
	}
    .sidenav {
      background-color: #f1f1f1;
      position: fixed;
      width: 200px;
      height: 100%;
    }
    /* 본문 */
    .page {
     margin-left: 250px;
    }

	#nav_side {
		display:block;
	}

	#nav_side > li {
		text-align: center;
		margin-bottom:20px;
		text-decoration-line:none;
	}
	
	#nav_side > li > a {
		text-decoration-line:none;
	}
	
	#nav_side2 {
		display:block;
	}

	#nav_side2 > li {
		font-size:20px;
		text-align: center;
		margin-bottom:20px;
		text-decoration-line:none;
	}
	
	#nav_side2 > li > a {
		text-decoration-line:none;
	}
  
  	.hr-solid {
  		border : 0px;
  		border-top: 3px solid #000000;
  	}
  
}
</style>
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
				<button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/user'">회원정보</button>
				
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
	        <li><a href="#">최근 본 내역</a></li>
	        <li><a href="/mypage/notify">알림</a></li>
	        <li><a href="#">내가 올린 글</a></li>
	      </ul>
    </nav>

 
	<div class="col-sm-9 page">
		<h3 style="padding-top:30px; margin-bottom:20px;">알림</h3>
		 <c:if test="${listcheck!=0 }">
			<c:forEach items="${list}" var="notify">
			<div class="card" style ="margin-bottom:20px;" onclick="markAsRead(this, '${notify.notify_id}', '${notify.notify_check}'); if (${notify.question_id != null}) { location.href='/question/${notify.question_id}'; } else { location.href='/property/psDetail?ps_service_type=${notify.ps_service_type}&propertyId=${notify.property_service_id}'; }">
			<input type="hidden" name="notify_id" value="${notify.notify_id}">
			<c:choose>
		 				<c:when test="${notify.question_id!=null}">
		 					<div id="notify_btn" >
		 					<c:if test="${notify.notify_check==0}">
		            			<div class="unread-indicator"></div>
		        			</c:if>
		 					<h4>관리자</h4>
		 					<p>${notify.title}에 대한 답변이 완료되었습니다.</p>
		 					</div>
						</c:when>
						<c:when test="${notify.confirm_id!=null&&notify.confirm_check==1}">
						 	<div id="notify_btn" >
		 					<c:if test="${notify.notify_check==0}">
		            			<div class="unread-indicator"></div>
		        			</c:if>
		 					<h4>관리자</h4>
		 					<p>${notify.pname}이 승인되었습니다.</p>
		 					</div>
						</c:when>
						<c:when test="${notify.confirm_id!=null&&notify.confirm_check==2}">
						 	<div id="notify_btn" >
		 					<c:if test="${notify.notify_check==0}">
		            			<div class="unread-indicator"></div>
		        			</c:if>
		 					<h4>관리자</h4>
		 					<p>${notify.pname}이 반려되었습니다.</p>
		 					</div>
						</c:when>
				</c:choose>
				
				
			</div>
			</c:forEach>
		</c:if>
		<c:if test="${listcheck==0 }">
		알림이 없습니다.</c:if>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function markAsRead(element,notify_id,notify_check) {
    	// 빨간 동그라미 제거
        var indicator = element.querySelector('.unread-indicator');
        if (indicator) {
            indicator.style.display = 'none';
        }
        if(notify_check==0){
        // AJAX 요청 알림 읽음 상태 업데이트
       fetch('/mypage/notify?notify_id=' +notify_id,{
    	   method: 'PUT',
    	    headers: {
    	        'Content-Type': 'application/json'
    	    }
      	 }
        )
        .then(response => response.text())
        .then(data => console.log(data))
        .catch(error => console.error('Error:', error));
       }
    }
    
</script>

</body>
</html>	