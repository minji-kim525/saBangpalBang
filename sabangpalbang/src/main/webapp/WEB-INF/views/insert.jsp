<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>회원 가입</title>
</head>
<body>
	<h3>회원 가입을 환영합니다.</h3>
<form action="insert" method="post" id="joinform">
	<table>
		<tr><td>id</td><td><input name="id" id="id"></td></tr>
		<tr><td>password</td><td><input name="password" type="password" id="password"></td></tr>
		<tr><td>email</td><td><input name="email" id="email"></td></tr>
		
		<tr><td colspan="2"><input type="submit" value="가입"></td></tr>
	</table>
</form>
</body>
</html>