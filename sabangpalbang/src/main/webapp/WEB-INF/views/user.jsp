<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>시큐리티 테스트</title>
</head>
<body>
	<h1>로그인 성공한 사용자만 접근할 수 있는 화면입니다.</h1>
	email :
	<sec:authentication property="principal.users.email" />
	<a href="/">뒤로 가기</a></body>
</html>