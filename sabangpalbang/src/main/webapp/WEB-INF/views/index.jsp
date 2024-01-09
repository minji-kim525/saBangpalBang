<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>시큐리티 테스트</title>
</head>

<body>
	<h1>인덱스 화면입니다.</h1>
	<sec:authorize access="!isAuthenticated()"> 
		<a href="/login">login</a><br>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()"> 
	<button type="button" onclick="location.href='user'">회원정보</button>
		<button type="button" onclick="location.href='check'">수정하기</button>
		<form action="/logout" method="post">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	        <button type="submit">로그아웃</button>
    	</form>
	</sec:authorize>
	
	
</body>
</html>