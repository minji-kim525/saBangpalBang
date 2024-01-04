<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.property.ChargeFunction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인에서의 매물</title>
<style>
.property-container {
	display: flex;
	flex-wrap: wrap;
}

.property {
	margin: 10px;
	text-align: center;
}

.property-type {
	font-size: 1.3em;
	font-weight: bold;
	margin-bottom: 5px;
}

.price {
	font-size: 1.3em;
	font-weight: bold;
	margin-bottom: 5px;
}

.pname {
	display: block;
	font-size: 1.1em;
	margin-top: 10px;
	margin-bottom: 10px;
}

.property-image {
	max-width: 100%;
	height: auto;
	margin-bottom: 5px;
}
</style>
</head>
<body>
	<p>크롤링 매물</p>
	<div class="property-container">
		<c:forEach var="property" items="${getProperties}">
			<c:if test="${property.p_service_type == 2}">
				<div class="property"
					onclick="location.href='/property/psDetail?p_service_type=${property.p_service_type}&propertyId=${property.property_service_id}';"
					style="cursor: pointer;">
					<img src="/roomImg/${property.images.filename}" alt=""><br>
					<c:choose>
						<c:when test="${property.property_type_id == 1}">
							<span class="property-type">매매</span>
						</c:when>
						<c:when test="${property.property_type_id == 2}">
							<span class="property-type">전세</span>
						</c:when>
						<c:when test="${property.property_type_id == 3}">
							<span class="property-type">월세</span>
						</c:when>
					</c:choose>
					<span class="price">${ChargeFunction.formatNumberWithUnit(property.price)}</span>
					<span class="pname">${property.pname}</span>
				</div>
			</c:if>
		</c:forEach>
	</div>
	<br>

	<p>서비스 매물</p>
	<div class="property-container">
		<c:forEach var="propertyService" items="${getServiceProperties}">
			<c:if test="${propertyService.ps_service_type == 1}">
				<div class="property"
					onclick="location.href='/property/psDetail?p_service_type=${propertyService.ps_service_type}&propertyId=${propertyService.property_service_id}';"
					style="cursor: pointer;">
					<img src="/roomImg/${propertyService.images.filename}" alt=""><br>
					<c:choose>
						<c:when test="${propertyService.property_type_id == 1}">
							<span class="property-type">매매</span>
						</c:when>
						<c:when test="${propertyService.property_type_id == 2}">
							<span class="property-type">전세</span>
						</c:when>
						<c:when test="${propertyService.property_type_id == 3}">
							<span class="property-type">월세</span>
						</c:when>
					</c:choose>
					<span class="price">${ChargeFunction.formatNumberWithUnit(propertyService.price)}</span>
					<span class="pname">${propertyService.pname}</span>
				</div>
			</c:if>
		</c:forEach>
	</div>

</body>
</html>
