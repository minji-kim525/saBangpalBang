<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서비스 매물 상세정보</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

	<p>주소: ${psdetail.address}</p>
	<p>건물명: ${psdetail.pname}</p>
	<c:choose>
		<c:when test="${psdetail.property_type_id == 1}">
			<p>매매가 : ${psdetail.price}</p>
		</c:when>
		<c:when test="${psdetail.property_type_id == 2}">
			<p>보증금: ${psdetail.deposit}</p>
		</c:when>
		<c:when test="${psdetail.property_type_id == 3}">
			<p>월세 : ${psdetail.month_price}</p>
			<p>보증금 : ${psdetail.deposit}</p>
		</c:when>
	</c:choose>
	<p>평수: ${psdetail.feet}</p>
	<p>층수: ${psdetail.floor}</p>
	<p>관리비: ${psdetail.charge}</p>
	<p>방 개수: ${psdetail.count}</p>
	<p>
		등록 날짜:
		<fmt:formatDate value="${psdetail.registration_date}"
			pattern="yyyy-MM-dd" />
	</p>
	<p>설명: ${psdetail.description}</p>
	<!-- 필요한 다른 속성들도 추가 -->
	<c:forEach items="${psdetail.images}" var="image">
		<img src="/roomImg/${image.filename}" alt="">
	</c:forEach>

<!-- 로컬스토리지 저장  -->
	<script>
 // 로컬 스토리지에 데이터를 저장하는 함수
 function saveDataToLocalStorage(data) {
   // 기존에 저장된 데이터 가져오기
   var savedData = JSON.parse(localStorage.getItem('user:${id}'));

   // 기존에 저장된 데이터가 없는 경우 새로운 배열 생성
   if (!savedData) {
     savedData = [];
   }
   
   // 중복 값을 제거하고 새로운 값이 들어오면 최신 값으로 업데이트
   var updatedData = savedData.filter(function(item) {
     return item.propertyId !== data.propertyId;
   });
   updatedData.unshift(data);

// 배열을 문자열로 변환하여 로컬 스토리지에 저장
   localStorage.setItem('user:${id}', JSON.stringify(updatedData));
 }
 
 // 이미지 파일 경로 생성 함수
 function getImageFilePaths() {
   var imageFilePaths = [];
   <c:forEach items="${psdetail.images}" var="image">
     var imagePath = "/roomImg/" + "${image.filename}";
     imageFilePaths.push(imagePath);
   </c:forEach>
   return imageFilePaths;
 }

</script>
<script>
  // content.question_id와 content.title을 로컬 스토리지에 저장
  var dataToSave = {
    propertyId: ${propertyId},
    price: ${psdetail.price},
    pname: "${psdetail.pname}",
    property_type_id: ${psdetail.property_type_id},
    address: "${psdetail.address}",
    image: getImageFilePaths()
  };
  saveDataToLocalStorage(dataToSave);
</script>


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
