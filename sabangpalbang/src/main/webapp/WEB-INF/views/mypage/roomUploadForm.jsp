<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>방 내놓기</title>
</head>
<body>
<h3>방 내놓기</h3>
<form method="post" enctype="multipart/form-data">
	<input type="hidden" name="ps_service_type" value=1>
	주소 : <input type="text" name="address" id="sample4_postcode" placeholder="우편번호"><br>
	<!-- <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
	<input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
	매물유형 : <select  name="property_type_id">
	<option value = "1">매매</option>
	<option value = "2">전세</option>
	<option value = "3">월세</option>
	</select>
	건물명 : <input type="text" name="pname"><br>
	가격 : <input type="number" name="price"><br>
	보증금 : <input type="number" name="deposit"><br>
	평수 : <input type="number" name="feet"><br>
	관리비 : <input type="number" name="charge"><br>
	방 개수 : <input type="number" name="count"><br>
	입주 가능일 : <input type="date" name="move_date"><br>
<!-- 	기타정보 : <input type="text" name="description"><br>
 -->	파일첨부 :<input type="file" name="files" multiple="multiple"><br>
	
	
	
	<input type="submit" value="등록">
	

</form>

</body>
</html>
