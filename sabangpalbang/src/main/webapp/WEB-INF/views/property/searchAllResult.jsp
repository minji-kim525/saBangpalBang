<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.property.ChargeFunction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물 전체조회 검색 결과</title>
</head>
<body>

	<c:if test="${empty allProperties}">
		<h3>'${keyword}'로 검색한 결과입니다.</h3>
		<p>검색 결과가 없습니다.</p>
	</c:if>

	<c:if test="${not empty allProperties}">
		<h3>'${keyword}'로 검색한 결과입니다.</h3>
		<table>
			<tbody>
				<c:forEach var="property" items="${allProperties}">
					<tr
						onclick="location.href='/property/searchDetail?keyword=${keyword}'"
						style="cursor: pointer;">

						<td><c:choose>
								<c:when test="${property.property_type_id == 1}">
									<h3>매매</h3>
								</c:when>
								<c:when test="${property.property_type_id == 2}">
									<h3>전세</h3>
								</c:when>
								<c:when test="${property.property_type_id == 3}">
									<h3>월세</h3>
								</c:when>
							</c:choose>
							<h3>${chargeFunction.formatNumberWithUnit(property.price)}</h3>
							${property.pname}<br></td>
						<!-- 줄바꿈 왜이래진짜 -->
						<!-- 다른 속성에 대한 추가 테이블 셀 추가 -->
						<!-- ImagesDTO 객체의 필드를 통해 이미지 URL을 가져옴 -->
						<img src="/roomimg/${property.images.filename}" alt="Property Image">
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>


</body>
</html>
