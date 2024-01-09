<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>매물 관리</title>
</head>
<body>
<h3>매물 관리</h3>
<c:if test="${listcheck!=0 }">
        <div class="content">
            <section>
                <!--/* 검색 */-->
                <div class="search_box">
                    <form action>
                        <div class="sch_group fl">
                            <select title="검색 유형 선택">
                                <option value="">전체 검색</option>
                                <option value="">작성자</option>
                                <option value="">건물명</option>
                                <option value="">주소</option>
                            </select>
                            <input type="text" placeholder="키워드를 입력해 주세요." title="키워드 입력"/>
                            <button type="button" class="bt_search"><i class="fas fa-search"></i><span class="skip_info">검색</span></button>
                        </div>
                    </form>
                </div>

                <!--/* 리스트 */-->
                <table class="tb tb_col">
                   <%--  <colgroup style="border: 1px solid black;">
                        <col style="width:50px;"/><col style="width:7.5%;"/><col style="width:auto;"/><col style="width:10%;"/><col style="width:15%;"/><col style="width:7.5%;"/>
                    </colgroup> --%>
                    <thead>
                        <tr>
<!--                             <th scope="col"><input type="checkbox"/></th>
 -->                        <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일</th>
                        </tr>
                                     
  					</thead>
  					<tbody id="list">
                        <c:forEach items="${list}" var="property">
						<tr>
							<td scope="col"><a href ="">${property.property_service_id}</a></td>
							<td scope="col"><c:choose>
								<c:when test="${property.property_type_id==1}">
									매매
								</c:when>
								<c:when test="${property.property_type_id==2}">
								전세
								</c:when>
								<c:when test="${property.property_type_id==2}">
								월세
								</c:when>
								</c:choose>
							${property.pname}/주소:${property.address}</td>
							<td scope="col">${property.id}</td>
							<td scope="col"><fmt:formatDate value="${property.registration_date }" dateStyle="short"/> </td>
							<td scope="col">
								<form method="post" id="deleteform" action="/manager/property">
									<input type="hidden" name="_method" value="delete">
									<input type="hidden" name="property_service_id" value="${property.property_service_id}">									
									<button id="chagePrivate" >삭제</button>
								
								</form>
							
							</td>
						</tr>
						</c:forEach>
					 </tbody>
                </table>
			 </section>
        </div> 
                  
</c:if>
<c:if test="${listcheck==0 }">
등록된 매물이 없습니다.
</c:if>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
      
      $("#deleteform").click(function(){
    	  if (confirm("정말 삭제하시겠습니까?") == true){    //확인
        	  $("#deleteform").submit();
    		 }else{   //취소
    		     return false;
    		 }
    	  
      });

  </script>

</body>
</html>