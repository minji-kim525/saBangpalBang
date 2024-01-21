<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${list}" var="title">>
글번호:${title.question_id}
문의사항:${title.question_type}
작성자:${title.id}
제목:<a href="http://localhost:8081/question/${title.question_id}">${title.title}</a> 
등록날짜:<fmt:formatDate value="${title.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
</c:forEach>
	
	<jsp:include page="../paging.jsp" flush="true">
		<jsp:param value="${searchDto.searchType}" name="searchType" />
		<jsp:param value="${searchDto.keyword}" name="searchType" />
		<jsp:param value="${searchDto.page}" name="page" />
		<jsp:param value="${pagination.startPage}" name="startPage" />
		<jsp:param value="${pagination.endPage}" name="endPage" />
		<jsp:param value="${pagination.existPrevPage}" name="existPrevPage" />
		<jsp:param value="${pagination.existNextPage}" name="existNextPage" />
	</jsp:include>

</body>
</html> 