<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>1:1 상담 채팅</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        var socket = new WebSocket("ws://localhost:8081/chat");

        socket.onopen = function() {
            console.log("WebSocket 연결 성공");
        }

        socket.onmessage = function(event) {
            var message = event.data;
            var chatBox = document.getElementById("chatBox");
            var messageElement = document.createElement("p");
            messageElement.textContent = "상대방: " + message;
            chatBox.appendChild(messageElement);
        }

        function send() {
            var input = document.getElementById("messageInput");
            var message = input.value;
            socket.send(message);
            input.value = "";
        }
    </script>
</head>
<body>
    <h1>1:1 상담 채팅</h1>
    <div id="chatBox"></div>
    <input type="text" id="messageInput" placeholder="메시지 입력">
    <button onclick="send()">전송</button>
</body>
</html>