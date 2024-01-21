<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<c:forEach items="${list}" var="title" varStatus="i">
글번호:${pagination.totalRecordCount - ((searchDto.page - 1) * searchDto.recordSize)-i.index}
문의사항:${title.question_type}
작성자:${title.id}
제목:<a href="${title.question_id}">${title.title}</a> 
등록날짜:<fmt:formatDate value="${title.created_at}"
			pattern="yyyy-MM-dd HH:mm:ss" />
		<c:if test="${title.answer_id != 0}">(답변완료)</c:if>
		<br>
	</c:forEach>
	<a href="http://localhost:8081/question/insert">글쓰기</a>


	<div class="search_box">
		<form action="title" method="get" id="searchForm">
			<div class="sch_group fl">
				<select name="searchType">
					<option value="" ${searchDto.searchType == "" ? 'selected' : ''}>전체
						검색</option>
					<option value="writer"
						${searchDto.searchType == "writer" ? 'selected' : ''}>작성자</option>
					<option value="name"
						${searchDto.searchType == "name" ? 'selected' : ''}>제목</option>
				</select> <input type="text" id="keywordForm" name="keyword"
					placeholder="키워드를 입력해 주세요." title="키워드 입력"
					value="${searchDto.keyword}" />
				<button type="button" id="search_submit">
					<span class="skip_info">검색</span>
				</button>
			</div>
		</form>
	</div>
	<jsp:include page="../paging.jsp" flush="true">
		<jsp:param value="${searchDto.searchType}" name="searchType" />
		<jsp:param value="${searchDto.keyword}" name="searchType" />
		<jsp:param value="${searchDto.page}" name="page" />
		<jsp:param value="${pagination.startPage}" name="startPage" />
		<jsp:param value="${pagination.endPage}" name="endPage" />
		<jsp:param value="${pagination.existPrevPage}" name="existPrevPage" />
		<jsp:param value="${pagination.existNextPage}" name="existNextPage" />
	</jsp:include>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$("#search_submit").click(function() {
			$("#searchForm").submit();
		});
	</script>



</body>
</html>