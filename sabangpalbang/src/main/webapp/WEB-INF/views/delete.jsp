<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>회원 탈퇴</title>
</head>
<body>
	<h1>회원 탈퇴</h1>

	<form action="/delete" method="post">
        <button type="submit">탈퇴하기</button>
    </form>
</html>