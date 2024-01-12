<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<style>
.card {
 	cursor: pointer;
  position: relative;
  border-bottom: 1px solid #ccc;
  padding: 10px;
  margin-bottom: 10px; 
}
.card:hover {
  background-color: #f5f5f5;
  border-color: #333; 
}
.unread-indicator {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: red;
  position: absolute; /* 상대 위치 지정 */
  top: 10px;
  right: 10px;
}
</style>
</head>
<body>
<h3>알림</h3>
 <c:if test="${listcheck!=0 }">
	<c:forEach items="${list}" var="notify">
	<div class="card" onclick="markAsRead(this, '${notify.notify_id}', '${notify.notify_check}'); if (${notify.question_id != null}) { location.href='/question/${notify.question_id}'; } else { location.href='/property/psDetail?ps_service_type=${notify.ps_service_type}&propertyId=${notify.property_service_id}'; }">
	<input type="hidden" name="notify_id" value="${notify.notify_id}">
	<c:choose>
 				<c:when test="${notify.question_id!=null}">
 					<div id="notify_btn" >
 					<c:if test="${notify.notify_check==0}">
            			<div class="unread-indicator"></div>
        			</c:if>
 					<h4>관리자</h4>
 					<p>${notify.title}에 대한 답변이 완료되었습니다.</p>
 					</div>
				</c:when>
				<c:when test="${notify.confirm_id!=null&&notify.confirm_check==1}">
				 	<div id="notify_btn" >
 					<c:if test="${notify.notify_check==0}">
            			<div class="unread-indicator"></div>
        			</c:if>
 					<h4>관리자</h4>
 					<p>${notify.pname}이 승인되었습니다.</p>
 					</div>
				</c:when>
				<c:when test="${notify.confirm_id!=null&&notify.confirm_check==2}">
				 	<div id="notify_btn" >
 					<c:if test="${notify.notify_check==0}">
            			<div class="unread-indicator"></div>
        			</c:if>
 					<h4>관리자</h4>
 					<p>${notify.pname}이 반려되었습니다.</p>
 					</div>
				</c:when>
		</c:choose>
		
		
	</div>
	</c:forEach>
</c:if>
<c:if test="${listcheck==0 }">
알림이 없습니다.</c:if>
 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function markAsRead(element,notify_id,notify_check) {
    	// 빨간 동그라미 제거
        var indicator = element.querySelector('.unread-indicator');
        if (indicator) {
            indicator.style.display = 'none';
        }
        if(notify_check==0){
        // AJAX 요청 알림 읽음 상태 업데이트
       fetch('/mypage/notify?notify_id=' +notify_id,{
    	   method: 'PUT',
    	    headers: {
    	        'Content-Type': 'application/json'
    	    }
      	 }
        )
        .then(response => response.text())
        .then(data => console.log(data))
        .catch(error => console.error('Error:', error));
       }
    }
    
</script>

</body>
</html>	