package com.app.mypage.contorller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.ImagesDTO;
import com.app.mypage.dto.MyUploadResponseDto;
import com.app.mypage.dto.UploadRequestDto;
import com.app.mypage.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MypageController {

	@Autowired
	MypageService service;
    //나의 방 조회
	@GetMapping("/mypage/myupload/{user_id}")
	public String getMyUpload(@PathVariable("user_id") int user_id,Model model){
		List<MyUploadResponseDto> list=service.getMyUploadAll(user_id);
		if(!list.isEmpty()) {
			model.addAttribute("list",list);
			System.out.println(list);
		}else {
			model.addAttribute("listcheck",0);
		}
		return "mypage/myupload";
	}

	//방 업로드 폼
	@GetMapping("mypage/upload")
	public String form() {
		System.out.println("업로드폼");

		return "mypage/roomUploadForm";
	}
	
    //방업로드
	@PostMapping("mypage/upload")
	public String upload( UploadRequestDto uploadRequestDto,HttpServletRequest request) throws IllegalStateException,IOException {
		List<MultipartFile>files=uploadRequestDto.getFiles();
//		String path=request.getServletContext().getRealPath("/roomImg");
		String path = request.getServletContext().getRealPath("/roomImg");
		//ServletContext객체란? 프로젝트의 context 정보(path 등)를 가지고 있는 객체. Path(지정)

		System.out.println(path);	

		List<ImagesDTO> fileList=service.uploadImages(uploadRequestDto,files, path);
		service.insertRoom(uploadRequestDto,fileList);

		return "mypage/result";
	}
	
	@PutMapping("mypage/myupload/{user_id}")
	public String updatePrivate(@RequestParam(value="property_service_id") int property_service_id,@PathVariable("user_id")int user_id) {
		 service.updatePrivate(property_service_id,user_id);
		 return "redirect:/mypage/myupload/1";
	}
}
