<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=yl1aqr3ar8"></script>
</head>
<style>
	*{
		padding: 0;
		margin: 0;
	}
	
	#header {
		width:100vw;
		height:15vh;
		background-color:blue;
	}
	
	#search {
		width:15vw; 
		height:90vh; 
		background-color:red;
		float:left;
	}
	
	#search_menu {
		width:15vw;
		height:7vh;
		background-color:purple;
	}
	
	#search_filter {
		float:left;
		width:85vw; 
		height:7vh; 
		background-color:green;
	}
	
	#map {
		float:left;
		width:85vw;
		height:80vh;
	}
	
	#footer {
		float:left;
		width:100vw;
		height:10vh;
		background-color:yellow;
	}
</style>
<body>
<div id="header">
</div>
<div id=container>
	<div id="search">
		<div id="search_menu"></div>
	</div>
	<div id="search_filter"></div>
	<div id="map"></div>
</div>
<div id="footer"></div>
<script>
//지도를 삽입할 HTML 요소 또는 HTML 요소의 id를 지정합니다.
var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

//옵션 없이 지도 객체를 생성하면 서울 시청을 중심으로 하는 16 레벨의 지도가 생성됩니다.
var map = new naver.maps.Map(mapDiv);
</script>
</body>
</html>