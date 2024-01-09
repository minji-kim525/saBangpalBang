<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modify Information</title>
</head>
<body>
    <h2>회원 정보 수정</h2>
    <form action="/update" method="post">
    	
        <p style="display:none">	
            id<br>
            <input type="text" name="id" value="${user.id}"   />
        </p>
        <p>
            Email<br>
            <input type="text" name="email" value="${user.email}"/>
        </p>
        <p>
            현재 비밀번호<br>
            <input type="password" name="password" placeholder="현재 비밀번호"/>
        </p>
        <tr>
            <td>새 비밀번호</td>
            <td><input type="password" id="newpassword" name="newpassword" placeholder="새 비밀번호"/></td>
        </tr>
        <tr>
            <td>비밀번호 확인</td>
            <td>
	            <input type="password" id="cfpassword" name="cfpassword" placeholder="비밀번호 확인" onKeyUp="fn_compare_pwd();"/>
	            <span id="result" style="font-size: 12px;">비밀번호가 일치하지 않습니다.</span>
	        </td>
        </tr>
        
        <button type="submit">저장하기</button>
    </form>
</body>

<script type="text/javascript">
var compare_result = false;
	function fn_compare_pwd(){
		var pwd1 = document.getElementById('newpassword');
		var pwd2 = document.getElementById('cfpassword');	
		var result = document.getElementById('result');	
	             
		if(pwd1.value == pwd2.value){
			compare_result = true;
			result.innerHTML = "비밀번호 일치";
			return;
		}	
	    else{       
			compare_result = false;
	 		result.innerHTML = "비밀번호가 일치하지 않습니다";
	 	}
	}

</script>
</html>