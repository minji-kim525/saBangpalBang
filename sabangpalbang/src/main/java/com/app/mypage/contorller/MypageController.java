package com.app.mypage.contorller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.app.dto.ImagesDTO;
import com.app.mypage.dto.UploadRequestDto;
import com.app.mypage.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MypageController {

	@Autowired
	MypageService service;

//	@GetMapping("/deletefile/{fileid}")
//	public String deletefile(@PathVariable("fileid") int id, HttpServletRequest request) {
//		FileinfoDto dto = service.fileOne(id);
//		String path = request.getServletContext().getRealPath("/mainImg");
//	
//		File file = new File(path, dto.getPath());
//		
//		if(file.exists()) {
//			file.delete();// 업로드 된 파일 삭제
//		}
//		service.deleteFile(id);
//		
//		return "redirect:/list";
//		
//	}
//	

	@Controller
	public class MypageContorller {

	}

//	@GetMapping("/list")
//	public String list(Model m) {
//		List<FileinfoDto> fList = service.fileList();
//		m.addAttribute("fList", fList);
//		return "file/list";
//	}

	@GetMapping("mypage/upload")
	public String form() {
		System.out.println("업로드폼");

		return "mypage/roomUploadForm";
	}

	@PostMapping("mypage/upload")
	private String upload(UploadRequestDto uploadRequestDto, HttpServletRequest request)
			throws IllegalStateException, IOException {
		List<MultipartFile> files = uploadRequestDto.getFiles();
//		String path=request.getServletContext().getRealPath("/roomImg");
		String webPath = "WEB-INF/roomImg";
		String path = request.getSession().getServletContext().getRealPath(webPath);
		// ServletContext객체란? 프로젝트의 context정보(path 등)를 가지고 있는 객체. Path(지정)

		System.out.println(path);

		List<ImagesDTO> fileList = service.uploadImages(uploadRequestDto, files, path);
		service.insertRoom(uploadRequestDto, fileList);

		return "mypage/result";
	}
}