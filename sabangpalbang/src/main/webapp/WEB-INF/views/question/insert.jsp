<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>문의작성</title>
</head>
<body>
<form:form action="/question/insert" method="post" modelAttribute="dto">
		<div>
			제목 <input name="title">
			<form:errors path="title"></form:errors>
		</div>
		<div>
			내용 <input name="content"> 
			<form:errors path="content"></form:errors>
			<input type="submit" value="전송">
		</div>
	</form>
</form:form>

</body>
</html>