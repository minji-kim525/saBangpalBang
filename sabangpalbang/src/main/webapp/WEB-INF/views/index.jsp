<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>시큐리티 테스트</title>
</head>

<body>
	<h1>인덱스 화면입니다.</h1>
	<h5>수정이된걸까요</h5>
	<sec:authorize access="!isAuthenticated()"> 
		<a href="/login">login</a><br>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()"> 
		<a href="#" onclick="document.getElementById('logout').submit();">logout</a><br>
	</sec:authorize>
	
	<form id="logout" action="/logout" method="POST">
	   <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
	</form>
	
</body>
</html>