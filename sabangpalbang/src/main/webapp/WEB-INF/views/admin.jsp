<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>시큐리티 테스트</title>
</head>

<body>
	<h1>Admin 권한을 가진 사용자를 위한 화면입니다.</h1>
	로그인 id :
	<sec:authentication property="principal.users.id" />
	<br>
	
	<a href="/">뒤로 가기</a></body>
</body>
</html>