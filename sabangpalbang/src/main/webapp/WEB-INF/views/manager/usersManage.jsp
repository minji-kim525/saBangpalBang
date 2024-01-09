<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>사용자 관리</title>
</head>
<body>
<h3>사용자 관리</h3>
<c:if test="${listcheck!=0 }">
            <section>
                <!--/* 검색 */-->
                <div class="search_box">
                    <form action="search" method="get" id="searchForm">
                        <div class="sch_group fl">
                            <select name="searchType">
                                <option value="" ${searchDto.searchType == "" ? 'selected' : ''}>전체 검색</option>
                                <option value="id" ${searchDto.searchType == "id" ? 'selected' : ''}>아이디</option>
                                <option value="email" ${searchDto.searchType == "email" ? 'selected' : ''}>이메일</option>
                            </select>
                            <input type="text" id="keywordForm" name="keyword" placeholder="키워드를 입력해 주세요." title="키워드 입력"  value="${searchDto.keyword}"/>
                            <button type="button" id="search_submit"><span class="skip_info">검색</span></button>
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
                            <th scope="col">아이디</th>
                            <th scope="col">이메일</th>
                        </tr>
                                     
  					</thead>
  					<tbody id="list">
                        <c:forEach items="${list}" var="users" varStatus="i">
						<tr>
							<td scope="col"><a href ="">${pagination.totalRecordCount - ((searchDto.page - 1) * searchDto.recordSize)-i.index}</a></td>
							<td scope="col">${users.id}</td>
							<td scope="col">${users.email}</td>
							<td scope="col">
								<form method="post" id="deleteform" action="/manager/users/search">
									<input type="hidden" name="_method" value="delete">
									<button id="deleteId" name="user_id" value="${users.user_id}" >삭제</button>
								
								</form>
							
							</td>
						</tr>
						</c:forEach>
					 </tbody>
                </table>
 
			 </section>
     <!--/* 페이지네이션 렌더링 영역 */-->
    <div class="paging">
	<jsp:include page="../paging.jsp" flush="true">
	<jsp:param value="${searchDto.searchType}" name="searchType"/>
	<jsp:param value="${searchDto.keyword}" name="searchType"/>
	<jsp:param value="${searchDto.page}" name="page"/>
	<jsp:param value="${pagination.startPage}" name="startPage"/>
	<jsp:param value="${pagination.endPage}" name="endPage"/>
	<jsp:param value="${pagination.existPrevPage}" name="existPrevPage"/>
	<jsp:param value="${pagination.existNextPage}" name="existNextPage"/>
	</jsp:include>
	</div>
</c:if>
<c:if test="${listcheck==0 }">
등록된 사용자가 없습니다.
</c:if>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>


	
	$("#search_submit").click(function(){
	  	  $("#searchForm").submit();
	});
      
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
