<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회</title>
<script>
	function validateSearch() {
		var keyword = document.getElementById("keyword").value.trim();
		if (keyword === "") {
			alert("검색어를 입력하세요.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<h3>아파트명을 입력하세요</h3>
	<form action="/property/searchAllResult" method="get"
		onsubmit="return validateSearch();">
		검색: <input type="search" name="keyword" id="keyword"> <input type="submit" value="검색">
	</form>
</body>
</html>
