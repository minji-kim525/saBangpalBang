<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
글번호:${content.question_id}<br> 작성자:${content.id}<br> 
제목:${content.title}<br> 내용:${content.content}<br>
등록날짜:${content.created_at}<br>
===================답변=========================<br>

<form action="answer/insert" method="post">
<input type="hidden" value="${content.question_id}" name="question_id">
<input type="hidden" value="${content.title}" name="title">
<input type="hidden" value="${content.user_id}" name="user_id">
<input type="text" name="content">
<input type="submit" value="답변하기"/>
</form>


</body>
</html>