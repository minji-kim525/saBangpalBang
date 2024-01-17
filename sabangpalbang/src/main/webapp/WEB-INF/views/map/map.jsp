<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.property.ChargeFunction"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=yl1aqr3ar8"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
</head>
<style>
	*{
		padding: 0;
		margin: 0;
	}
	
	p {
		margin-bottom:0!important;
	}
	
	.header {
		width:100vw;
	}
	
	#search {
		width:400px; 
		height:90vh; 
		background-color:red;
		float:left;
		overflow:scroll;
	}
	
	#container {
		display:flex;
		width:100%;
	}
	
	.property-container {
		width:400px;
		height:90vh;;	
		
	}
	
	.property {
		display:flex;
		margin-top:20px;
		margin-left:20px;
		margin-bottom:10px;
		width:400px;
		height:175px;;	
		
	}
	
	img {
		float:left;
		width:140px;
		height:140px;
	}
	#search_filter {
		float:left;
		width:100%; 
		height:64px; 
		background-color:green;
	}
	
	.roominfo {
		width:220px;
		margin-top:5px;
		margin-left:10px;
	}
	
	.roominfo > h3 {
		margin-bottom:15px;
	}
	
	.description {
		white-space : nowrap;
		overflow : hidden;
		text-overflow: ellipsis;
	}
	
	
	
	#map {
		float:left;
		width:76.5vw;
		height:90vh;
	}
	
	
	
	#footer {
		float:left;
		width:100vw;
		height:10vh;
		background-color:yellow;
	}
</style>
<body>
<div class="header">
        <header
          class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom" 
          style="margin-bottom:0!important; padding-bottom:0!important;"
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
            <li><a href="#" class="nav-link px-2">지도</a></li>
            <li><a href="#" class="nav-link px-2">실거래가 비교</a></li>
            <li><a href="/mypage/upload" class="nav-link px-2">방 내놓기</a></li>
            <li><a href="#" class="nav-link px-2">문의게시판</a></li>
          </ul>

          <div class="col-md-3 text-end">
          	<sec:authorize access="!isAuthenticated()"> 
	            <button type="button" class="btn btn-outline-primary me-2" onclick = "location.href = '/login'" >
	              로그인
	            </button>	        
            	<button type="button" class="btn btn-primary" onclick = "location.href = '/insert'">회원가입</button>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()"> 
				<button type="button" class="btn btn-outline-primary me-2" onclick="location.href='user'">회원정보</button>
				
				<form action="/logout" method="post" style="float:right">
				<button type="submit" class="btn btn-primary">로그아웃</button>
			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    		</form>
	    		
			</sec:authorize>
          </div>
        </header>
</div>
<div id="search_filter"></div>      
<div id=container>

	<div id="search">
			<div class="property-container">
				<c:forEach var="property" items="${getProperties}">
					<c:if test="${property.p_service_type == 2}">
						<div class="property"
							onclick="{ location.href='/property/pDetail?p_service_type=${property.p_service_type}&propertyId=${property.property_id}'; }"
							style="cursor: pointer;">
							<img class="roomimg" src="/roomImg/${property.images.filename}" alt=""><br>
							<div class="roominfo">
							<c:choose>
								<c:when test="${property.property_type_id == 1}">
									<h3 class="property-type">매매 ${ChargeFunction.formatNumberWithUnit(property.price)}</h3>
								</c:when>
								<c:when test="${property.property_type_id == 2}">
									<h3 class="property-type">전세 ${ChargeFunction.formatNumberWithUnit(property.price)}</h3>
								</c:when>
								<c:when test="${property.property_type_id == 3}">
									<h3 class="property-type">월세 ${property.deposit} / ${property.month_price}</h3>
								</c:when>
							</c:choose>
							
							<p class="description">${property.description}</p>
							</div>
						</div>
					</c:if>
				</c:forEach>
				<c:forEach var="propertyService" items="${getServiceProperties}">
					<c:if
						test="${propertyService.private_property == false && propertyService.ps_service_type == 1}">
						<div class="property"
							onclick="{ location.href='/property/psDetail?ps_service_type=${propertyService.ps_service_type}&propertyId=${propertyService.property_service_id}'; }"
							style="cursor: pointer;">
							<img src="/roomImg/${propertyService.images.filename}" alt=""><br>
							<div class="roominfo">
							<c:choose>
								<c:when test="${propertyService.property_type_id == 1}">
									<h3 class="property-type">매매 ${ChargeFunction.formatNumberWithUnit(propertyService.price)}</h3>
								</c:when>
								<c:when test="${propertyService.property_type_id == 2}">
									<h3 class="property-type">전세 ${ChargeFunction.formatNumberWithUnit(propertyService.price)}</h3>
								</c:when>
								<c:when test="${propertyService.property_type_id == 3}">
									<h3 class="property-type">월세 ${propertyService.deposit} / ${propertyService.month_price}</h3>
								</c:when>
							</c:choose>
							<p class="roombr">방 개수: ${propertyService.count}</p>
							<p class="roomfloor">${propertyService.floor}층, ${propertyService.feet}평, 관리비 ${propertyService.charge}만</p>
							<p class="description">${propertyService.description}</p>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
	</div>

	<div id="map"></div>
</div>
<div id="footer"></div>
<script>
//지도를 삽입할 HTML 요소 또는 HTML 요소의 id를 지정합니다.
var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

//옵션 없이 지도 객체를 생성하면 서울 시청을 중심으로 하는 16 레벨의 지도가 생성됩니다.
var map = new naver.maps.Map(mapDiv);
</script>
</body>
</html>