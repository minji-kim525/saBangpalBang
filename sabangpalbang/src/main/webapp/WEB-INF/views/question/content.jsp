<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

글번호:${content.question_id} 작성자:${content.id} 
제목:${content.title} 등록날짜:${content.created_at}
내용:${content.content}<br>

<form method="post">
<input type="submit" value="삭제" onclick="if(!confirm('정말로 삭제하시겠습니까?')){return false;}" />
</form>
<script>
function delOk(){
    if(!confirm('삭제하시면 복구할수 없습니다. \n 정말로 삭제하시겠습니까??')){
        return false;
    }
}
</script>








</body>
</html>