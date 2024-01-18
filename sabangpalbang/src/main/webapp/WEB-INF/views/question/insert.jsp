<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>문의작성</title>
</head>
<body>
	<form:form action="/question/insert" method="post" modelAttribute="dto">

		<div>
		<select name="question">
					<option value="" selected >문의사항</option>
					<option value="사기">사기</option>
					<option value="월세/전세/매매">월세/전세/매매</option>
					<option value="지역">지역</option>
					<option value="기타">기타</option>
						</select>
		</div>
		<div>
			제목 <input name="title">
			<form:errors path="title"></form:errors>
		</div>
		<div>
			내용 <input name="content">
			<form:errors path="content"></form:errors>
		</div>
		<div>
		<input type="submit" value="전송">
	</form:form>
	<input type="button" value="취소" onclick="cancelUpdate()">
	</div>
	<script>
		function cancelUpdate() {
			if (confirm('취소하시겠습니까?')) {
				window.history.back();
			}
		}
	</script>	
	
	
	
	<script>
  const selectElement = document.querySelector('select[name="question"]');
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