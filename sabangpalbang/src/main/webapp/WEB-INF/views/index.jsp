<%@ page  isELIgnored="false" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/index.css">
	<title>시큐리티 테스트</title>
	<style>
		.bi {
        vertical-align: -0.125em;
        fill: currentColor;
      	}
      	
      	#img_zoom_par {
      		overflow: hidden;
      	}
      	
      	#img_zoom {
      		transform: scale(1.0);
            -webkit-transform: scale(1.0);
            -moz-transform: scale(1.0);
            -ms-transform: scale(1.0); 
            -o-transform: scale(1.0);

            transition: transform 0.3s;
      	}
      	
      	#img_zoom_par:hover #img_zoom {
      		transform: scale(1.2);
            -webkit-transform: scale(1.2);
            -moz-transform: scale(1.2);
            -ms-transform: scale(1.2); /* IE 9 */
            -o-transform: scale(1.2);

            transition: transform 0.3s;
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
            <li><a href="/map?searchType=&keyword=&deal=1&jeonse=1&wolse=1" class="nav-link px-2">지도</a></li>
            <li><a href="/transaction" class="nav-link px-2">실거래가 비교</a></li>
            <li><a href="/mypage/upload" class="nav-link px-2">방 내놓기</a></li>
            <li><a href="/question/title" class="nav-link px-2">문의게시판</a></li>
          </ul>

          <div class="col-md-3 text-end">
          	<sec:authorize access="!isAuthenticated()"> 
	            <button type="button" class="btn btn-outline-primary me-2" onclick = "location.href = '/login'" >
	              로그인
	            </button>	        
            	<button type="button" class="btn btn-primary" onclick = "location.href = '/insert'" style="margin-right:50px;">회원가입</button>
            </sec:authorize>
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
	
	<div class=main>
		<div class=container>
			<h2>어떤 방을 찾으세요?</h2>
			<form action="map" method="get" id="searchForm" style="top:60px; position:relative;">
			    <div class="mx-auto mt-5 search-bar input-group mb-3">	
			      <input type="hidden" name="searchType" value="">
			      <input name="keyword" id="keyword" onkeypress="navigateOnEnter(event)" type="search" class="form-control rounded-pill" placeholder="찾아보고 싶은 지역이나 단지명을 입력하세요."> 
			      <button id="searchb" style="border: none; background: none; color:inherit;">
				      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi-search" viewBox="0 0 16 16" style="z-index:2;">
					  	<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					  </svg>
				  </button>
				  <input type="hidden" name="deal" value="1">
				  <input type="hidden" name="jeonse" value="1">
				  <input type="hidden" name="wolse" value="1">
			      <div class="input-group-append">
			      </div>
			    </div>
			</form>
		</div>
		<section class=recommend_property>
			<div>
				<h2>혹시 이런 곳은 어떠신가요?</h2>
				<p style="padding-top:40px;">여기 매물들은 <strong>로그인</strong>을 해야 상세정보를 확인할 수 있습니다.</p>
				<ul class=RoomList>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanServiceProperties[0].price / 10000}" />
							<c:set var="millions" value="${(getRanServiceProperties[0].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[0].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[0].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer; overflow:hidden;" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[0].ps_service_type}&propertyId=${getRanServiceProperties[0].property_service_id}&address=${getRanServiceProperties[0].address}&pname=${getRanServiceProperties[0].pname}'; }">
			                        <div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="/roomImg/${getRanServiceProperties[0].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getRanServiceProperties[0].count}</p>
			                                    <c:choose>
													<c:when test="${getRanServiceProperties[0].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
								                    </c:when>
								                    <c:when test="${getRanServiceProperties[0].property_type_id == 2}">
								                        <c:if test="${billions_de > 0 && millions_de != 0}">
													    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
														</c:if>
														<c:if test="${billions_de > 0 && millions_de == 0}">
														    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
															</c:if>
														<c:if test="${billions_de < 1 && millions_de > 0}">
														<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
														</c:if>
									                </c:when>
								                    <c:when test="${getRanServiceProperties[0].property_type_id == 3}">
								                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
													    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanServiceProperties[0].month_price}</h5>
														</c:if>
								                    	<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanServiceProperties[0].month_price}</h5>
														</c:if>
														<c:if test="${billions_de < 1}">
															<h5 class="Roomprice3">월세  ${getRanServiceProperties[0].deposit} / ${getRanServiceProperties[0].month_price}</h5>
														</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanServiceProperties[0].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
							</a>
						</div>
					</li>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanServiceProperties[1].price / 10000}" />
							<c:set var="millions" value="${(getRanServiceProperties[1].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[1].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[1].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[1].ps_service_type}&propertyId=${getRanServiceProperties[1].property_service_id}&address=${getRanServiceProperties[1].address}&pname=${getRanServiceProperties[1].pname}'; }">
									<div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="/roomImg/${getRanServiceProperties[1].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 개수: ${getRanServiceProperties[1].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[1].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
								                    </c:when>
								                    <c:when test="${getRanServiceProperties[1].property_type_id == 2}">
								                        <c:if test="${billions_de > 0 && millions_de != 0}">
													    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
														</c:if>
														<c:if test="${billions_de > 0 && millions_de == 0}">
														    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
															</c:if>
														<c:if test="${billions_de < 1 && millions_de > 0}">
														<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
														</c:if>
									                </c:when>
								                    <c:when test="${getRanServiceProperties[1].property_type_id == 3}">
								                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
													    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanServiceProperties[1].month_price}</h5>
														</c:if>
								                    	<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanServiceProperties[1].month_price}</h5>
														</c:if>
														<c:if test="${billions_de < 1}">
															<h5 class="Roomprice3">월세  ${getRanServiceProperties[1].deposit} / ${getRanServiceProperties[1].month_price}</h5>
														</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanServiceProperties[1].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
			                    
							</a>
						</div>
					</li>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanServiceProperties[2].price / 10000}" />
							<c:set var="millions" value="${(getRanServiceProperties[2].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[2].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[2].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
								
								
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[2].ps_service_type}&propertyId=${getRanServiceProperties[2].property_service_id}&address=${getRanServiceProperties[2].address}&pname=${getRanServiceProperties[2].pname}'; }">
									<div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="/roomImg/${getRanServiceProperties[2].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getRanServiceProperties[2].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[2].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
								                    </c:when>
								                    <c:when test="${getRanServiceProperties[2].property_type_id == 2}">
								                        <c:if test="${billions_de > 0 && millions_de != 0}">
													    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
														</c:if>
														<c:if test="${billions_de > 0 && millions_de == 0}">
														    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
															</c:if>
														<c:if test="${billions_de < 1 && millions_de > 0}">
														<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
														</c:if>
									                </c:when>
								                    <c:when test="${getRanServiceProperties[2].property_type_id == 3}">
								                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
													    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanServiceProperties[2].month_price}</h5>
														</c:if>
								                    	<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanServiceProperties[2].month_price}</h5>
														</c:if>
														<c:if test="${billions_de < 1}">
															<h5 class="Roomprice3">월세  ${getRanServiceProperties[2].deposit} / ${getRanServiceProperties[2].month_price}</h5>
														</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanServiceProperties[2].description}</p>
			                                </div>
			                            </div>	
			                        	
			                         </div>
			                    </div>
			                    
							</a>
						</div>
					</li>
					<li>
						<div>
							<a>
							
							<c:set var="billions" value="${getRanServiceProperties[3].price / 10000}" />
							<c:set var="millions" value="${(getRanServiceProperties[3].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[3].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[3].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[3].ps_service_type}&propertyId=${getRanServiceProperties[3].property_service_id}&address=${getRanServiceProperties[3].address}&pname=${getRanServiceProperties[3].pname}'; }">
									<div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="/roomImg/${getRanServiceProperties[3].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getRanServiceProperties[3].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[3].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
								                    </c:when>
								                    <c:when test="${getRanServiceProperties[3].property_type_id == 2}">
								                        <c:if test="${billions_de > 0 && millions_de != 0}">
													    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
														</c:if>
														<c:if test="${billions_de > 0 && millions_de == 0}">
														    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
															</c:if>
														<c:if test="${billions_de < 1 && millions_de > 0}">
														<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
														</c:if>
									                </c:when>
								                    <c:when test="${getRanServiceProperties[3].property_type_id == 3}">
								                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
													    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanServiceProperties[3].month_price}</h5>
														</c:if>
								                    	<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanServiceProperties[3].month_price}</h5>
														</c:if>
														<c:if test="${billions_de < 1}">
															<h5 class="Roomprice3">월세  ${getRanServiceProperties[3].deposit} / ${getRanServiceProperties[3].month_price}</h5>
														</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanServiceProperties[3].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
							</a>
						</div>
					</li>
					<li>
						
					</li>
				</ul>
			</div>
		</section>
		<section class=recommend_property2>
			<div>
				<h2>바로 볼 수 있는 매물은 어떠신가요?</h2>
				<p style="padding-top:40px;">여기 매물들은 <strong>로그인</strong> 없이 상세정보를 확인할 수 있습니다.</p>
				<ul class=RoomList>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanProperties[0].price / 10000}" />
							<c:set var="millions" value="${(getRanProperties[0].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanProperties[0].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanProperties[0].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/pDetail?p_service_type=${getRanProperties[0].p_service_type}&propertyId=${getRanProperties[0].property_id}&address=${getRanProperties[0].address}&pname=${getRanProperties[0].pname}'; }">
									<div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="${getRanProperties[0].images.filepath}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getRanProperties[0].count}</p>
			                                    <c:choose>
													<c:when test="${getRanProperties[0].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
								                    </c:when>
								                    <c:when test="${getRanProperties[0].property_type_id == 2}">
								                        <c:if test="${billions_de > 0 && millions_de != 0}">
													    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
														</c:if>
														<c:if test="${billions_de > 0 && millions_de == 0}">
														    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
															</c:if>
														<c:if test="${billions_de < 1 && millions_de > 0}">
														<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
														</c:if>
									                </c:when>
								                    <c:when test="${getRanProperties[0].property_type_id == 3}">
								                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
													    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanProperties[0].month_price}</h5>
														</c:if>
								                    	<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanProperties[0].month_price}</h5>
														</c:if>
														<c:if test="${billions_de < 1}">
															<h5 class="Roomprice3">월세  ${getRanProperties[0].deposit} / ${getRanProperties[0].month_price}</h5>
														</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanProperties[0].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
							</a>
						</div>
					</li>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanProperties[1].price / 10000}" />
							<c:set var="millions" value="${(getRanProperties[1].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanProperties[1].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanProperties[1].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/pDetail?p_service_type=${getRanProperties[1].p_service_type}&propertyId=${getRanProperties[1].property_id}&address=${getRanProperties[1].address}&pname=${getRanProperties[1].pname}'; }">
									<div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="${getRanProperties[1].images.filepath}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getRanProperties[1].count}</p>
			                                    <c:choose>
													<c:when test="${getRanProperties[1].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
							                    </c:when>
							                    <c:when test="${getRanProperties[1].property_type_id == 2}">
							                        <c:if test="${billions_de > 0 && millions_de != 0}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
														</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanProperties[1].property_type_id == 3}">
							                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
												    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanProperties[1].month_price}</h5>
													</c:if>
							                    	<c:if test="${billions_de > 0 && millions_de == 0}">
												    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanProperties[1].month_price}</h5>
													</c:if>
													<c:if test="${billions_de < 1}">
														<h5 class="Roomprice3">월세  ${getRanProperties[1].deposit} / ${getRanProperties[1].month_price}</h5>
													</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanProperties[1].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
							</a>
						</div>
					</li>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanProperties[2].price / 10000}" />
							<c:set var="millions" value="${(getRanProperties[2].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanProperties[2].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanProperties[2].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/pDetail?p_service_type=${getRanProperties[2].p_service_type}&propertyId=${getRanProperties[2].property_id}&address=${getRanProperties[2].address}&pname=${getRanProperties[2].pname}'; }">
									<div class="card h-100">
			                        <div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="${getRanProperties[2].images.filepath}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getRanProperties[2].count}</p>
			                                    <c:choose>
													<c:when test="${getRanProperties[2].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
							                    </c:when>
							                    <c:when test="${getRanProperties[2].property_type_id == 2}">
							                        <c:if test="${billions_de > 0 && millions_de != 0}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
														</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanProperties[2].property_type_id == 3}">
							                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
												    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanProperties[2].month_price}</h5>
													</c:if>
							                    	<c:if test="${billions_de > 0 && millions_de == 0}">
												    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanProperties[2].month_price}</h5>
													</c:if>
													<c:if test="${billions_de < 1}">
														<h5 class="Roomprice3">월세  ${getRanProperties[2].deposit} / ${getRanProperties[2].month_price}</h5>
													</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanProperties[2].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
							</a>
						</div>
					</li>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanProperties[3].price / 10000}" />
							<c:set var="millions" value="${(getRanProperties[3].price % 10000)}" />
							<fmt:parseNumber var="billionsFormatted" value="${billions}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanProperties[3].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanProperties[3].deposit % 10000)}" />
							<fmt:parseNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" integerOnly="true"/>
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/pDetail?p_service_type=${getRanProperties[3].p_service_type}&propertyId=${getRanProperties[3].property_id}&address=${getRanProperties[3].address}&pname=${getRanProperties[3].pname}'; }">
									<div class="card h-100">
			                       	<div id="img_zoom_par">
			                        	<img id="img_zoom" class="card-img-top" src="${getRanProperties[3].images.filepath}" alt="..." style="width:280px; height:186px;"/>
			                        </div>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getRanProperties[3].count}</p>
			                                    <c:choose>
													<c:when test="${getRanProperties[3].property_type_id == 1}">
							                        	<c:if test="${billions > 0 && millions != 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
														<c:if test="${billions > 0 && millions == 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억</h5>
														</c:if>
														
							                    </c:when>
							                    <c:when test="${getRanProperties[3].property_type_id == 2}">
							                        <c:if test="${billions_de > 0 && millions_de != 0}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de > 0 && millions_de == 0}">
													    <h5 class="Roomprice2">전세  : ${billionsFormatted_de}억</h5>
														</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanProperties[3].property_type_id == 3}">
							                    	<c:if test="${billions_de >= 1 && millions_de != 0}">
												    <h5 class="Roomprice3">월세 ${billionsFormatted_de}억 ${millionsFormatted_de}만원 / ${getRanProperties[3].month_price}</h5>
													</c:if>
							                    	<c:if test="${billions_de > 0 && millions_de == 0}">
												    <h5 class="Roomprice3">월세  ${billionsFormatted_de}억 / ${getRanProperties[3].month_price}</h5>
													</c:if>
													<c:if test="${billions_de < 1}">
														<h5 class="Roomprice3">월세  ${getRanProperties[3].deposit} / ${getRanProperties[3].month_price}</h5>
													</c:if>	
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getRanProperties[3].description}</p>
			                                </div>
			                            </div>	
			                        	
			                        </div>
			                    </div>
							</a>
						</div>
					</li>
				</ul>
			</div>
		</section>
		
	</div>
	
	<div class=footer>
		<div class="container" id="footer_con">
			<p id="footer">(주)사방팔방</p>
			<p id="footer">대표: 홍길동</p>
			<p>고객센터: 02-1234-5678 | 평일 10:00 ~ 18:30, 점심시간 : 12:30 ~ 13:30 (토·일요일, 공휴일 휴무)</p>
			<p id="foot1">© 2024 SabangPalbang. All rights reserved.</p>
	    	<p id="foot2">Contact: SabangPalbang@example.com</p>
    	</div>
	</div>
	
	 <script>
/* 	 document.getElementById("priceRange").value = "0만원"+"-"+"무제한"; 
 */        function navigateOnEnter(event) {
        	
            if (event.key === 'Enter') {
            	
            	$("#keyword").submit();
                
            }
        }
 
	 document.getElementById('searchb').addEventListener('click', function() {
		    $("#searchForm").submit();	});
    </script>
	
	
	
</body>
</html>