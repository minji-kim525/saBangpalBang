<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회 검색 결과</title>
</head>
<body>

	<c:if test="${empty allProperties}">
		<h3>'${keyword}'로 검색한 결과입니다.</h3>
		<p>검색 결과가 없습니다.</p>
	</c:if>

	<c:if test="${not empty allProperties}">
		<h3>'${keyword}'로 검색한 결과입니다.</h3>
		<c:forEach var="property" items="${allProperties}">
			<td>${property.pname}</td>
			<!-- 추가 필요한 항목들을 추가하세요 -->
		</c:forEach>
	</c:if>
</body>
</html>
