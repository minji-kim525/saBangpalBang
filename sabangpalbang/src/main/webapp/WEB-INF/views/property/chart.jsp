<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Line Chart Test</title>
<!-- Include Chart.js library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
#lineChart {
	width: 400px;
	height: 400px;
}
</style>
</head>
<body>
	<canvas id="lineChart" style="height:50vh; width:50vw"></canvas>
	<script>
        var chartData = ${chart};

        var labels = chartData.map(item => item.deal_year);
        var values = chartData.map(item => item.deal_amount);

        var ctx = document.getElementById('lineChart').getContext('2d');
        var lineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: '거래 금액',
                    borderColor: 'blue',
                    data: values
                }]
            }
        });
        options: {
			responsive: false}
    </script>
</body>
</html>
