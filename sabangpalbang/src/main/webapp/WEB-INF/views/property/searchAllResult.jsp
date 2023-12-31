<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회 검색결과</title>
</head>
<body>
	<h3>검색 결과입니다.</h3>

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>



<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회 검색결과</title>
</head>
<body>

	<c:choose>
		<c:when test="${not empty getallProperties}">
			<h3>'${keyword}'로 검색한 결과입니다.</h3>
			<c:forEach var="property" items="${getallProperties}">
				<p>${property.pname}</p>
				<!-- 다른 필요한 정보들 표시 -->
				
			</c:forEach>
		</c:when>
		<c:otherwise>
			<p>검색 결과가 없습니다.</p>
		</c:otherwise>
	</c:choose>
	
</body>
</html>
</body>
</html>