<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Check</title>
</head>
<body>
    <h2>비밀번호인증</h2>
    <form action="/delcheck" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div>
            <input type="password" name="password" placeholder="비밀번호를 입력하세요"/>
        </div>

        <button type="submit">확인</button>
    </form>
    <script type="text/javascript">
	    var msg = '${msg}';
	    if(msg === '비밀번호를 다시 확인해 주세요.') {
	        alert("비밀번호를 다시 확인해 주세요.");
	    }
	</script>
    
</body>

</html>