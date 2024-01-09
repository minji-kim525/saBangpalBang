<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${tlist}" var="title">
글번호:${title.question_id}
작성자:${title.id}
제목:<a href="${title.question_id}">${title.title}</a> 
등록날짜:${title.created_at}<br>

</c:forEach>


</body>
</html>