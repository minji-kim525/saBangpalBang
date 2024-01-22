<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Check</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
    
</head>
<body>
<div class="container">
	<div class="input-form col-md-12 mx-auto">
    <h4 class="mb-3" style="margin-top:350px;">비밀번호 인증</h4>
    <form class="validation-form" novalidate action="/delcheck" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div>
            <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요"/>
        </div>

        <hr class="mb-4">
         <div class="mb-4"></div>
         <button class="btn btn-primary btn-lg btn-block">확인</button>
    </form>
    </div>
</div>
    <script type="text/javascript">
	    var msg = '${msg}';
	    if(msg === '비밀번호를 다시 확인해 주세요.') {
	        alert("비밀번호를 다시 확인해 주세요.");
	    }
	</script>
    
</body>

</html>