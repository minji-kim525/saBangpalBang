package com.app.websocket;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.app.security.config.SecurityUser;

@Controller
public class WebSocketController {

	@GetMapping("consulting/{id}")
	public String room(@PathVariable(name = "id") String id, @AuthenticationPrincipal SecurityUser user, Model m) {

		m.addAttribute("id", id);
		m.addAttribute("user_id", user.getUsers().getId());
		m.addAttribute("role", user.getUsers().getRole());

		return "consulting/chatroom";
	}

	@GetMapping("consulting")
	public String home(@AuthenticationPrincipal SecurityUser user, Model m) {
		m.addAttribute("id", user.getUsers().getId());
		return "consulting/consulting";
	}

}
