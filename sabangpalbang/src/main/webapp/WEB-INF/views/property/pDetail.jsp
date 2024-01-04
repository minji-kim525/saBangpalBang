<!-- searchDetail.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크롤링 매물 상세 정보</title>
</head>
<body>

	<c:forEach var="propertyDetail" items="${detail}">
		<p>매물 ID: ${propertyDetail.property_id}</p>
		<p>주소: ${propertyDetail.address}</p>
		<p>매물명: ${propertyDetail.pname}</p>
		<p>가격: ${propertyDetail.price}</p>
		<p>보증금: ${propertyDetail.deposit}</p>
		<p>면적: ${propertyDetail.feet}</p>
		<p>층수: ${propertyDetail.floor}</p>
		<p>관리비: ${propertyDetail.charge}</p>
		<p>
			등록 날짜:
			<fmt:formatDate value="${propertyDetail.registration_date}"
				pattern="yyyy-MM-dd" />
		</p>
		<p>설명: ${propertyDetail.description}</p>
		<!-- 필요한 다른 속성들도 추가 -->

		<img src="/roomImg/${propertyDetail.images.filename}" alt="">
	</c:forEach>

</body>
</html>
