<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<title>방 내놓기</title>

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
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3" style="margin-top:30px;">방 내놓기</h4>
        <form class="validation-form" method="post" enctype="multipart/form-data" id="allsubmit" novalidate>
          
            <div class="mb-3">
	 		  <input type="hidden" name="ps_service_type" value=1>
              <label for="name">주소</label>
              <input type="text" name="address" id="sample4_postcode" placeholder="우편번호" class="form-control" >
              <div class="invalid-feedback">
                주소를 입력해주세요.
              </div>
            </div>

            
          <div class="row">
			<div class="col-md-6 mb-3">
			 <label for="property_type_id">매물유형</label>
		     <select name="property_type_id" onchange="show_form(this.value)" class="form-select form-select-sm" aria-label=".form-select-sm example">
		  	 	<option value="1">매매</option>
		  	 	<option value="2">전세</option>
		  	 	<option value="3">월세</option>
			 </select>
		            </div>
						<div id="price" class="col-md-6 mb-3">
		                <label for="price">매매가</label>
		                <input type="number" class="form-control" name="price" placeholder="" required>
		                <div class="invalid-feedback">
		                  매매가를 입력해주세요.	
		                </div>
		  	</div>
          </div>

	<div class="row">
	  <div id="deposit" class="col-md-6 mb-3">
                <label for="deposit">보증금</label>
                <input type="number"  name="deposit" class="form-control" name="deposit" placeholder="" required>
                <div class="invalid-feedback">
                  보증금을 입력해주세요.	
                </div>
              </div>
	  <div id="month_price" class="col-md-6 mb-3">
                <label for="month_price">월세</label>
                <input type="number" name="month_price" class="form-control" name="month_price" placeholder="" required>
                <div class="invalid-feedback">
                  월세를 입력해주세요.	
                </div>
              </div>
	</div>


          <div class="mb-3">
            <label for="email">건물명</label>
            <input type="text" name="pname" class="form-control" id="pname" placeholder="" required>
            <div class="invalid-feedback">
              건물명을 입력해주세요.
            </div>
          </div>

	<div class="row">
	  <div class="col-md-6 mb-3">
            <label for="feet">평수</label>
            <input type="number"  name="feet"  class="form-control" name="feet" placeholder="" required>
            <div class="invalid-feedback">
            	평수를 입력해주세요.	
            </div>
        </div>
	  	<div class="col-md-6 mb-3">
        	<label for="floor">층</label>
            <input type="number" name="floor" class="form-control" name="floor" placeholder="" required>
            <div class="invalid-feedback">
            	층수를 입력해주세요.	
            </div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-6 mb-3">
            <label for="charge">관리비</label>
            <input type="number"  name="charge"  class="form-control" name="charge" placeholder="" required>
            <div class="invalid-feedback">
            	관리비를 입력해주세요.	
        	</div>
        </div>
		<div class="col-md-6 mb-3">
        	<label for="count">방 개수</label>
            <input type="number" name="count" class="form-control" name="count" placeholder="" required>
            <div class="invalid-feedback">
            	방 개수를 입력해주세요.	
            </div>
    	</div>
	</div>

	<div class="row">
	 	 <div class="col-md-6 mb-3">
         	<label for="move_date">입주 가능일</label>
            <input type="date"  name="move_date"  class="form-control" name="move_date" placeholder="" required>
            <div class="invalid-feedback">
            	입주가능일을 선택해주세요.	
            </div>
          </div>
	  	  <div class="col-md-6 mb-3">
          	<label for="telephone">연락처</label>
            <input type="text" name="telephone" class="form-control" name="telephone" placeholder="" required>
            <div class="invalid-feedback">
            	연락처를 입력해주세요.	
            </div>
          </div>
	</div>

	<div class="mb-3">
        <label for="address">상세 설명</label>
        <input type="text" name="description" class="form-control" id="description" placeholder="" required>
		<div class="invalid-feedback">
			주소를 입력해주세요.
		</div>
	</div>
        <div class="custom-file" style="margin-bottom:5px;">
            <input name="files" type="file" class="custom-file-input" id="customFile" multiple>
            <label class="custom-file-label" for="customFile"></label>
        </div>


          <input class="btn btn-primary" type="button" value="등록" id="submit_form">
        </form>
      </div>
    </div>
</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<script>
	 $(document).ready(function() {
	        // 초기 상태 설정을 위해 show_form 함수 호출
	        show_form("1");

	        $(document).on('click', '#submit_form', function(e) {
	       	 
	       	 e.preventDefault();
	       	 
	       	 Swal.fire({
	       		 
	       		   title: '해당 매물을 등록 하시겠습니까?',
	       		   icon: 'warning',
	       		   
	       		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
	       		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
	       		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
	       		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
	       		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	       		   	

	       		}).then(result => {
	       		   // 만약 Promise리턴을 받으면,
	       		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
	       		      $("#allsubmit").submit();
	       		   }
	       		   
	       		});

	       	});
	       	
	    });
	
		function show_form(select_btn){
		  if(select_btn == "1") {
		    $("#price").show();
		    $("#price input").prop('disabled', false); // 매매가 입력란 활성화

		    $("#deposit, #month_price").hide();
		    $("#deposit input, #month_price input").val('').prop('disabled', true); // 전세, 월세 입력란 비활성화 및 비우기
		  } else if(select_btn=="2") {
			  $("#price,#month_price").hide();
			  $("#price input, #month_price input").val('').prop('disabled', true); // 매매가 입력란 비활성화 및 비우기

			  $("#deposit").show();
			  $("#deposit input").prop('disabled', false); // 전세 입력란 활성화
		
			}else{
				$("#price").hide();
			    $("#price input").val('').prop('disabled', true); // 매매가 입력란 비활성화 및 비우기

			    $("#deposit, #month_price").show();
			    $("#deposit input, #month_price input").prop('disabled', false); // 전세, 월세 입력란 활성화
			}
		}
		
		
		
	</script>
	
</body>
</html>
