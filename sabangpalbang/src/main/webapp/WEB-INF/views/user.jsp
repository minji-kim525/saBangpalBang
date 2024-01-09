<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>시큐리티 테스트</title>
</head>
<body>
	<h1>로그인 성공한 사용자만 접근할 수 있는 화면입니다.</h1>
	
	<p>
		Id = ${loginId}
	</p>
	<p>
		Email = ${loginEmail}
	</p>

	<a href="/">뒤로 가기</a></body>
	
	<form action="/logout" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit">로그아웃</button>
    </form>
	
	
	<button type="button" onclick="location.href='delcheck'">탈퇴하기</button>
</html>