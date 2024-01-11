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

	<p>주소: ${psdetail.address}</p>
	<p>건물명: ${psdetail.pname}</p>
	<c:choose>
		<c:when test="${psdetail.property_type_id == 1}">
			<p>매매가 : ${psdetail.price}</p>
		</c:when>
		<c:when test="${psdetail.property_type_id == 2}">
			<p>보증금: ${psdetail.deposit}</p>
		</c:when>
		<c:when test="${psdetail.property_type_id == 3}">
			<p>월세 : ${psdetail.month_price}</p>
			<p>보증금 : ${psdetail.deposit}</p>
		</c:when>
	</c:choose>
	<p>평수: ${psdetail.feet}</p>
	<p>층수: ${psdetail.floor}</p>
	<p>관리비: ${psdetail.charge}</p>
	<p>방 개수: ${psdetail.count}</p>
	<p>
		등록 날짜:
		<fmt:formatDate value="${psdetail.registration_date}"
			pattern="yyyy-MM-dd" />
	</p>
	<p>설명: ${psdetail.description}</p>
	<!-- 필요한 다른 속성들도 추가 -->

	<c:forEach items="${psdetail.images}" var="image">
		<img src="/roomImg/${image.filename}" alt="">
	</c:forEach>

</body>
</html>
