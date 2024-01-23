<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서비스 매물 상세정보</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">


<style>

	p {
		position:relative;
		left:60px;
		
	}
	.modal_wrap {
		display:none;
		width:500px;
		height:500px;
		position:absolute;
		top:50%;
		left:50%;
		margin:-250px 0 0 -250px;
		background:#eee;
		z-index:2;
	}
	
	.black_bg {
		display:none;
		content:"";
		width:100%;
		height:100%;
		position:absolute;
		top:0;
		left:0;
		background-color:rgba(0,0,0,0.5);
		z-index:1;
	}
	
	.modal_close {
		width:26px;
		height:26px;
		position:absolute;
		top:-30px;
		right:0;
	}
	
	.modal_close > a {
		display:block;
		width:100%;
		height:100%;
		background:url(https://img.icons8.com/metro/26/000000/close-window.png);
		text-indent:-9999px;
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
	<div class="col-sm-12 page">
		<div class="container" style="margin-top:20px;">
			<div>
				<c:forEach items="${psdetail.images}" var="image">
					<div style="text-align:center; display:inline-block; vertical-align:top;">
						<img src="/roomImg/${image.filename}" alt="" style="width:400px; height:480px;">
					</div>
				</c:forEach>
				<div style="display:inline-block;">
					<p>주소: ${psdetail.address}</p>
					<p>건물명: ${psdetail.pname}</p>
					<c:choose>
						<c:when test="${psdetail.property_type_id == 1}">
							<p>매매가 : ${psdetail.price}</p>
						</c:when>
						<c:when test="${psdetail.property_type_id == 2}">
							<p>보증금: ${psdetail.deposit}</p>
						</c:when>
						<c:when test="${psdetail.property_type_id == 3}">
							<p>보증금 : ${psdetail.deposit} / 월세 : ${psdetail.month_price}</p>
						</c:when>
					</c:choose>
					<p>평수: ${psdetail.feet}</p>
					<p>층수: ${psdetail.floor}</p>
					<p>관리비: ${psdetail.charge}</p>
					<p>방 개수: ${psdetail.count}</p>
					<p>
						등록 날짜:
						<fmt:formatDate value="${psdetail.registration_date}"
							pattern="yyyy-MM-dd" />
					</p>
					<p>설명: ${psdetail.description}</p>
			
					<button class="btn btn-primary" type="button" id="telephone" style="margin-left:60px; margin-top:80px;">연락처 보기</button>
				</div>
				
				<div class="black_bg"></div>
				<div class="modal_wrap">
					<div class="modal_close"><a href="#">close</a></div>
					<div>모달창 내용</div>
				</div>
			</div>
			
			<!-- 서비스매물 실거래가 그래프 -->
			<div>
				<canvas id="myChart" style="height: 40vh; width: 30vw; margin-top:50px;"></canvas>
			</div>
		</div>
		
	</div>
	
</div>



</body>

	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<!-- 로컬스토리지 저장  -->
	<script>
	 // 로컬 스토리지에 데이터를 저장하는 함수
	 function saveDataToLocalStorage(data) {
	   // 기존에 저장된 데이터 가져오기
	   var savedData = JSON.parse(localStorage.getItem('user:${id}'));
	
	   // 기존에 저장된 데이터가 없는 경우 새로운 배열 생성
	   if (!savedData) {
	     savedData = [];
	   }
	   
	   // 중복 값을 제거하고 새로운 값이 들어오면 최신 값으로 업데이트
	   var updatedData = savedData.filter(function(item) {
	     return item.propertyId !== data.propertyId;
	   });
	   updatedData.unshift(data);
	
	// 배열을 문자열로 변환하여 로컬 스토리지에 저장
	   localStorage.setItem('user:${id}', JSON.stringify(updatedData));
	 }
 
 // 이미지 파일 경로 생성 함수
	 function getImageFilePaths() {
	   var imageFilePaths = [];
	   <c:forEach items="${psdetail.images}" var="image">
	     var imagePath = "/roomImg/" + "${image.filename}";
	     imageFilePaths.push(imagePath);
	   </c:forEach>
	   return imageFilePaths;
	 }
	
	</script>

	<script>
	  // content.question_id와 content.title을 로컬 스토리지에 저장
	  var dataToSave = {
	    propertyId: ${propertyId},
	    price: ${psdetail.price},
	    pname: "${psdetail.pname}",
	    property_type_id: ${psdetail.property_type_id},
	    address: "${psdetail.address}",
	    image: getImageFilePaths()
	  };
	  saveDataToLocalStorage(dataToSave);
	</script>


	
	<script>
	
	function getParameterByName(name) {
		const urlSearchParams = new URLSearchParams(window.location.search);
		return urlSearchParams.get(name);
	}
	var address = getParameterByName('address');
	var pname = getParameterByName('pname');
	console.log('address:' +address);
	console.log('pname:' + pname);

    fetch('/getTransGraph?address=' + address + '&pname=' + pname)
        .then(response => response.json())
        .then(chartData => {
           /*  console.log('chartData:', chartData); */

            var ctx = document.getElementById('myChart').getContext('2d');

            var myChart = new Chart(ctx, {
                type : 'line',
                data : {
                    labels : chartData.map(function(item) {
	                    return item.deal_year;
	                }),
                    datasets : [ {
                        label : '실거래가 변동 그래프( 단위 : 만 원)',
                        data : chartData.map(function(item) {
    	                    return item.deal_amount;
    	                }),
                        backgroundColor : 'rgb(32, 164, 132)',
                        borderWidth : 1
                    } ]
                },
                options : {
                    responsive : false,
                    maintainAspectRatio : false,
                    scales : {
                        y : {
                            beginAtZero : true
                        }
                    }
                }
            });
        })
        .catch(error => console.error('Error fetching chart data:', error));
</script>

<script>
	window.onload = function() {     
		function onClick() {        
			document.querySelector('.modal_wrap').style.display ='block';
			document.querySelector('.black_bg').style.display ='block';
		}      
		
		function offClick() {        
			document.querySelector('.modal_wrap').style.display ='none';
			document.querySelector('.black_bg').style.display ='none';
		}
		     
		document.querySelector('#telephone').addEventListener('click', onClick);
		document.querySelector('.modal_close').addEventListener('click', offClick); 
	};    
</script>

</html>
