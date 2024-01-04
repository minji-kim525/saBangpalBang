package com.app.mypage.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.ImagesDTO;
import com.app.dto.LikeListDTO;
import com.app.mypage.dao.MypageDao;
import com.app.mypage.dto.MyUploadResponseDto;
import com.app.mypage.dto.UploadAndQuestionDto;
import com.app.mypage.dto.UploadRequestDto;
import com.app.question.dto.titleDto;

@Service
public class MypageService {
	@Autowired
	MypageDao dao;
	//다중 이미지 경로 저장
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

	// 방 업로드
	@Transactional
	public void insertRoom(int user_id, UploadRequestDto dto, List<ImagesDTO> fileList) {
		dto.setUser_id(user_id);
		dao.insertRoomInfo(dto);
		int id = dto.getProperty_service_id();
		dao.insertFile(fileList,id);
		dao.insertConfirm(id);

	}
	
	//나의 방조회 
	public UploadAndQuestionDto getMyUploadAll(int user_id){
		List<MyUploadResponseDto> list = dao.getMyUploadAll(user_id);
		for (MyUploadResponseDto myUploadResponseDto : list) {
			int id=myUploadResponseDto.getProperty_service_id();
			int ps_type=myUploadResponseDto.getPs_service_type();
			ImagesDTO img=dao.getImage(id,ps_type);
			myUploadResponseDto.setImages(img);
		}
		List<titleDto>qlist=dao.myQuestionList(user_id);
		UploadAndQuestionDto uploadAndQuestionDto= new UploadAndQuestionDto(list,qlist);
		return uploadAndQuestionDto;
	}
	
	//비공개 설정
	public int updatePrivate(int property_service_id,int user_id) {
		return dao.updatePrivate(property_service_id,user_id);
	}

	
	//찜목록
	public List<MyUploadResponseDto> getMyLikeList(int user_id) {
		List<MyUploadResponseDto> list = dao.getMyLikeList(user_id);
		for (MyUploadResponseDto myUploadResponseDto : list) {
			int id=myUploadResponseDto.getProperty_service_id();
			int ps_type=myUploadResponseDto.getPs_service_type();
			ImagesDTO img=dao.getImage(id,ps_type);
			myUploadResponseDto.setImages(img);
		}
		return list;
	}
	
	//찜하기
	public void insertLikeList(LikeListDTO likeListDto, int user_id) {
		likeListDto.setUser_id(user_id);
		dao.insertLikeList(likeListDto);		
	}
}
