package com.app.mypage.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.ImagesDTO;
import com.app.dto.LikeListDTO;
import com.app.mypage.dto.MyUploadResponseDto;
import com.app.mypage.dto.NotifyResponseDto;
import com.app.mypage.dto.UploadAndQuestionDto;
import com.app.mypage.dto.UploadRequestDto;
import com.app.mypage.service.MypageService;
import com.app.property.dto.PropertyResultDTO;
import com.app.security.config.SecurityUser;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MypageController {

	@Autowired
	MypageService service;
    //나의 방 조회 및 나의 문의 조회
	@GetMapping("/mypage/myupload")
	public String getMyUpload(@AuthenticationPrincipal SecurityUser user,Model model){
		model.addAttribute("loginId", user.getUsername());
    	model.addAttribute("loginEmail", user.getUsers().getEmail());
		UploadAndQuestionDto list=service.getMyUploadAll(user.getUsers().getUser_id());
		if(!list.getList().isEmpty()) {
			model.addAttribute("list",list.getList());
		}else {
			model.addAttribute("listcheck",0);
		}
		if(!list.getQlist().isEmpty()) {
			model.addAttribute("qlist",list.getQlist());
		}else {
			model.addAttribute("qlistcheck",0);
		}
		System.out.println(list);
		return "mypage/myupload";
	}

	//방 업로드 폼
	@GetMapping("mypage/upload")
	public String form( @AuthenticationPrincipal SecurityUser user) {

		if(user.getUsers().getId().isEmpty())
		{
			throw new IllegalArgumentException("접근 권한이 없습니다.");

		}
		return "mypage/roomUploadForm";
	}
	
    //방업로드
	@PostMapping("mypage/upload")
	public String upload( @AuthenticationPrincipal SecurityUser user, UploadRequestDto uploadRequestDto,HttpServletRequest request) throws IllegalStateException,IOException {
		
		List<MultipartFile>files=uploadRequestDto.getFiles();
//		String path=request.getServletContext().getRealPath("/roomImg");
		String path = request.getServletContext().getRealPath("/roomImg");
		//ServletContext객체란? 프로젝트의 context 정보(path 등)를 가지고 있는 객체. Path(지정)
		List<ImagesDTO> fileList=service.uploadImages(uploadRequestDto,files, path);
		service.insertRoom(user.getUsers().getUser_id(),uploadRequestDto,fileList);

		return "redirect:/mypage/myupload";
	}
	//비공개전환
	@PutMapping("mypage/myupload")
	public String updatePrivate(@AuthenticationPrincipal SecurityUser user,@RequestParam(value="property_service_id") int property_service_id) {
		 service.updatePrivate(property_service_id,user.getUsers().getUser_id());
		 return "redirect:/mypage/myupload";
	}
	//찜하기(상세보기에서)
	@PostMapping("/")
	public String insertLikeList(LikeListDTO likeListDto, @AuthenticationPrincipal SecurityUser user) {
		service.insertLikeList(likeListDto,user.getUsers().getUser_id());
		return "redirect:/";
	}
	
//	public String 
	//찜목록
	@GetMapping("/mypage/likelist")
	public String getMyLikeList(@AuthenticationPrincipal SecurityUser user,Model model) {
		model.addAttribute("loginId", user.getUsername());
    	model.addAttribute("loginEmail", user.getUsers().getEmail());
		List<PropertyResultDTO> likelist =service.getMyLikeList(user.getUsers().getUser_id());
		if(!likelist.isEmpty()) {
			model.addAttribute("likelist",likelist);
		}else {
			model.addAttribute("listcheck",0);
		}
		return "mypage/likelist";
		
	}
	
//	//알림확인
	@GetMapping("/mypage/notify")
	public String getNotify(@AuthenticationPrincipal SecurityUser user,Model model) {
		List<NotifyResponseDto>list=service.getNotify(user.getUsers().getUser_id());
		model.addAttribute("loginId", user.getUsername());
    	model.addAttribute("loginEmail", user.getUsers().getEmail());
		if(!list.isEmpty()) {
			model.addAttribute("list",list);
		}else {
			model.addAttribute("listcheck",0);
		}
		return "/mypage/notify";
	}
	
	//알림상태업데이트
	@PutMapping("/mypage/notify")
	@ResponseBody
	public String updateNotifyStatus(@RequestParam("notify_id") int notify_id) {
		service.updateNotifyStatus(notify_id);
		return "status updated";
	}
	
}