<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<div id="paging">
<c:choose><c:when test="${param.searchType==null&&param.searchType==null}"><c:url var="action" value="${requestScope['javax.servlet.forward.servlet_path']}?"/></c:when>
<c:otherwise><c:url var="action" value="${requestScope['javax.servlet.forward.servlet_path']}?searchType=${param.searchType}&keyword=${param.keyword}&"/></c:otherwise>
</c:choose>
<c:if test="${param.existPrevPage}">
    <a href="${action}page=${param.startPage-1}">prev</a>
</c:if>
<c:forEach begin="${param.startPage}" end="${param.endPage}" step="1" var="index">
<c:choose><c:when test="${param.page==index}">${index}</c:when><c:otherwise><a href="${action}page=${index}">${index}</a></c:otherwise></c:choose>
</c:forEach>
<c:if test="${param.existNextPage}">
    <a href="${action}page=${param.endPage+1}">next</a>
</c:if>
</div>
</body>
</html>