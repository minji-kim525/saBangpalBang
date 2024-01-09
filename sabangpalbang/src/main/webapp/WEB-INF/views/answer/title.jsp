<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${tlist}" var="title">>
글번호:${title.question_id}
작성자:${title.id}
제목:<a href="http://localhost:8081/question/${title.question_id}">${title.title}</a> 
등록날짜:<fmt:formatDate value="${title.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
</c:forEach>
</body>
</html> 