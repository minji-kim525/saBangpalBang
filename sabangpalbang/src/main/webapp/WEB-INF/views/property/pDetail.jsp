<!-- searchDetail.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크롤링 매물 상세 정보</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

	<p>매물 ID: ${pdetail.property_id}</p>
	<p>주소: ${pdetail.address}</p>
	<p>매물명: ${pdetail.pname}</p>
	<c:choose>
		<c:when test="${pdetail.property_type_id == 1}">
			<p>매매가 : ${pdetail.price}</p>
		</c:when>
		<c:when test="${pdetail.property_type_id == 2}">
			<p>보증금: ${pdetail.deposit}</p>
		</c:when>
		<c:when test="${pdetail.property_type_id == 3}">
			<p>월세 : ${pdetail.month_price}</p>
			<p>보증금 : ${pdetail.deposit}</p>
		</c:when>
	</c:choose>
	<p>면적: ${pdetail.feet}</p>
	<p>층수: ${pdetail.floor}</p>
	<p>관리비: ${pdetail.charge}</p>
	<p>
		등록 날짜:
		<fmt:formatDate value="${pdetail.registration_date}"
			pattern="yyyy-MM-dd" />
	</p>
	<p>설명: ${pdetail.description}</p>
	<!-- 필요한 다른 속성들도 추가 -->

	<c:forEach items="${pdetail.images}" var="image">
		<img src="/roomImg/${image.filename}" alt="">
	</c:forEach>
	<%@ include file="chart.jsp"%>
</body>
</html>
