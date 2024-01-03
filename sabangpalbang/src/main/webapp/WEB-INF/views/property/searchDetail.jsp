<!-- searchDetail.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.app.property.dto.PropertyDetailDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 상세 정보</title>
</head>
<body>

	<p>주소: ${detail.address}</p>
	<p>매물명: ${detail.pname}</p>
	<p>가격: ${detail.price}</p>
	<!-- 기타 상세 정보 출력 -->

</body>
</html>
