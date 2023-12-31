<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회</title>
</head>
<body>
	<h3>아파트 또는 오피스텔명을 입력하세요</h3>
	<form action="/property/searchAllResult" method="get">
		검색 : <input type="search" name="keyword"> <input type="submit"
			value="검색">
	</form>
</body>
</html>