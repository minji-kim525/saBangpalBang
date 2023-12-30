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

    <c:if test="${empty allProperties}">
        <p>검색 결과가 없습니다.</p>
    </c:if>
   
</body>
</html>