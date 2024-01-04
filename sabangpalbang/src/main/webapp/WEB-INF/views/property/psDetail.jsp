<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서비스 매물 상세정보</title>
</head>
<body>

	<c:forEach var="propertyServiceDetail" items="${psdetail}">
		<c:if
			test="${propertyServiceDetail.property_service_id == param.propertyId}">
			<p>주소: ${propertyServiceDetail.address}</p>
			<p>건물명: ${propertyServiceDetail.pname}</p>
			<p>가격: ${propertyServiceDetail.price}</p>
			<p>보증금: ${propertyServiceDetail.deposit}</p>
			<p>평수: ${propertyServiceDetail.feet}</p>
			<p>층수: ${propertyServiceDetail.floor}</p>
			<p>관리비: ${propertyServiceDetail.charge}</p>
			<p>방 개수: ${propertyServiceDetail.count}</p>
			<p>
				등록 날짜:
				<fmt:formatDate value="${propertyServiceDetail.registration_date}"
					pattern="yyyy-MM-dd" />
			</p>
			<p>설명: ${propertyServiceDetail.description}</p>
			<!-- 필요한 다른 속성들도 추가 -->

			<img src="/roomImg/${propertyServiceDetail.images.filename}" alt="">
		</c:if>
	</c:forEach>

</body>
</html>
