<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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


<form action="update" method="post">
<input type="text" value="${answer}" name="content">
<form:errors path="content"></form:errors>
<input type="hidden" value="${answer_id}" name="answer_id">
<input type="hidden" value="${question_id}" name="question_id">
<input type="submit" value="답변하기"/>
</form>

</body>
</html>