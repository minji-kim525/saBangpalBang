<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<c:if test="${content.title == null}">
<% response.sendRedirect("title"); %>
</c:if>
글번호:${content.question_id}<br> 작성자:${content.id}<br> 
제목:${content.title}<br> 내용:${content.content}<br>
등록날짜:<fmt:formatDate value="${content.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/><br>

<c:if test="${content.id == id || role == 'ADMIN'}">
<form action="delete/${content.question_id}" method="post">
<input type="submit" value="삭제" onclick="if(!confirm('정말로 삭제하시겠습니까?')){return false;}" />
</form>
<form action="update" method="post">
<input type="hidden" value="${content.question_id}" name="question_id">
<input type="submit" value="수정" onclick="if(!confirm('수정하시겠습니까?')){return false;}" />
</form>
</c:if>

=================답변===============================================<br>



<c:if test="${count != 0}">
<c:forEach items="${alist}" var="alist">
운영자답변 : ${alist.content}<br>
등록날짜 : <fmt:formatDate value="${alist.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
<c:if test="${role == 'ADMIN'}">
<form action="answer/updatepage" method="post">
<input type="hidden" value="${content.question_id}" name="question_id">
<input type="hidden" value="${alist.answer_id}" name="answer_id">
<input type="hidden" value="${alist.content}" name="content">
<input type="submit" value="답변수정">
</form>
<form action="answerdelete" method="post">
<input type="hidden" value="${alist.answer_id}" name="answer_id">
<input type="hidden" value="${content.question_id}" name="question_id">
<input type="submit" value="삭제" onclick="if(!confirm('정말로 삭제하시겠습니까?')){return false;}">
</form>
</c:if>
</c:forEach>
</c:if>
<c:if test="${role == 'ADMIN' and count == 0}">
<form action="answer" method="post">
<input type="hidden" value="${content.question_id}" name="question_id">
<input type="hidden" value="${content.title}" name="title">
<input type="hidden" value="${content.user_id}" name="user_id">
<input type="submit" value="답변하기"/>
</form>
</c:if>
</body>
</html>