<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/login.css">

<title>시큐리티 테스트</title>
</head>

<body class="text-center">
   <main class="form-signin">
      <form action="/login" method="post">
         <img class="mb-4" src="/icon/logo.png" alt="" width="72" height="57">
         <h1 class="h3 mb-3 fw-normal">로그인 페이지</h1>
         
         <div class="form-floating">
            <input type="text" name="username" class="form-control" id="id" placeholder="아이디 입력...">
            <label for="id">아이디</label>
         </div>
         <div class="form-floating">
            <input type="password" name="password" class="form-control" id="pwd" placeholder="Password">
            <label for="pwd">비밀번호</label>
         </div>

         <button class="w-100 btn btn-lg btn-primary" type="submit" style="margin-bottom:10px;">로그인</button>
         <input class="w-100 btn btn-lg btn-primary" type="button" value="가입" onclick="location.href='/insert'" />
         <p class="mt-5 mb-3 text-muted">&copy; 2023–2024</p>
      </form>
   </main>
</body>
</html>
