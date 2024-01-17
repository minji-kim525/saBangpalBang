<%@ page  isELIgnored="false" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
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
	
	<div class=main>
		<div class=container>
			<h2>어떤 방을 찾으세요?</h2>
			<form action="/property/searchAllResult" method="GET" style="top:60px; position:relative;">
			    <div class="mx-auto mt-5 search-bar input-group mb-3">	
			      <input name="keyword" id="keyword" type="search" class="form-control rounded-pill" placeholder="찾아보고 싶은 지역이나 단지명을 입력하세요." 
			      aria-label="Recipient's username" aria-describedby="button-addon2" 
			      style="height:45px; width:100%; position:relative; text-indent:60px;">
			      <a href="/" style="color:inherit;" >
				      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi-search" viewBox="0 0 16 16" style="z-index:3;">
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
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getServiceProperties[0].ps_service_type}&propertyId=${getServiceProperties[0].property_service_id}&address=${getServiceProperties[0].address}&pname=${getServiceProperties[0].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getServiceProperties[0].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;"> 
			                                <div class="text-center">  
			                                    <p class="Roomtype">방 개수: ${getServiceProperties[0].count}</p>
			                                    <c:choose>
													<c:when test="${getServiceProperties[0].property_type_id == 1}">
														<h5 class="Roomprice">매매 / ${getServiceProperties[0].price}</h5>
													</c:when>
													<c:when test="${getServiceProperties[0].property_type_id == 2}">
														<h5 class="Roomprice2">전세 / ${getServiceProperties[0].deposit}</h5>
													</c:when>
													<c:when test="${getServiceProperties[0].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getServiceProperties[0].deposit} / ${getServiceProperties[0].month_price}</h5>
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getServiceProperties[0].description}</p>
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
								
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getServiceProperties[1].ps_service_type}&propertyId=${getServiceProperties[1].property_service_id}&address=${getServiceProperties[1].address}&pname=${getServiceProperties[1].pname}'; }">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getServiceProperties[1].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 개수: ${getServiceProperties[1].count}</p>
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
								
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getServiceProperties[2].ps_service_type}&propertyId=${getServiceProperties[2].property_service_id}&address=${getServiceProperties[2].address}&pname=${getServiceProperties[2].pname}'; }">
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
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important; cursor:pointer" 
								onclick="{ location.href='/property/psDetail?ps_service_type=${getServiceProperties[3].ps_service_type}&propertyId=${getServiceProperties[3].property_service_id}&address=${getServiceProperties[3].address}&pname=${getServiceProperties[3].pname}'; }">
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
		<section class=recommend_property2>
			<div>
				<h3>혹시 이런 곳은 어떠신가요?(여긴 크롤링)</h3>
				<ul class=RoomList>
					<li>
						<div>
							<a>
								<div class="col mb-5" style="width:280px; height:308px; margin-bottom:0!important;">
			                        <div class="card h-100">
			                        <img class="card-img-top" src="/roomImg/${getServiceProperties[0].images.filename}" alt="..." style="width:280px; height:186px;"/>
			                        <div class="card-body p-4" style="padding: 0!important;">
			                                <div class="text-center">
			                                    <p class="Roomtype">방 갯수: ${getServiceProperties[0].count}</p>
			                                    <c:choose>
													<c:when test="${getServiceProperties[0].property_type_id == 1}">
														<h5 class="Roomprice">매매 / ${getServiceProperties[0].price}</h5>
													</c:when>
													<c:when test="${getServiceProperties[0].property_type_id == 2}">
														<h5 class="Roomprice2">전세 / ${getServiceProperties[0].deposit}</h5>
													</c:when>
													<c:when test="${getServiceProperties[0].property_type_id == 3}">
														<h5 class="Roomprice3">월세  ${getServiceProperties[0].deposit} / ${getServiceProperties[0].month_price}</h5>
													</c:when>
												</c:choose>
			                                    <p class="Roominfo">${getServiceProperties[0].description}</p>
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
		<p>© 2024 SabangPalbang. All rights reserved.</p>
    	<p>Contact: info@example.com</p>
	</div>
	
	
	
	
	
</body>
</html>