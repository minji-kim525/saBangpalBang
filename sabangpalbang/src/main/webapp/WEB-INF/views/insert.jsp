<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/font.css">
	<link rel="stylesheet" href="/css/insert.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>회원가입</title>
</head>
<body>
    <div class="container">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form class="validation-form" novalidate action="/insert" method="post" name="userInfo" onsubmit="return checkValue()">
          <div class="row">
            <div class="mb-3">
              <label for="name">아이디</label>
              <input type="text" name="id" class="form-control" id="id" placeholder="" value="" required>
              <div class="invalid-feedback">
                아이디를 입력해주세요. 
              </div>	
              <button type="button" class="btn btn-outline-primary" id="idCheck" style="margin-top:5px;">중복확인</button>
			<div><span id="result_checkId" style="font-size:12px;"></span></div>
            </div>
          </div>

   <div class="row">
      <div class="mb-3">
         <label for="password">비밀번호</label> <input type="password"
         class="form-control" name="password" id="password" placeholder="비밀번호를 입력해주세요"
         value="" required>

   </div>
          <div class="mb-3">
            <label for="email">이메일</label>
            <input type="email" name="email" class="form-control" id="email" placeholder="you@example.com" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>

          <hr class="mb-4">
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block" id="formSubmit" type="submit">가입 완료</button>
        </form>
      </div>
</body>
	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<script>

$(function(){
	let idChecked = false; 

    $("#idCheck").click(function(){
    
        let id = $("#id").val();
         
        $.ajax({
            type:'post', //post 형식으로 controller 에 보내기위함!!
            url:"/idCheck", // 컨트롤러로 가는 mapping 입력
            dataType: "html", // text로 넘겨주는데 응답을 받는쪽이 json으로 받아서 수정
            data: {"id":id}, 
            success: function(data){ 
                if(data == "N" && id.length > 0){ // 만약 성공할시
                	idChecked = true;
                    result = "사용 가능한 아이디입니다.";
                    $("#result_checkId").html(result).css("color", "green");
                 
             }else if(data != "N" && id.length > 0){ // 만약 실패할시
                 result="이미 사용중인 아이디입니다.";
                 $("#result_checkId").html(result).css("color","red"); 
             }else {
            	 result = "아이디를 입력해주세요"
            	 $("#result_checkId").html(result).css("color","red"); 	
             }
                 
         },
         error: function () {
             alert("에러 발생");
         }
        });
        
    });
    
    $("#formSubmit").click(function(e){
        if (!idChecked) {
        	Swal.fire({
        	      icon: 'error',
        	      title: '아이디 중복확인을 해주세요.',
        	      text: '아이디 중복확인은 필수입니다.',
        	    });
            e.preventDefault();
            return false;
        }
        else {$("#validation-form").submit();}
    
	});
});


</script>

</html>