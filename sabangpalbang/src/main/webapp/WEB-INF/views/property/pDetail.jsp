<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>크롤링 매물 상세 정보</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<style>

	 
	
	
	.modal_wrap {
		display:none;
		width:500px;
		height:500px;
		position:fixed;
		top:50%;
		left:50%;
		margin:-250px 0 0 -250px;
		background:#eee;
		z-index:2;
	}
	
	.modal_wrap > p {
		text-align:center;
		margin-top:40px;
	}
	
	.black_bg {
		display:none;
		content:"";
		width:100%;
		height:100%;
		position:fixed;
		top:92.67px;
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
	
	.images {
		display:flex;
		width:100%;
		height:300px;
	}
	
	.images_part {
		margin-right:10px;
	}
	
	.images_part > img {
		width:250px;
		height:250px;
	}
	
	#map {
      width: 100%;
      height: 500px;
      z-index:0;
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
	<div class="black_bg"></div>
	<div class="col-sm-12 page">
		<div class="container" style="margin-top:20px;">
			<div>
				<div class="images">
					<c:forEach items="${pdetail.images}" var="image">
						<div class="images_part">
							<img src="${image.filepath}" alt="" >
						</div>
						
					</c:forEach>
					<c:forEach  var="i" begin="1" step="1" end="${5-fn:length(pdetail.images)}">
						<div class="images_part">
							<img src="" onerror="this.onerror=null; this.src='/icon/noimage.jpg';" >
						</div>
						
					</c:forEach>
				</div>
				
				<canvas id="myChart" style="height: 60vh; width: 30vw; display:inline-block"></canvas>
				
				<c:set var="billions" value="${pdetail.price / 10000}" />
				<c:set var="millions" value="${(pdetail.price % 10000)}" />
				<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
				<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
				
				<c:set var="billions_de" value="${pdetail.deposit / 10000}" />
				<c:set var="millions_de" value="${(pdetail.deposit % 10000)}" />
				<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
				<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
				
				<fmt:formatDate var="move_date" value="${pdetail.move_date}" pattern="yyyy-MM-dd" />
				
				<div class="pdetail" style="display:inline-block; margin-left:50px; width:42.5vw; max-height:60vh; overflow:scroll;">
					<p>매물 ID: ${pdetail.property_id}</p>
					<p>주소: ${pdetail.address}</p>
					<p>건물명: ${pdetail.pname}</p>
					<c:choose>
						<c:when test="${pdetail.property_type_id == 1}">
							<c:if test="${billions > 0 && millions != 0}">
							    <p>매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</p>
							</c:if>
							<c:if test="${billions > 0 && millions == 0}">
							    <p>매매가 : ${billionsFormatted}억</p>
							</c:if>
								
						</c:when>
						<c:when test="${pdetail.property_type_id == 2}">
							<c:if test="${billions_de > 0 && millions_de != 0}">
						    	<p>전세  : ${billionsFormatted_de}억 ${millionsFormatted_de}만원</p>
							</c:if>
							<c:if test="${billions_de > 0 && millions_de == 0}">
							    <p>전세  : ${billionsFormatted_de}억</p>
							</c:if>
							<c:if test="${billions_de < 1 && millions_de > 0}">
								<p>전세  : ${millionsFormatted_de}만원</p>
							</c:if>
						    </c:when>
						<c:when test="${pdetail.property_type_id == 3}">
							<c:if test="${billions_de >= 1 && millions_de != 0}">
						    	<p>월세 : ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${pdetail.month_price}</p>
							</c:if>
							<c:if test="${billions_de > 0 && millions_de == 0}">
								<p>월세 : ${billionsFormatted_de}억 / ${pdetail.month_price}</p>
							</c:if>
							<c:if test="${billions_de < 1}">
								<p>월세 : ${pdetail.deposit} / ${pdetail.month_price}</p>
							</c:if>	
						</c:when>
					</c:choose>
					<p>평수: ${pdetail.feet}</p>
					<c:choose>
						<c:when test="${pdetail.floor == -1 }">
							<p>층수 : 고층</p>
						</c:when>
						<c:when test="${pdetail.floor == -2 }">
							<p>층수 : 중층</p>
						</c:when>
						<c:when test="${pdetail.floor == -3 }">
							<p>층수 : 저층</p>
						</c:when>
						<c:when test="${pdetail.floor > 0 }">
							<p>층수: ${pdetail.floor}</p>
						</c:when>
					</c:choose>
					
					
					<p>관리비: ${pdetail.charge}</p>
					<p>방 개수: ${pdetail.count}</p>
					<c:choose>
						<c:when test="${fn:contains(move_date, '1111-11-11')}">
							<p>입주 가능일: 즉시 입주가능</p>
						</c:when>
						<c:when test="${fn:contains(move_date, '2222-22-22')}">
							<p>입주 가능일: 협의가능</p>
						</c:when>
						<c:otherwise>
							<p>입주 가능일: ${move_date}</p>
						</c:otherwise>
					</c:choose>
						
					
					
					<p>
						등록 날짜:
						<fmt:formatDate value="${pdetail.registration_date}"
							pattern="yyyy-MM-dd" />
					</p>
					<p>설명: ${pdetail.description}</p>
			
					<button class="btn btn-primary" type="button" id="telephone">연락처 보기</button>
				</div>
	

				
			</div>
		<h5 style="margin-top:50px;">주변 지도</h5>
		<div id="map">
		
		</div>
		</div>
		
		<div class="modal_wrap">
			<div class="modal_close"><a href="#">close</a></div>
			<h5 style="font-size:24px; margin-top:10px; margin-left:10px;"><strong>문의 전 꼭 확인해주세요!</strong></h5>
			
			<p>
				계약할 상대방이 실소유자가 맞는지 꼭 체크하세요.<br>
				(등기부등본상 소유자가 맞는지 주민등록증, 주민등록등본, 등기권리증 같은 서류 확인 필수)
			</p>
			<p>
				거래 대상 목적물을 직접 찾아가 답사하세요.
			</p>
			<p>
				위 내용을 충분히 확인한 후, 금전적인 거래를 진행해주세요.<br>
				(보증금 또는 월세 선입금 요구 시 주의하세요.)
			</p>
			<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-telephone-fill" viewBox="0 0 16 16"
			style="color:blue; position:relative; top:71px; left:130px;">
			  <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
			</svg>
			<p style="color:blue; text-align:center; font-size:24px;"><strong>${pdetail.telephone}</strong></p>
			<p style="color:blue; margin-top:10px!important;">개인과의 직거래 시 언제나 안전에 유의하세요</p>
		</div>
		
	</div>
</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e08b8b197fa1546d4d48218f8d18451&libraries=services"></script>
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
	    deposit: ${psdetail.deposit},
	    month_price: ${psdetail.month_price},
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

<script>
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${pdetail.address}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${pdetail.pname}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
    
  </script>
</body>
</html>
