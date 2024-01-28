<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="/css/font.css">

</head>
<body>
<div id="paging" style="text-align:center;">
<c:choose><c:when test="${param.searchType==null&&param.keyword==null}"><c:url var="action" value="${requestScope['javax.servlet.forward.servlet_path']}?searchType=&keyword=&deal=1&jeonse=1&wolse=1&dealAmount=0만원+-+무제한&jeonseAmount=0만원+-+무제한&wolseAmount=0만원+-+무제한&feetAmount=0평+-+무제한&"/></c:when>
<c:otherwise><c:url var="action" value="${requestScope['javax.servlet.forward.servlet_path']}?searchType=${param.searchType}&keyword=${param.keyword}&deal=${param.deal}&jeonse=${param.jeonse}&wolse=${param.wolse}&dealAmount=${param.dealAmount}&jeonseAmount=${param.jeonseAmount}&wolseAmount=${param.wolseAmount}&feetAmount=${param.feetAmount}&"/></c:otherwise>
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