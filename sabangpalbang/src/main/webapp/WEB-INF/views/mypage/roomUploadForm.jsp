<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>방 내놓기</title>
</head>
<body>
<h3>방 내놓기</h3>
<form method="post" enctype="multipart/form-data" id="allsubmit">
	<input type="hidden" name="ps_service_type" value=1>
	<div>주소 : <input type="text" name="address" id="sample4_postcode" placeholder="우편번호">
	</div>
	
	<!-- <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
	<input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
	<div>매물유형 : <select  name="property_type_id" onchange="show_form(this.value)">
	<option value = "1">매매</option>
	<option value = "2">전세</option>
	<option value = "3">월세</option>
	</select>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		function show_form(select_btn){
		  if(select_btn == "1") {
		    $("#price").show();
		    $("#price input").prop('disabled', false); // 매매가 입력란 활성화

		    $("#deposit, #month_price").hide();
		    $("#deposit input, #month_price input").val('').prop('disabled', true); // 전세, 월세 입력란 비활성화 및 비우기
		  } else if(select_btn=="2") {
			  $("#price,#month_price").hide();
			  $("#price input, #month_price input").val('').prop('disabled', true); // 매매가 입력란 비활성화 및 비우기

			  $("#deposit").show();
			  $("#deposit input").prop('disabled', false); // 전세 입력란 활성화
		
			}else{
				$("#price").hide();
			    $("#price input").val('').prop('disabled', true); // 매매가 입력란 비활성화 및 비우기

			    $("#deposit, #month_price").show();
			    $("#deposit input, #month_price input").prop('disabled', false); // 전세, 월세 입력란 활성화
			}
		}
		
		$(document).ready(function() {
		    // 초기에 숨김 상태 설정
		    $("#deposit").hide();
		    $("#month_price").hide();
		});
		
		
	</script>
	
	<div>건물명 : <input type="text" name="pname"></div>
	<div id="price">매매가 : <input type="number" name="price"/></div>
	<div id="deposit">보증금 : <input type="number" name="deposit"></div>
	<div id="month_price">월세 : <input type="number" name="month_price"></div>
	
	<div>평수 : <input type="number" name="feet" ></div>
	
	<div>층 : <input type="number" name="floor"></div>
	
	
	<div>관리비 : <input type="number" name="charge" ></div>
	

	<div>방 개수 : <input type="number" name="count" ></div>
	

	<div>입주 가능일 : <input type="date" name="move_date" ></div>
	
	
	<div>상세 설명 : <input type="text" name="description"></div>
	<div>연락처 : <input type="text" name="telephone" ></div>
	

	<div>파일첨부 :<input type="file" name="files" multiple="multiple" ></div>

	
	
	
	
	<input type="button" value="등록" id="submit_form">
	</form>
	
	<script>
		$("#submit_form").click(function() {
				if (confirm("해당 게시물을 등록 하시겠습니까?") == true) { //확인
					$("#allsubmit").submit();
				} else { //취소
					return false;
				}

			});
	
	</script>

</body>
</html>
