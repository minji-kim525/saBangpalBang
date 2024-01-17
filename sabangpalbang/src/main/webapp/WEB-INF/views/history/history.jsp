<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<div id="view-container"></div>

<script>
// 로컬 스토리지에서 데이터를 가져오는 함수
function getDataFromLocalStorage() {
  // 저장된 데이터 가져오기
  var savedDataString = localStorage.getItem('user:${id}');

  // 저장된 데이터가 없는 경우 빈 배열 반환
  if (!savedDataString) {
    return [];
  }

  // 문자열로 저장된 데이터를 객체로 변환하여 반환
  return JSON.parse(savedDataString);
}

// 로컬 스토리지에서 데이터 가져오기
var savedData = getDataFromLocalStorage();

// 뷰로 출력
var viewContainer = document.getElementById("view-container");
for (var i = 0; i < savedData.length; i++) {
  var data = savedData[i];
  var item = document.createElement("div");
  
  // 이미지 표시를 위한 <img> 태그 추가
  var imageLink = document.createElement("a");
  imageLink.href = "http://localhost:8081/property/psDetail?ps_service_type=" + data.property_type_id +"&propertyId=" + data.propertyId; // 페이지 URL에 질문 ID를 추가하여 동적으로 링크 생성
  var image = document.createElement("img");
  image.src = data.image;
  imageLink.appendChild(image);
  item.appendChild(imageLink); 
  viewContainer.appendChild(item);
  
var text = document.createElement("p");
  
  // 매물 이름에 링크 추가
  var nameLink = document.createElement("a");
  nameLink.href = "http://localhost:8081/property/psDetail?ps_service_type=" + data.property_type_id +"&propertyId=" + data.propertyId; // 페이지 URL에 질문 ID를 추가하여 동적으로 링크 생성
  nameLink.textContent = "매물 이름: " + data.pname +  '\n' + "가격: " + data.price;
  text.appendChild(nameLink);
  
  item.appendChild(text);

  viewContainer.appendChild(item);
}
</script>




 
</body>
</html>