<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>

<body>
  <div id="view-container"></div>

  <div id="pagination">
    <ul id="page-numbers"></ul>
  </div>

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

    // 한 페이지에 보여줄 아이템 개수
    var itemsPerPage = 3;
    // 현재 페이지 번호
    var currentPage = 1;

    // 페이지 번호에 따라 데이터를 나누고, 해당 페이지의 아이템만 보여주는 함수
    function showItemsByPage(page) {
      // 뷰 컨테이너 초기화
      var viewContainer = document.getElementById("view-container");
      viewContainer.innerHTML = "";

      // 페이지에 해당하는 아이템의 시작 인덱스와 끝 인덱스 계산
      var startIndex = (page - 1) * itemsPerPage;
      var endIndex = startIndex + itemsPerPage;

      // 계산된 인덱스 범위에 해당하는 아이템만 뷰에 추가
      for (var i = startIndex; i < endIndex && i < savedData.length; i++) {
        var data = savedData[i];
        var item = document.createElement("div");

        // 이미지 표시를 위한 <img> 태그 추가
        var imageLink = document.createElement("a");
        imageLink.href =
          "http://localhost:8081/property/psDetail?ps_service_type=" +
          data.property_type_id +
          "&propertyId=" +
          data.propertyId +
          "&address=" +
          data.address +
          "&pname=" +
          data.pname; // 페이지 URL에 질문 ID를 추가하여 동적으로 링크 생성
        var image = document.createElement("img");
        image.src = data.image;
        imageLink.appendChild(image);
        item.appendChild(imageLink);
        viewContainer.appendChild(item);

        var text = document.createElement("p");

        // 매물 이름에 링크 추가
        var nameLink = document.createElement("a");
        nameLink.href =
          "http://localhost:8081/property/psDetail?ps_service_type=" +
          data.property_type_id +
          "&propertyId=" +
          data.propertyId +
          "&address=" +
          data.address +
          "&pname=" +
          data.pname; // 페이지 URL에 질문 ID를 추가하여 동적으로 링크 생성
        nameLink.textContent =
          "매물 이름: " + data.pname + "\n" + "가격: " + data.price;
        text.appendChild(nameLink);

        item.appendChild(text);

        viewContainer.appendChild(item);
      }
    }

    // 초기 페이지 로딩 시 첫 페이지 아이템 보여주기
    showItemsByPage(currentPage);

    // 페이지 번호 목록 생성 함수
    function createPageNumbers() {
      var totalPages = Math.ceil(savedData.length / itemsPerPage);
      var pageNumbersList = document.getElementById("page-numbers");
      pageNumbersList.innerHTML = "";

      // 각 페이지 번호를 리스트 아이템으로 추가
      for (var i = 1; i <= totalPages; i++) {
        var pageNumberItem = document.createElement("li");
        pageNumberItem.textContent = i;
        pageNumberItem.addEventListener("click", function () {
          var pageNumber = parseInt(this.textContent);
          currentPage = pageNumber;
          showItemsByPage(currentPage);
          updatePageNumbers();
        });
        pageNumbersList.appendChild(pageNumberItem);
      }
    }

    // 페이지 번호 업데이트 함수
    function updatePageNumbers() {
      var pageNumbers = document.querySelectorAll("#page-numbers li");
      pageNumbers.forEach(function (pageNumber) {
        pageNumber.classList.remove("active");
        if (parseInt(pageNumber.textContent) === currentPage) {
          pageNumber.classList.add("active");
        }
      });
    }

    // 초기 페이지 로딩 시 페이지 번호 목록 생성
    createPageNumbers();

    // 초기 페이지 로딩 시 페이지 번호 스타일링
    updatePageNumbers();
  </script>
</body>

</html>