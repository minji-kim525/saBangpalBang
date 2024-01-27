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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=06f4a6f0808017813dd6a404a0927314"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
 	 <!-- 부트스트랩 CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery UI CSS -->
    <link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
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
/* 		height:64px; */	
		height: auto;
		background-color:green;
	}
	
	#property_type_filter{
		width:50%;
	}
	
	#feet_filter{
		width:50%;
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
<div id="search_filter">

	<form action="map" method="get" id="searchForm">

        <select name="searchType">
        	<option value="" ${searchDto.searchType == "" ? 'selected' : ''}>전체 검색</option>
            <option value="name" ${searchDto.searchType == "name" ? 'selected' : ''}>건물명</option>
            <option value="address" ${searchDto.searchType == "address" ? 'selected' : ''}>주소</option>
        </select>
        <input type="text" id="keywordForm" name="keyword" placeholder="키워드를 입력해 주세요." title="키워드 입력"  value="${searchDto.keyword}"/>
        <button type="button" id="search_submit"><span class="skip_info">검색</span></button>
         
        <!-- <div class="slider-row">
            <div class="col">
                <label for="amount">가격 범위:</label>
                <input type="text" id="amount" readonly class="form-control bg-white">
                <div id="slider-range"></div>
            </div>
        </div> -->
        <div id="property_type_filter">
	        <input type="checkbox" name="deal" value="1" ${mainSearchDto.deal == "1" ? 'checked' : ''}>매매
	      	<input type="checkbox" name="jeonse" value="1" ${mainSearchDto.jeonse == "1" ? 'checked' : ''}>전세
	        <input type="checkbox" name="wolse" value="1" ${mainSearchDto.wolse == "1" ? 'checked' : ''}>월세
	                    
	    	<div id="dealSlider" class="slider">
		        <label class="slider-label" for="dealAmount">매매 가격 범위:</label>
		        <input type="text" id="dealAmount" name="dealAmount" readonly class="form-control bg-white">      
		        <div class="slider-range" id="dealRange"></div>
	   		</div>
	   		
	    	<div id="jeonseSlider" class="slider">
		        <label class="slider-label" for="jeonseAmount">보증금/전세 가격 범위:</label>
		        <input type="text" id="jeonseAmount" name="jeonseAmount" readonly class="form-control bg-white">
		        <div class="slider-range" id="jeonseRange"></div>
	    	</div>
	    	<!-- style="display: none;" -->
	    	<div id="wolseSlider" class="slider">
		        <label class="slider-label" for="wolseAmount">월세 가격 범위:</label>
		        <input type="text" id="wolseAmount" name="wolseAmount" readonly class="form-control bg-white">
		        <div class="slider-range" id="wolseRange"></div>
	   		</div>
   		</div>
   		<div id="feet_filter">
	                    
	    	<div id="feetSlider" class="slider">
		        <label class="slider-label" for="feetAmount">전용평수:</label>
		        <input type="text" id="feetAmount" name="feetAmount" readonly class="form-control bg-white">
		        <div class="slider-range" id="feetRange"></div>
	   		</div>
   		</div>
     </form> 
</div>
      
<div id=container>

	<div id="search">
			<div class="property-container">
				<c:forEach var="property" items="${list}">
				<c:choose>
					<c:when test="${property.p_service_type == 2}">
						<div class="property"
							onclick="{ location.href='/property/pDetail?p_service_type=${property.p_service_type}&propertyId=${property.property_id}&address=${property.address}&pname=${property.pname}'; }"
							style="cursor: pointer;">
							<img class="roomimg" src="${property.imageOne.filepath}" alt=""><br>
							<div class="roominfo">
							<c:choose>
								<c:when test="${property.property_type_id == 1}">
									<h3 class="property-type">매매 ${ChargeFunction.formatNumberWithUnit(property.price)}</h3>
								</c:when>
								<c:when test="${property.property_type_id == 2}">
									<h3 class="property-type">전세 ${ChargeFunction.formatNumberWithUnit(property.deposit)}</h3>
								</c:when>
								<c:when test="${property.property_type_id == 3}">
									<h3 class="property-type">월세 ${property.deposit} / ${property.month_price}</h3>
								</c:when>
							</c:choose>
							
							<p class="pname">${property.pname}</p>	
							<p class="roombr">방 개수: ${property.count}</p>
							<p class="roomfloor">${property.floor}층, ${property.feet}평, 관리비 ${property.charge}만</p>
							</div>
						</div>
					</c:when>
					<c:when
						test="${property.private_property == false && property.ps_service_type == 1}">
						<div class="property"
							onclick="{location.href='/property/psDetail?ps_service_type=${property.ps_service_type}&propertyId=${property.property_service_id}&address=${property.address}&pname=${property.pname}'; }"
							style="cursor: pointer;">
							<img src="/roomImg/${property.imageOne.filename}" alt=""><br>
							<div class="roominfo">
							<c:choose>
								<c:when test="${property.property_type_id == 1}">
									<h3 class="property-type">매매 ${ChargeFunction.formatNumberWithUnit(property.price)}</h3>
								</c:when>
								<c:when test="${property.property_type_id == 2}">
									<h3 class="property-type">전세 ${ChargeFunction.formatNumberWithUnit(property.deposit)}</h3>
								</c:when>
								<c:when test="${property.property_type_id == 3}">
									<h3 class="property-type">월세 ${property.deposit} / ${property.month_price}</h3>
								</c:when>
							</c:choose>
							<p class="pname">${property.pname}</p>	
							<p class="roombr">방 개수: ${property.count}</p>
							<p class="roomfloor">${property.floor}층, ${property.feet}평, 관리비 ${property.charge}만</p>
							</div>
						</div>
					</c:when>
				</c:choose>
				</c:forEach>
				
				<jsp:include page="../mapPaging.jsp" flush="true">
				<jsp:param value="${mainSearchDto.searchType}" name="searchType"/>
				<jsp:param value="${mainSearchDto.keyword}" name="keyword"/>
				<jsp:param value="${mainSearchDto.wolse}" name="wolse"/>
				<jsp:param value="${mainSearchDto.jeonse}" name="jeonse"/>
				<jsp:param value="${mainSearchDto.deal}" name="deal"/>
				<jsp:param value="${mainSearchDto.dealAmount}" name="dealAmount"/>
				<jsp:param value="${mainSearchDto.jeonseAmount}" name="jeonseAmount"/>
				<jsp:param value="${mainSearchDto.wolseAmount}" name="wolseAmount"/>
				<jsp:param value="${mainSearchDto.feetAmount}" name="feetAmount"/>
				<jsp:param value="${mainSearchDto.page}" name="page"/>
				<jsp:param value="${pagination.startPage}" name="startPage"/>
				<jsp:param value="${pagination.endPage}" name="endPage"/>
				<jsp:param value="${pagination.existPrevPage}" name="existPrevPage"/>
				<jsp:param value="${pagination.existNextPage}" name="existNextPage"/>
				</jsp:include>
			</div>
	</div>

	<div id="map"></div>
</div>
<div id="footer"></div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(37.5666103, 126.9783882), // 지도의 중심좌표
    level: 7 // 지도의 확대 레벨
};

//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);


var overlays = [];
var getRegion_result;
//지명 커스텀오버레이 생성 함수
function addCustomOverlay(name,lat,long){
    // 커스텀 오버레이에 표시할 내용입니다     
    // HTML 문자열 또는 Dom Element 입니다
    var content = '<div style="position: absolute; cursor: pointer; white-space: nowrap;">' + 
                    '<div class="sc-jNMcJZ custom" style="width: 60px; height: 23px; background-image: url(../icon/local.png);">' +
                       ' <div class="sc-dOSRxR jbhFAf" style="color: rgb(254, 254, 254);">' + name + '</div>' +
                    '</div>' + 
                '</div>';

    // 커스텀 오버레이가 표시될 위치입니다 
    var position = new kakao.maps.LatLng(lat, long);  

     // 커스텀 오버레이를 생성합니다
    var customOverlay = new kakao.maps.CustomOverlay({
        position: position,
        content: content   
    });       
    overlays.push(customOverlay);
    customOverlay.setMap(map);
}

//오버레이 화면에 표시 or 재거
function setCustomOverlays(map, overlays) {
    for (var i = 0; i < overlays.length; i++) {
        overlays[i].setMap(map);
    }            
}

//현재 지도 영역 지명 얻는 함수(커스텀오버레이)
function getRegionName(){
    // 지도의 현재 영역을 얻어옵니다 
    var bounds = map.getBounds();
    // 영역의 남서쪽 좌표를 얻어옵니다 
    var swLatLng = bounds.getSouthWest(); 
    // 영역의 북동쪽 좌표를 얻어옵니다 
    var neLatLng = bounds.getNorthEast();
    
    var swLat = swLatLng.getLat();
    var swLon = swLatLng.getLng();
    var neLat = neLatLng.getLat();
    var neLon = neLatLng.getLng();
    
    //ajax로 지도영역 좌표 보내서 영역안의 시군구동 이름,좌표 얻어오기
    const xhttp = new XMLHttpRequest();
    xhttp.open("POST","map");
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("swLat="+swLat+"&swLon="+swLon+"&neLat="+neLat+"&neLon="+neLon+"&mapLevel="+map.getLevel());
    xhttp.addEventListener("readystatechange",function(){
        if(xhttp.readyState==4 && xhttp.status==200){
            getRegion_result = JSON.parse(xhttp.responseText.trim());
            console.log(getRegion_Result);
        }
    })  	
}

//------------------------지도 중심좌표 or 확대,축소 이벤트-------------------------------------------
kakao.maps.event.addListener(map, 'idle', function() {

    setCustomOverlays(null, overlays);

    getRegionName();    //지역명 커스텀 오버레이

    //시,군,동, 지역 이름 커스텀 오버레이 출력
 	if(map.getLevel()>=5 && map.getLevel()<7){
        for(let i in getRegion_result){
            setTimeout(function(){
                if(getRegion_result[i].dong!=null&&getRegion_result[i].sigungu!=null){
                    addCustomOverlay(getRegion_result[i].dong, getRegion_result[i].lat, getRegion_result[i].lon);  
                }
            },10);
        }
    }else if(map.getLevel()>=7 && map.getLevel()<11){
        for(let i in getRegion_result){
            setTimeout(function(){
                if(getRegion_result[i].dong==null&&getRegion_result[i].sigungu!=null){
                    addCustomOverlay(getRegion_result[i].sigungu, getRegion_result[i].lat, getRegion_result[i].lon);
                } 
            },10);
        }
    }else if(map.getLevel()>=11){
        for(let i in getRegion_result){
            setTimeout(function(){
                if(getRegion_result[i].sido!=null&&getRegion_result[i].dong==null&&getRegion_result[i].sigungu==null){
                    addCustomOverlay(getRegion_result[i].sido, getRegion_result[i].lat, getRegion_result[i].lon);   
                }
            },10);
        }
    }
});




</script>

 <!-- jQuery 및 jQuery UI -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- 부트스트랩 JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(function() {
        	var urlParams = new URLSearchParams(window.location.search);

            // 페이지가 최초로 로드될 때 (검색이 수행되지 않았을 때)
            if (!urlParams.has('searchType')) {
                // 모든 체크박스를 체크
                $('#property_type_filter input[type="checkbox"]').prop('checked', true).change();
            }

            // 검색 버튼 클릭 이벤트
            $("#search_submit").click(function(event) {
             
                $('#searchForm').submit();
            });
        	
	       	 $('#property_type_filter input[type="checkbox"]').click(function(event) {
	 	        var checkedBoxes = $('#property_type_filter input[type="checkbox"]:checked');
	 	        
	 	        // 마지막 체크박스의 해제 방지
	 	       if (checkedBoxes.length === 0) {
	     		$(this).prop('checked', true);
	 			}
	 	    });
	       	 
	       	var dealMin = ${mainSearchDto.dealPriceMin != null ? mainSearchDto.dealPriceMin : 0};
	        var dealMax = ${mainSearchDto.dealPriceMax != null ? mainSearchDto.dealPriceMax : 160000};
	        var jeonseMin = ${mainSearchDto.jeonsePriceMin != null ? mainSearchDto.jeonsePriceMin : 0};
	        var jeonseMax = ${mainSearchDto.jeonsePriceMax != null ? mainSearchDto.jeonsePriceMax : 95000};
	        var wolseMin = ${mainSearchDto.wolsePriceMin != null ? mainSearchDto.wolsePriceMin : 0};
	        var wolseMax = ${mainSearchDto.wolsePriceMax != null ? mainSearchDto.wolsePriceMax : 400};
	        var feetMin = ${mainSearchDto.feetMin != null ? mainSearchDto.feetMin : 0};
	        var feetMax = ${mainSearchDto.feetMax != null ? mainSearchDto.feetMax : 100};
	        
        	$('#searchForm input[type="checkbox"]').change(function() {
                // 매매 체크박스 변경 시
                if (this.name === 'deal') {
                    $('#dealSlider').toggle(this.checked);
                }

                // 전세 체크박스 변경 시
                if (this.name === 'jeonse') {
                    $('#jeonseSlider').toggle(this.checked);
                }

                // 월세 체크박스 변경 시
                if (this.name === 'wolse') {
                    $('#jeonseSlider').toggle(this.checked); // 월세 선택 시 전세 슬라이더도 표시
                    $('#wolseSlider').toggle(this.checked);
                }
            });
        	
        	  $('#dealRange').slider({
        	        range: true,
        	        min: 0,
        	        max: 160000,
        	        values: [dealMin, dealMax], // 초기값 설정
        	        create: function(event, ui) {
        	            var initialValue = $(this).slider("values", 0);
        	            var initialStep = determineStep(initialValue);
        	            $(this).slider('option', 'step', initialStep);
        	        },
        	        slide: function(event, ui) {
        	            var newStep = determineStep(ui.value);
        	            $(this).slider('option', 'step', newStep);
        	            $('#dealAmount').val(formatPrice(ui.values[0]) + ' - ' + formatPrice(ui.values[1]));
        	            
        	            console.log("현재 값: ", ui.values[0], ui.values[1]);

        	        }
        	    });
            
        	  $('#jeonseRange').slider({
      	        range: true,
      	        min: 0,
      	        max: 95000,
      	        values: [jeonseMin, jeonseMax], // 초기값 설정
      	        create: function(event, ui) {
      	            var initialValue = $(this).slider("values", 0);
      	            var initialStep = determineStep2(initialValue);
      	            $(this).slider('option', 'step', initialStep);
      	        },
      	        slide: function(event, ui) {
      	            var newStep = determineStep2(ui.value);
      	            $(this).slider('option', 'step', newStep);
      	            $('#jeonseAmount').val(formatPrice2(ui.values[0]) + ' - ' + formatPrice2(ui.values[1]));
      	            
      	            console.log("현재 값: ", ui.values[0], ui.values[1]);

      	        }
      	    });
        	  
        	  $('#wolseRange').slider({
      	        range: true,
      	        min: 0,
      	        max: 400,
      	        values: [wolseMin, wolseMax], // 초기값 설정
      	        create: function(event, ui) {
      	            var initialValue = $(this).slider("values", 0);
      	            var initialStep = determineStep3(initialValue);
      	            $(this).slider('option', 'step', initialStep);
      	        },
      	        slide: function(event, ui) {
      	            var newStep = determineStep3(ui.value);
      	            $(this).slider('option', 'step', newStep);
      	            $('#wolseAmount').val(formatPrice3(ui.values[0]) + ' - ' + formatPrice3(ui.values[1]));
      	            
      	            console.log("현재 값: ", ui.values[0], ui.values[1]);

      	        }
      	    });
        	  
        	  $('#feetRange').slider({
      	        range: true,
      	        min: 0,
      	        max: 100,
      	        values: [feetMin,feetMax], // 초기값 설정
      	      	step: 1,
      	   		slide: function(event, ui) {
      	        $("#feetAmount").val(formatPrice4(ui.values[0]) + ' - ' + formatPrice4(ui.values[1]));
      	    	}
      	        
      	    });
        	  
        		//매매
        	    function determineStep(value) {
        	       	if (value < 50000) return 5000;
        	        else return 10000;
        	    }
        	    //전세
        	    function determineStep2(value) {
        	        if (value < 1000) return 100;
        	        else if (value < 10000) return 500;
        	        else if (value < 20000) return 1000;
        	        else return 5000;
        	    }
        	  
        	   //월세
        	    function determineStep3(value) {
        	        if (value < 100) return 5;
        	        else return 10;
        	    
        	    }
        	    
        	  

        	    $('#dealAmount').val(formatPrice($('#dealRange').slider('values', 0)) +
        	                    ' - ' + formatPrice($('#dealRange').slider('values', 1)));
        	    
        	    $('#jeonseAmount').val(formatPrice2($('#jeonseRange').slider('values', 0)) +
	                    ' - ' + formatPrice2($('#jeonseRange').slider('values', 1)));
        	    
        	    $('#wolseAmount').val(formatPrice3($('#wolseRange').slider('values', 0)) +
	                    ' - ' + formatPrice3($('#wolseRange').slider('values', 1)));
        	    
        	    $('#feetAmount').val(formatPrice4($('#feetRange').slider('values', 0)) +
	                    ' - ' + formatPrice4($('#feetRange').slider('values', 1)));
        	    
        	    //매매
                function formatPrice(value) {
                   if (value === 160000) {
                       return '무제한';
                   } else if (value >= 10000) {
                       var billions = Math.floor(value / 10000);
                       var tenMillions = Math.floor((value % 10000) / 1000);
                       if (tenMillions > 0) {
                           return billions + '억 ' + tenMillions + '천만원';
                       } else {
                           return billions + '억원';
                       }
                   } else if (value >= 1000) {
                       return Math.floor(value / 1000) + '천만원';
                   } else {
                       return value + '만원';
                   }
               }
               //전세
               function formatPrice2(value) {
                   if (value === 95000) {
                       return '무제한';
                   } else if (value >= 10000) {
                       var billions = Math.floor(value / 10000);
                       var tenMillions = Math.floor((value % 10000) / 1000);
                       if (tenMillions > 0) {
                           return billions + '억 ' + tenMillions + '천만원';
                       } else {
                           return billions + '억원';
                       }
                   } else if (value >= 1000) {
                       return Math.floor(value / 1000) + '천만원';
                   } else {
                       return value + '만원';
                   }
               }
               //월세
               function formatPrice3(value) {
                   if (value === 400) {
                       return '무제한';
                   } else if (value >= 10000) {
                       var billions = Math.floor(value / 10000);
                       var tenMillions = Math.floor((value % 10000) / 1000);
                       if (tenMillions > 0) {
                           return billions + '억 ' + tenMillions + '천만원';
                       } else {
                           return billions + '억원';
                       }
                   } else if (value >= 1000) {
                       return Math.floor(value / 1000) + '천만원';
                   } else {
                       return value + '만원';
                   }
               }
        	 
             //전용면적
               function formatPrice4(value) {
                   if (value === 100) {
                       return '무제한';
              		} else {
                   return value+'평';}
             }
        	});
       
     
    </script>
</body>
</html>