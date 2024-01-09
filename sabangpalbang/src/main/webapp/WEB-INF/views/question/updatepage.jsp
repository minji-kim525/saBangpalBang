<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>


<form action="updatepage" method="post">
  <input type="text" value="${content.title}" name="title">
  <input type="text" value="${content.content}" name="content">
  <input type="hidden" value="${content.question_id}" name="question_id">
  <input type="submit" value="수정" onclick="if(!confirm('해당내용으로 수정하시겠습니까?')){return false;}" />

</form>





</body>
</html>