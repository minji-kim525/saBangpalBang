<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.property.ChargeFunction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회 검색 결과</title>
<style>
.property-container {
	display: flex;
	flex-wrap: wrap;
}

.property {
	margin: 10px;
	text-align: center;
	cursor: pointer;
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
	<h3>'${keyword}'로 검색한 결과입니다.</h3>
	<c:choose>
		<c:when test="${empty allProperties}">
			<p>검색 결과가 없습니다.</p>
		</c:when>
		<c:otherwise>
			<c:forEach var="property" items="${allProperties}">
				<c:choose>
					<c:when test="${property.private_property == true}">
						<p>검색 결과가 없습니다.</p>
					</c:when>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>

	<c:if test="${not empty allProperties}">
		<div class="property-container">
			<c:forEach var="property" items="${allProperties}">
				<c:if test="${property.private_property == false}">
					<%-- <c:forEach var="confirm" items="${confirm}">
						<c:if test="${confirm.confirm_check == 1}"> --%>
					<div class="property"
						onclick="if(${property.ps_service_type} == 1)
                                { location.href='/property/psDetail?ps_service_type=${property.ps_service_type}&propertyId=${property.property_service_id}'; }
                                else if(${property.p_service_type} == 2)
                                { location.href='/property/pDetail?p_service_type=${property.p_service_type}&propertyId=${property.property_id}'; }"
						style="cursor: pointer;">
						<c:if test="${not empty property.imagesList}">
							<img src="/roomImg/${property.imagesList[0].filename}" alt=""
								class="property-image">
						</c:if>
						<br>
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
				<%-- 					</c:forEach>
				</c:if> --%>
			</c:forEach>
		</div>
	</c:if>



</body>
</html>
