<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>


	<form action="updatepage" method="post">
		<div>
			<select name="question_type">
				<option value="">문의사항</option>
				<option value="사기">사기</option>
				<option value="월세/전세/매매">월세/전세/매매</option>
				<option value="지역">지역</option>
				<option value="기타">기타</option>
			</select>
		</div>
		<input type="text" value="${content.title}" name="title"> <input
			type="text" value="${content.content}" name="content"> <input
			type="hidden" value="${content.question_id}" name="question_id">
		<input type="submit" value="수정"
			onclick="if(!confirm('해당내용으로 수정하시겠습니까?')){return false;}" />
	</form>
	<input type="button" value="취소" onclick="cancelUpdate()">
	
	<script>
		function cancelUpdate() {
			if (confirm('취소하시겠습니까?')) {
				window.history.back();
			}
		}
	</script>	
	
	<script>
  const selectElement = document.querySelector('select[name="question_type"]');
  const submitButton = document.querySelector('input[type="submit"]');
  
  submitButton.addEventListener('click', function(event) {
    if (selectElement.value === '') {
      event.preventDefault(); // 기본 동작인 폼 제출을 막습니다.
      alert('문의사항을 선택해주세요.');
    }
  });
</script>




</body>
</html>