package com.app.security.controller;

import com.app.security.config.SecurityUser;
import com.app.security.service.UserService;
import com.app.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class SecurityController {
    @Autowired
    private UserService userService;
    
    @Autowired
    PasswordEncoder passwordEncoder;
    
    //메인메뉴
    @GetMapping("/")
	public String index() {
		return "index";
	}
    
    @GetMapping("/admin")
	public String admin() {
		return "admin";
	}
    
    @GetMapping("/accessDenied")
	public String accessdenied() {
		return "accessDenied";
	}
    
    //유저정보
    @GetMapping("/user")
	public String forUser(@AuthenticationPrincipal SecurityUser user, Model model) {
    	model.addAttribute("loginId", user.getUsername());
    	model.addAttribute("loginEmail", user.getUsers().getEmail());
    	return "user";

	}
    
    //유저리스트 -> ADMIN해서 확인해봐야함
    @GetMapping("/userList")
    public String getUserList(Model model) {
        List<UserDTO> userList = userService.getUserList();
        model.addAttribute("list", userList);
        return "userlist";
    }
   
    //로그인
    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "exception", required = false) String exception, Model model) {
    	model.addAttribute("error", error);
        model.addAttribute("exception", exception);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof AnonymousAuthenticationToken)
            return "login";
        return "redirect:/";
    }

    @GetMapping("/insert")
    public String signupPage() {  // 회원 가입 페이지
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof AnonymousAuthenticationToken)
            return "insert";
        return "redirect:/";
    }
    
    @RequestMapping("/idCheck")
    @ResponseBody  
    public String idCheck(@RequestParam(value="id") String id) {
        String result="N";
        //System.out.println("controller id"+id);
        int flag = userService.idCheck(id);
        //System.out.println("flag 값" +flag);
        if(flag == 1) result ="Y"; 
        //아이디가 있을시 Y 없을시 N 으로jsp view 로 보냄
        return result;
    }

    @PostMapping("/insert") // 오류 메세지 추가
    public String signup(UserDTO userVo) { // 회원 가입
        try {
            userService.signup(userVo);
        } catch (DuplicateKeyException e) {
            return "redirect:/insert?error_code=-1";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/insert?error_code=-99";
        }
        return "redirect:/login";
    }
    
    @GetMapping("/check")
    public String pwcheckPage() { // 비밀번호 확인
    	return "pwcheck";
    }
    
    @PostMapping("/check")
    public String pwcheck(@AuthenticationPrincipal SecurityUser user,@RequestParam("password")String pw,RedirectAttributes rttr,Model model) {
        String userpw = user.getUsers().getPassword();
        if(passwordEncoder.matches(pw, userpw)) {
            return "redirect:/update";
        }
        else {
            rttr.addFlashAttribute("msg", "비밀번호를 다시 확인해 주세요.");
            return "redirect:/";
        }
    	
    	
    }
    
    @GetMapping("/delcheck")
    public String delcheckPage() {	// 아이디 삭제 시 비밀번호 확인
    	return "delcheck";
    }
    
    @PostMapping("/delcheck")
    public String delcheck(@AuthenticationPrincipal SecurityUser user,@RequestParam("password")String pw,RedirectAttributes rttr,Model model) {
        String userpw = user.getUsers().getPassword();
        if(passwordEncoder.matches(pw, userpw)) {
            
        	return "redirect:/delete";
        }
        else {
            rttr.addFlashAttribute("msg", "비밀번호를 다시 확인해 주세요.");
            return "redirect:/";
        }
    	
    	
    }
    
    

    @GetMapping("/update")
    public String editPage(@AuthenticationPrincipal SecurityUser user, Model model) { // 회원 정보 수정 페이지
        UserDTO userVo = user.getUsers();
        model.addAttribute("user", userVo);
        return "editpage";
    }

    @PostMapping("/update")
    public String edit(@AuthenticationPrincipal SecurityUser user, UserDTO userVo) { // 회원 정보 수정
    	userService.edit( userVo,user.getUsers().getId());   	
        return "redirect:/";
    }
    
    @GetMapping("/delete")
    public String deletePage() {
    	return "delete";
    }

    @PostMapping("/delete")
    public String withdraw(HttpSession session) { // 회원 탈퇴
    	Authentication loggedInUser = SecurityContextHolder.getContext().getAuthentication();
    	String id= loggedInUser.getName();     
    	if (id != null) {
            userService.withdraw(id);
            session.invalidate();
        }
    	
    	SecurityContextHolder.clearContext(); // SecurityContextHolder에 남아있는 token 삭제
        return "redirect:/";
    }
    
    
}