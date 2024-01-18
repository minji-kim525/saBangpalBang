<!-- searchDetail.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크롤링 매물 상세 정보</title>
</head>
<body>

	<p>매물 ID: ${pdetail.property_id}</p>
	<p>주소: ${pdetail.address}</p>
	<p>매물명: ${pdetail.pname}</p>
	<c:choose>
		<c:when test="${pdetail.property_type_id == 1}">
			<p>매매가 : ${pdetail.price}</p>
		</c:when>
		<c:when test="${pdetail.property_type_id == 2}">
			<p>보증금: ${pdetail.deposit}</p>
		</c:when>
		<c:when test="${pdetail.property_type_id == 3}">
			<p>월세 : ${pdetail.month_price}</p>
			<p>보증금 : ${pdetail.deposit}</p>
		</c:when>
	</c:choose>
	<p>면적: ${pdetail.feet}</p>
	<p>층수: ${pdetail.floor}</p>
	<p>관리비: ${pdetail.charge}</p>
	<p>
		등록 날짜:
		<fmt:formatDate value="${pdetail.registration_date}"
			pattern="yyyy-MM-dd" />
	</p>
	<p>설명: ${pdetail.description}</p>

	<div class="modal">
		<div class="modal_body">
			<button type="button" id="telephone">연락처 보기</button>
		</div>
	</div>

	<c:forEach items="${pdetail.images}" var="image">
		<img src="/roomImg/${image.filename}" alt="">
	</c:forEach>

	<!-- 서비스매물 실거래가 그래프 -->
	<div>
		<canvas id="myChart" style="height: 40vh; width: 30vw"></canvas>
	</div>
	<script>
	
function getParameterByName(name) {
	const urlSearchParams = new URLSearchParams(window.location.search);
	return urlSearchParams.get(name);
}
var address = getParameterByName('address');
var pname = getParameterByName('pname');
console.log('address:' +address);
console.log('pname:' + pname);

    fetch('/getTransGraph?address=' + address + '&pname=' + pname)
        .then(response => response.json())
        .then(chartData => {
            console.log('chartData:', chartData);

            var ctx = document.getElementById('myChart').getContext('2d');

            var myChart = new Chart(ctx, {
                type : 'line',
                data : {
                    labels : chartData.map(function(item) {
	                    return item.deal_year;
	                }),
                    datasets : [ {
                        label : '실거래가 변동 그래프( 단위 : 만 원)',
                        data : chartData.map(function(item) {
    	                    return item.deal_amount;
    	                }),
                        backgroundColor : 'rgb(32, 164, 132)',
                        borderWidth : 1
                    } ]
                },
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
        })
        .catch(error => console.error('Error fetching chart data:', error));
</script>
</body>
</html>
