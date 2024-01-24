<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
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
            <li><a href="#" class="nav-link px-2">실거래가 비교</a></li>
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
		<h3 style="padding-top:30px; margin-bottom:20px;">최근 본 내역</h3>
		  <div id="view-container"></div>
		
		  <div id="pagination">
		    <ul id="page-numbers"></ul>
		  </div>
	</div>
</div>
  <script>
    // 로컬 스토리지에서 데이터를 가져오는 함수
    function getDataFromLocalStorage() {
      // 저장된 데이터 가져오기
      var savedDataString = localStorage.getItem('user:${id}');

      // 저장된 데이터가 없는 경우 빈 배열 반환
      if (!savedDataString) {
        return [];
      }

      // 문자열로 저장된 데이터를 객체로 변환하여 반환
      return JSON.parse(savedDataString);
    }

    // 로컬 스토리지에서 데이터 가져오기
    var savedData = getDataFromLocalStorage();

    // 한 페이지에 보여줄 아이템 개수
    var itemsPerPage = 3;
    // 현재 페이지 번호
    var currentPage = 1;

    // 페이지 번호에 따라 데이터를 나누고, 해당 페이지의 아이템만 보여주는 함수
    function showItemsByPage(page) {
      // 뷰 컨테이너 초기화
      var viewContainer = document.getElementById("view-container");
      viewContainer.innerHTML = "";

      // 페이지에 해당하는 아이템의 시작 인덱스와 끝 인덱스 계산
      var startIndex = (page - 1) * itemsPerPage;
      var endIndex = startIndex + itemsPerPage;

      // 계산된 인덱스 범위에 해당하는 아이템만 뷰에 추가
      for (var i = startIndex; i < endIndex && i < savedData.length; i++) {
        var data = savedData[i];
        var item = document.createElement("div");

        // 이미지 표시를 위한 <img> 태그 추가
        var imageLink = document.createElement("a");
        imageLink.href =
          "http://localhost:8081/property/psDetail?ps_service_type=" +
          data.property_type_id +
          "&propertyId=" +
          data.propertyId +
          "&address=" +
          data.address +
          "&pname=" +
          data.pname; // 페이지 URL에 질문 ID를 추가하여 동적으로 링크 생성
        var image = document.createElement("img");
        image.src = data.image;
        imageLink.appendChild(image);
        item.appendChild(imageLink);
        viewContainer.appendChild(item);

        var text = document.createElement("p");

        // 매물 이름에 링크 추가
        var nameLink = document.createElement("a");
        nameLink.href =
          "http://localhost:8081/property/psDetail?ps_service_type=" +
          data.property_type_id +
          "&propertyId=" +
          data.propertyId +
          "&address=" +
          data.address +
          "&pname=" +
          data.pname; // 페이지 URL에 질문 ID를 추가하여 동적으로 링크 생성
        nameLink.textContent =
          "매물 이름: " + data.pname + "\n" + "가격: " + data.price;
        text.appendChild(nameLink);

        item.appendChild(text);

        viewContainer.appendChild(item);
      }
    }

    // 초기 페이지 로딩 시 첫 페이지 아이템 보여주기
    showItemsByPage(currentPage);

    // 페이지 번호 목록 생성 함수
    function createPageNumbers() {
      var totalPages = Math.ceil(savedData.length / itemsPerPage);
      var pageNumbersList = document.getElementById("page-numbers");
      pageNumbersList.innerHTML = "";

      // 각 페이지 번호를 리스트 아이템으로 추가
      for (var i = 1; i <= totalPages; i++) {
        var pageNumberItem = document.createElement("li");
        pageNumberItem.textContent = i;
        pageNumberItem.addEventListener("click", function () {
          var pageNumber = parseInt(this.textContent);
          currentPage = pageNumber;
          showItemsByPage(currentPage);
          updatePageNumbers();
        });
        pageNumbersList.appendChild(pageNumberItem);
      }
    }

    // 페이지 번호 업데이트 함수
    function updatePageNumbers() {
      var pageNumbers = document.querySelectorAll("#page-numbers li");
      pageNumbers.forEach(function (pageNumber) {
        pageNumber.classList.remove("active");
        if (parseInt(pageNumber.textContent) === currentPage) {
          pageNumber.classList.add("active");
        }
      });
    }

    // 초기 페이지 로딩 시 페이지 번호 목록 생성
    createPageNumbers();

    // 초기 페이지 로딩 시 페이지 번호 스타일링
    updatePageNumbers();
  </script>
</body>

</html>