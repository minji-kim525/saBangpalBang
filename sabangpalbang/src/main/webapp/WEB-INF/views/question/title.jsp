<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
등록날짜:<fmt:formatDate value="${title.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/>

<c:if test="${title.answer_id != 0}">(답변완료)</c:if><br>
</c:forEach>
<a href="http://localhost:8081/question/insert">글쓰기</a>

<form action="search" method="get">
<select id="mySelect" onchange="updateInputName()">
  <option value="title" selected>제목</option>
  <option value="id" >작성자</option>
</select>
<input type="text" id="myInput"> <input type="submit" value="검색">
</form>
<script>
  function updateInputName() {
    var selectElement = document.getElementById("mySelect");
    var inputElement = document.getElementById("myInput");
    var selectedValue = selectElement.value;
    inputElement.name = selectedValue;
  }
</script>


</body>
</html>