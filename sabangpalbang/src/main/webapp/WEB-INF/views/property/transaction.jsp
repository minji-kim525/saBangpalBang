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

	<!--  아파트 1 -->
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
	<select id="apartment_name" name="apartment_name">
		<option selected disabled>아파트</option>
	</select>

	<!--  아파트 2-->
	<div>
		<select id="city2">
			<option selected disabled>서울특별시</option>
		</select> <select id="gu2" name="gu2" onchange="updateDongList2()">
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
		</select> <select id="dong2" name="dong2" onchange="updateApartmentList2()">
			<option selected>동</option>
		</select> <select id="apartment_name2" name="apartment_name2">
			<option selected disabled>아파트</option>
		</select>
	</div>

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

		//2
		function updateDongList2() {
			var selectedGuCode2 = document.getElementById("gu2").value;
			var dongList2 = document.getElementById("dong2");

			dongList2.innerHTML = '<option selected>동</option>';

			var xhr2 = new XMLHttpRequest();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState === 4 && xhr2.status === 200) {
					var data2 = JSON.parse(xhr2.responseText);
					data2
							.forEach(function(item) {
								dongList2.innerHTML += '<option value="' + selectedGuCode2 + item.dong_cd + '">'
										+ item.dong + '</option>';
							});
				}
			};

			xhr2.open("GET", "/getDongsJson?regional_cd=" + selectedGuCode2,
					true);
			xhr2.send();
		}
	</script>

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

		//2
		function updateApartmentList2() {
			var selectedDongCode2 = document.getElementById("dong2").value;
			var apartmentList2 = document.getElementById("apartment_name2");

			var regionCode2 = selectedDongCode2.slice(0, 5); // 앞 5자리 지역코드
			var dongCode2 = selectedDongCode2.slice(5); // 나머지 부분 동코드

			apartmentList2.innerHTML = '<option selected value="">아파트</option>';

			var xhr2 = new XMLHttpRequest();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState === 4 && xhr2.status === 200) {
					var data2 = JSON.parse(xhr2.responseText);

					data2
							.forEach(function(item) {
								apartmentList2.innerHTML += '<option value="' + selectedDongCode2 + item.apart_cd + '">'
										+ item.apartment_name + '</option>';
							});
				}
			};
			xhr2.open("GET", "/getApartmentsJson?regional_cd=" + regionCode2
					+ "&dong_cd=" + dongCode2, true);
			xhr2.send();
		}

		// Graph() 함수 내에서 그래프 생성 코드 추가
		function Graph() {
			var selectedCode = document.getElementById("apartment_name").value;
			var selectedCode2 = document.getElementById("apartment_name2").value;

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
			if (!selectedCode2 || selectedCode2 === '아파트') {
				regionCode2 = '00000';
				dongCode2 = '00000';
				apartCode2 = '00000';
			} else {
				regionCode2 = selectedCode2.slice(0, 5); // 지역코드
				dongCode2 = selectedCode2.slice(5, 10); // 동코드
				apartCode2 = selectedCode2.slice(10); // 아파트 코드
			}

			var existingChart = Chart.getChart("realEstateChart");
		    if (existingChart) {
		        existingChart.destroy();
		    }

		    // 첫 번째 아파트와 두 번째 아파트의 데이터를 병렬로 로드합니다.
		    var xhr = new XMLHttpRequest();
		    var xhr2 = new XMLHttpRequest();

		    xhr.onreadystatechange = handleResponse;
		    xhr2.onreadystatechange = handleResponse;

		    function handleResponse() {
		        if (xhr.readyState === 4 && xhr.status === 200 && xhr2.readyState === 4 && xhr2.status === 200) {
		            var data = JSON.parse(xhr.responseText);
		            var data2 = JSON.parse(xhr2.responseText);

		            var chartData = {
		                labels: data.map(function(item) {
		                    return item.deal_year;
		                }),
		                datasets: [{
		                    label: data[0]?.apartment_name + ' (단위 : 만 원)',
		                    data: data.map(function(item) {
		                        return item.deal_amount;
		                    }),
		                    borderColor: 'rgb(32,164,132)',
		                    borderWidth: 1,
		                    fill: false
		                }]
		            };

		            if (data2.length > 0) {
		                chartData.datasets.push({
		                    label: data2[0]?.apartment_name + ' (단위 : 만 원)',
		                    data: data2.map(function(item) {
		                        return item.deal_amount;
		                    }),
		                    borderColor: 'rgb(82,33,163)',
		                    borderWidth: 1,
		                    fill: false
		                });
		            }

		            createChart(chartData);
		        }
		    }

		    xhr.open("GET", "/transactionJson?regional_cd=" + regionCode + "&dong_cd=" + dongCode + "&apart_cd=" + apartCode, true);
		    xhr.send();

		    // 두 번째 아파트에 대한 데이터를 로드합니다.
		    if (selectedCode2 && selectedCode2 !== '아파트') {
		        xhr2.open("GET", "/transactionJson?regional_cd=" + regionCode2 + "&dong_cd=" + dongCode2 + "&apart_cd=" + apartCode2, true);
		        xhr2.send();
		    }
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