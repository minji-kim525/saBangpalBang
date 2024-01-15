<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아파트 실거래가 비교</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body onload="Graph()">
	<select id="city">
		<option selected disabled>서울특별시</option>
	</select>
	<select id="gu" name="gu" onchange="updateDongList()">
		<option selected>구</option>
		<option value="11110">종로구</option>
		<option value="11140">중구</option>
		<option value="11170">용산구</option>
		<option value="11200">성동구</option>
		<option value="11215">광진구</option>
		<option value="11230">동대문구</option>
		<option value="11260">중랑구</option>
		<option value="11290">성북구</option>
		<option value="11305">강북구</option>
		<option value="11320">도봉구</option>
		<option value="11350">노원구</option>
		<option value="11380">은평구</option>
		<option value="11410">서대문구</option>
		<option value="11440">마포구</option>
		<option value="11470">양천구</option>
		<option value="11500">강서구</option>
		<option value="11530">구로구</option>
		<option value="11545">금천구</option>
		<option value="11560">영등포구</option>
		<option value="11590">동작구</option>
		<option value="11620">관악구</option>
		<option value="11650">서초구</option>
		<option value="11680">강남구</option>
		<option value="11710">송파구</option>
		<option value="11740">강동구</option>
	</select>

	<select id="dong" name="dong" onchange="updateApartmentList()">
		<option selected>동</option>
	</select>

	<!--  구에 따라 동이 바뀌는 스크립트 -->
	<script>
		function updateDongList() {
			var selectedGuCode = document.getElementById("gu").value;
			var dongList = document.getElementById("dong");

			dongList.innerHTML = '<option selected>동</option>';

			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					var data = JSON.parse(xhr.responseText);
					data
							.forEach(function(item) {
								dongList.innerHTML += '<option value="' + selectedGuCode + item.dong_cd + '">'
										+ item.dong + '</option>';
							});
				}
			};

			xhr
					.open("GET", "/getDongsJson?regional_cd=" + selectedGuCode,
							true);
			xhr.send();
		}
	</script>

	<select id="apartment_name" name="apartment_name">
		<option selected disabled>아파트</option>
	</select>
	<button onclick="addApartment()">추가</button>

	<div id="selectedApartments"></div>
	<canvas id="realEstateChart" style="height: 50vh; width: 50vw"></canvas>

	<!-- 동에 따라 아파트 이름이 바뀌는 스크립트 -->
	<script>
		function updateApartmentList() {
			var selectedDongCode = document.getElementById("dong").value;
			var apartmentList = document.getElementById("apartment_name");

			var regionCode = selectedDongCode.slice(0, 5); // 앞 5자리 지역코드
			var dongCode = selectedDongCode.slice(5); // 나머지 부분 동코드

			apartmentList.innerHTML = '<option selected value="">아파트</option>';

			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					var data = JSON.parse(xhr.responseText);

					data
							.forEach(function(item) {
								apartmentList.innerHTML += '<option value="' + selectedDongCode + item.apart_cd + '">'
										+ item.apartment_name + '</option>';
							});
				}
			};
			xhr.open("GET", "/getApartmentsJson?regional_cd=" + regionCode
					+ "&dong_cd=" + dongCode, true);
			xhr.send();
		}

		document.getElementById("apartment_name").addEventListener("change",
				Graph);

		// Graph() 함수 내에서 그래프 생성 코드 추가
		function Graph() {
			var selectedCode = document.getElementById("apartment_name").value;

			// '아파트' 옵션이 선택되지 않았거나 '아파트' 옵션일 경우 함수 실행을 중단
			if (!selectedCode || selectedCode === '아파트') {
				regionCode = '00000';
				dongCode = '00000';
				apartCode = '00000';
			} else {
				regionCode = selectedCode.slice(0, 5); // 지역코드
				dongCode = selectedCode.slice(5, 10); // 동코드
				apartCode = selectedCode.slice(10); // 아파트 코드
			}

			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					var data = JSON.parse(xhr.responseText);

					var chartData = {
						labels : data.map(function(item) {
							return item.deal_year;
						}),
						datasets : [ {
							label : '실거래가 변동 추이 (단위 : 만 원)',
							data : data.map(function(item) {
								return item.deal_amount;
							}),
							borderColor : 'rgb(32,164,132)',
							borderWidth : 1,
							fill : false
						} ]
					};
					createChart(chartData);
				}
			};
			xhr.open("GET", "/transactionJson?regional_cd=" + regionCode
					+ "&dong_cd=" + dongCode + "&apart_cd=" + apartCode, true);
			xhr.send();
		}
		// 그래프를 생성하는 함수
		function createChart(chartData) {
			var ctx = document.getElementById('realEstateChart').getContext(
					'2d');
			var myChart = new Chart(ctx, {
				type : 'line',
				data : chartData,
				options : {
					responsive : false,
					maintainAspectRatio : false,
					scales : {
						y : {
							beginAtZero : true
						}
					}
				}
			});
		}
	</script>
</body>
</html>