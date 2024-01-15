<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chartP</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<div>
		<canvas id="myChart" style="height: 50vh; width: 30vw"></canvas>
	</div>
	<script>
		function getParameterByName(name) {
			const urlSearchParams = new URLSearchParams(window.location.search);
			return urlSearchParams.get(name);
		}
		// property_service_id 파라미터 추출
		var propertyId = getParameterByName('propertyId');
		// ps_service_type 파라미터 추출
		var pServiceType = getParameterByName('p_service_type');
		console.log('propertyId:' + propertyId);
		console.log('pServiceType:' + pServiceType);
	</script>

</body>
</html>
