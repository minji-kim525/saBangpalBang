<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>문의작성</title>
</head>
<body>

	<form method="post">
		<div>
			제목 <input type="text" name="title">
			<form:errors path="title"></form:errors>
		</div>
		<div>
			내용 <input type="text" name="content"> <input type="submit"
				value="전송">
		</div>
	</form>


</body>
</html>