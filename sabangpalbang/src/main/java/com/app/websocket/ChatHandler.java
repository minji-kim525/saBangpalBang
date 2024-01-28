package com.app.websocket;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler {

	 private Set<WebSocketSession> sessions = new HashSet<>();

	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	        sessions.add(session);
	    }

	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	        String payload = message.getPayload();
	        
	        // 모든 세션에게 메시지 전송
	        for (WebSocketSession s : sessions) {
	                s.sendMessage(message);
	            }
	        }
	    

	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	        sessions.remove(session);
	    }
  

}