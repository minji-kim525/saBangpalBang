<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
	<title>회원 탈퇴</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/font.css">
	
</head>
<body>
	<h1>회원 탈퇴</h1>

	<form action="/delete" method="post">
        <button type="submit">탈퇴하기</button>
    </form>
</html>