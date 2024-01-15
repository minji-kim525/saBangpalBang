<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chartPs</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div>
		<canvas id="myChart" style="height: 50vh; width: 20vw"></canvas>
	</div>
	<script>
		function getParameterByName(name) {
			const urlSearchParams = new URLSearchParams(window.location.search);
			return urlSearchParams.get(name);
		}
		// property_service_id 파라미터 추출
		var propertyId = getParameterByName('propertyId');
		// ps_service_type 파라미터 추출
		var psServiceType = getParameterByName('ps_service_type');
		console.log('propertyId:', propertyId);
		console.log('ps_service_type:', psServiceType);

		document.addEventListener("DOMContentLoaded", function() {
			var propertyId = getParameterByName('propertyId');
			var psServiceType = getParameterByName('ps_service_type');
			console.log('propertyId:', propertyId);
			console.log('ps_service_type:', psServiceType);

			var xhr = new XMLHttpRequest();
			xhr.open('GET', '/property/psDetailJson?propertyId=' + propertyId
					+ '&ps_service_type=' + psServiceType, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var response = JSON.parse(xhr.responseText);
						var address = response.address;
						var pname = response.pname;
						console.log('address:', address);
						console.log('pname:', pname);

						var queryXhr = new XMLHttpRequest();
						queryXhr.open('POST', '/property/psApartJson?address='
								+ address + '&pname=' + pname, true);
						queryXhr.onreadystatechange = function() {
							if (queryXhr.readyState == 4
									&& queryXhr.status == 200) {
								var queryResponse = JSON
										.parse(queryXhr.responseText);
								console.log('Additional query response:',
										queryResponse);
							}
						};
						queryXhr.send();
					}
				}
			};
			xhr.send();
		});

		function sendAddressAndPName(address, pname) {
			var xhr = new XMLHttpRequest();
			xhr.open('POST', '/property/psDetailJson', true);
			xhr.setRequestHeader('Content-Type',
					'application/json;charset=UTF-8');

			// JSON 형식으로 데이터 생성
			var requestData = {
				address : address,
				pname : pname
			};

			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					// 처리 완료 후 동작
					console.log(xhr.responseText);
				}
			};

			xhr.send(JSON.stringify(requestData));
		}

		// 차트 생성 함수
		function createChart(data) {
			const ctx = document.getElementById('myChart');

			new Chart(ctx, {
				type : 'line',
				data : {
					labels : [ 'Red', 'Blue', 'Yellow', 'Green', 'Purple',
							'Orange' ],
					datasets : [ {
						label : '# of Votes',
						data : [ 12, 19, 3, 5, 2, 3 ],
						borderColor : 'rgb(32,164,132)',
						borderWidth : 1
					} ]
				},
				options : {
					responsive : false,
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
