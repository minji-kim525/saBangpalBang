<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign Up</title>
</head>
<body>
    <h2>회원가입</h2>
    <form action="/insert" method="post">

        <div>
	            <input type="text" name="id" id="id" placeholder="id"/>
				<button type="button" id="idCheck">아이디중복확인</button>	        
        </div>       
        <div><span id="result_checkId" style="font-size:12px;"></span></div>
        <div>
            <input type="text" name="email" placeholder="*Email"/>
        </div>
        <div>
            <input type="password" name="password" placeholder="Password"/>
        </div>

        <button type="submit" id="btn_id">회원가입</button>
    </form>
</body>
	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){

    $("#idCheck").click(function(){
    
        let id = $("#id").val();
         
        $.ajax({
            type:'post', //post 형식으로 controller 에 보내기위함!!
            url:"/idCheck", // 컨트롤러로 가는 mapping 입력
            dataType: "html", // text로 넘겨주는데 응답을 받는쪽이 json으로 받아서 수정
            data: {"id":id}, 
            success: function(data){ 
                if(data == "N"){ // 만약 성공할시
                    result = "사용 가능한 아이디입니다.";
                    $("#result_checkId").html(result).css("color", "green"); 
                 
             }else{ // 만약 실패할시
                 result="이미 사용중인 아이디입니다.";
                 $("#result_checkId").html(result).css("color","red"); 
             }
                 
         },
         error: function (request, status,error) {
             alert("ajax 실행 실패");
             alert("code:" + request.status + "\n" + "error :" + error);
         }
        });
        
    });
    
});

</script>
</html>