package com.app.mypage.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.ConfirmDTO;
import com.app.dto.ImagesDTO;
import com.app.mypage.dao.MypageDao;
import com.app.mypage.dto.UploadRequestDto;

import lombok.Data;

@Service
public class MypageService {
	@Autowired
	MypageDao dao;
	public List<ImagesDTO> uploadImages(UploadRequestDto dto, List<MultipartFile> files, String path) throws IllegalStateException, IOException{ 
		List<ImagesDTO> fileList=new ArrayList<>();
		
		for(MultipartFile file:files) {
			if(!file.isEmpty()) {
				
				String origName=file.getOriginalFilename();
				System.out.println(origName);
				//확장자
				String ext=origName.substring((origName.lastIndexOf(".")+1));
				String uuid = UUID.randomUUID().toString();
				String fileName=uuid+"."+ext;
//				Random r = new Random();
//				String fileName = System.currentTimeMillis() + "_" + r.nextInt(50) + "." + ext;
				File f= new File(path+File.separator+fileName);
				file.transferTo(f);
				fileList.add(new ImagesDTO(fileName,path,dto.getProperty_type_id()));
				
			}
		}
		return fileList;
 }

	public void insertRoom(UploadRequestDto dto, List<ImagesDTO> fileList) {
		dao.insertRoomInfo(dto);
		int id = dto.getProperty_service_id();
		dao.insertFile(fileList,id);
		dao.insertConfirm(new ConfirmDTO(false, id));

	}
	
}
