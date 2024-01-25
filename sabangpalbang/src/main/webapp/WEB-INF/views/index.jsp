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
			<form action="/property/searchAllResult" method="GET" style="top:60px; position:relative;">
			    <div class="mx-auto mt-5 search-bar input-group mb-3">	
			      <input name="keyword" id="keyword" type="search" class="form-control rounded-pill" placeholder="찾아보고 싶은 지역이나 단지명을 입력하세요." 
			      aria-label="Recipient's username" aria-describedby="button-addon2" 
			      style="height:45px; width:100%; position:relative; text-indent:60px;">
			      <a href="/" style="color:inherit;" >
				      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi-search" viewBox="0 0 16 16" style="z-index:1;">
					  	<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					  </svg>
				  </a>
			      <div class="input-group-append">
			      </div>
			    </div>
		  </form>
		</div>
		<section class=recommend_property>
			<div>
				<h3>혹시 이런 곳은 어떠신가요?</h3>
				<ul class=RoomList>
					<li>
						<div>
							<a>
							<c:set var="billions" value="${getRanServiceProperties[0].price / 100000000}" />
							<c:set var="millions" value="${(getRanServiceProperties[0].price % 100000000) / 10000}" />
							<fmt:formatNumber var="billionsFormatted" value="${billions}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[0].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[0].deposit)}" />
							<fmt:formatNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[0].ps_service_type}&propertyId=${getRanServiceProperties[0].property_service_id}&address=${getRanServiceProperties[0].address}&pname=${getRanServiceProperties[0].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getRanServiceProperties[0].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getRanServiceProperties[0].count}</p>
			                                    <c:choose>
													<c:when test="${getRanServiceProperties[0].property_type_id == 1}">
							                        	<c:if test="${billions > 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
							                    </c:when>
							                    <c:when test="${getRanServiceProperties[0].property_type_id == 2}">
							                        <c:if test="${billions_de > 1}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanServiceProperties[0].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getRanServiceProperties[0].deposit} / ${getRanServiceProperties[0].month_price}</h5>
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
							<c:set var="billions" value="${getRanServiceProperties[1].price / 100000000}" />
							<c:set var="millions" value="${(getRanServiceProperties[1].price % 100000000) / 10000}" />
							<fmt:formatNumber var="billionsFormatted" value="${billions}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[1].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[1].deposit)}" />
							<fmt:formatNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[1].ps_service_type}&propertyId=${getRanServiceProperties[1].property_service_id}&address=${getRanServiceProperties[1].address}&pname=${getRanServiceProperties[1].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getRanServiceProperties[1].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 개수: ${getRanServiceProperties[1].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[1].property_type_id == 1}">
							                        	<c:if test="${billions > 0}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
							                    </c:when>
							                    <c:when test="${getRanServiceProperties[1].property_type_id == 2}">
							                        <c:if test="${billions_de > 1}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanServiceProperties[1].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getRanServiceProperties[1].deposit} / ${getRanServiceProperties[1].month_price}</h5>
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
							<c:set var="billions" value="${getRanServiceProperties[2].price / 100000000}" />
							<c:set var="millions" value="${(getRanServiceProperties[2].price % 100000000) / 10000}" />
							<fmt:formatNumber var="billionsFormatted" value="${billions}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[2].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[2].deposit)}" />
							<fmt:formatNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
								
								
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[2].ps_service_type}&propertyId=${getRanServiceProperties[2].property_service_id}&address=${getRanServiceProperties[2].address}&pname=${getRanServiceProperties[2].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getRanServiceProperties[2].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getRanServiceProperties[2].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[2].property_type_id == 1}">
							                        	<c:if test="${billions > 1}">
													    <h5 class="Roomprice">매매가 : ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
							                    </c:when>
							                    <c:when test="${getRanServiceProperties[2].property_type_id == 2}">
							                        <c:if test="${billions_de > 1}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanServiceProperties[2].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getRanServiceProperties[2].deposit} / ${getRanServiceProperties[2].month_price}</h5>
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
							
							<c:set var="billions" value="${getRanServiceProperties[3].price / 100000000}" />
							<c:set var="millions" value="${(getRanServiceProperties[3].price % 100000000) / 10000}" />
							<fmt:formatNumber var="billionsFormatted" value="${billions}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted" value="${millions}" pattern="#,##0" />
							
							<c:set var="billions_de" value="${getRanServiceProperties[3].deposit / 10000}" />
							<c:set var="millions_de" value="${(getRanServiceProperties[3].deposit)}" />
							<fmt:formatNumber var="billionsFormatted_de" value="${billions_de}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted_de" value="${millions_de}" pattern="#,##0" />
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[3].ps_service_type}&propertyId=${getRanServiceProperties[3].property_service_id}&address=${getRanServiceProperties[3].address}&pname=${getRanServiceProperties[3].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getRanServiceProperties[3].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getRanServiceProperties[3].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[3].property_type_id == 1}">
							                        	<c:if test="${billions > 0}">
													    <h5 class="Roomprice">매매가  ${billionsFormatted}억 ${millionsFormatted}만원</h5>
														</c:if>
							                    	</c:when>
							                    <c:when test="${getRanServiceProperties[3].property_type_id == 2}">
							                        <c:if test="${billions_de > 1}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de}억 ${millionsFormatted_de}만원</h5>
													</c:if>
													<c:if test="${billions_de < 1 && millions_de > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanServiceProperties[3].property_type_id == 3}">	
														<h5 class="Roomprice3">월세  ${getRanServiceProperties[3].deposit} / ${getRanServiceProperties[3].month_price}</h5>
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
				<h3>혹시 이런 곳은 어떠신가요?(여긴 크롤링)</h3>
				<ul class=RoomList>
					<li>
						<div>
							<a>
							
							<c:set var="billions3" value="${getRanServiceProperties[3].price / 100000000}" />
							<c:set var="millions3" value="${(getRanServiceProperties[3].price % 100000000) / 10000}" />
							<fmt:formatNumber var="billionsFormatted3" value="${billions3}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted3" value="${millions3}" pattern="#,##0" />
							
							<c:set var="billions_de3" value="${getRanServiceProperties[3].deposit / 10000}" />
							<c:set var="millions_de3" value="${(getRanServiceProperties[3].deposit)}" />
							<fmt:formatNumber var="billionsFormatted_de3" value="${billions_de3}" pattern="#,##0" />
							<fmt:formatNumber var="millionsFormatted_de3" value="${millions_de3}" pattern="#,##0" />
							
							
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getRanServiceProperties[3].ps_service_type}&propertyId=${getRanServiceProperties[3].property_service_id}&address=${getRanServiceProperties[3].address}&pname=${getRanServiceProperties[3].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getRanServiceProperties[3].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getRanServiceProperties[3].count}</p>
			                                     <c:choose>
													<c:when test="${getRanServiceProperties[3].property_type_id == 1}">
							                        	<c:if test="${billions3 > 0}">
													    <h5 class="Roomprice">매매가  ${billionsFormatted3}억 ${millionsFormatted3}만원</h5>
														</c:if>
							                    	</c:when>
							                    <c:when test="${getRanServiceProperties[3].property_type_id == 2}">
							                        <c:if test="${billions_de3 > 1}">
												    <h5 class="Roomprice2">전세  ${billionsFormatted_de3}억 ${millionsFormatted_de3}만원</h5>
													</c:if>
													<c:if test="${billions_de3 < 1 && millions_de3 > 0}">
													<h5 class="Roomprice2">전세  ${millionsFormatted_de3}만원</h5>
													</c:if>
								                </c:when>
							                    <c:when test="${getRanServiceProperties[3].property_type_id == 3}">	
														<h5 class="Roomprice3">월세  ${getRanServiceProperties[3].deposit} / ${getRanServiceProperties[3].month_price}</h5>
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
						<div>
							<a>
								
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important;">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getServiceProperties[1].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getServiceProperties[1].count}</p>
			                                    <c:choose>
													<c:when test="${getServiceProperties[1].property_type_id == 1}">
														<h5 class="Roomprice">매매 / ${getServiceProperties[1].price}</h5>
													</c:when>
													<c:when test="${getServiceProperties[1].property_type_id == 2}">
														<h5 class="Roomprice2">전세 / ${getServiceProperties[1].deposit}</h5>
													</c:when>
													<c:when test="${getServiceProperties[1].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getServiceProperties[1].deposit} / ${getServiceProperties[1].month_price}</h5>
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getServiceProperties[1].description}</p>
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
								
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important;">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getServiceProperties[2].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getServiceProperties[2].count}</p>
			                                    <c:choose>
													<c:when test="${getServiceProperties[2].property_type_id == 1}">
														<h5 class="Roomprice">매매 / ${getServiceProperties[2].price}</h5>
														
													</c:when>
													<c:when test="${getServiceProperties[2].property_type_id == 2}">
														<h5 class="Roomprice2">전세 / ${getServiceProperties[2].deposit}</h5>
													</c:when>
													<c:when test="${getServiceProperties[2].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getServiceProperties[2].deposit} / ${getServiceProperties[2].month_price	}</h5>
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getServiceProperties[2].description}</p>
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
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important;">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getServiceProperties[3].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getServiceProperties[3].count}</p>
			                                    <c:choose>
													<c:when test="${getServiceProperties[3].property_type_id == 1}">
														<h5 class="Roomprice">매매 / ${getServiceProperties[3].price}</h5>
													</c:when>
													<c:when test="${getServiceProperties[3].property_type_id == 2}">
														<h5 class="Roomprice2">전세 / ${getServiceProperties[3].deposit}</h5>
													</c:when>
													<c:when test="${getServiceProperties[3].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getServiceProperties[3].deposit} / ${getServiceProperties[3].month_price}</h5>
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getServiceProperties[3].description}</p>
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
		
	</div>
	
	<div class=footer>
		<div class="container" id="footer_con">
		<hr class="hr-solid"/>
			<p id="footer">(주)사방팔방</p>
			<p id="footer">대표: 홍길동</p>
			<p>고객센터: 02-1234-5678 | 평일 10:00 ~ 18:30, 점심시간 : 12:30 ~ 13:30 (토·일요일, 공휴일 휴무)</p>
			<p id="foot1">© 2024 SabangPalbang. All rights reserved.</p>
	    	<p id="foot2">Contact: SabangPalbang@example.com</p>
    	</div>
	</div>
	
	
	
	
	
</body>
</html>