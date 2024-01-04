package com.app.property.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.ImagesDTO;
import com.app.dto.PropertyDTO;
import com.app.mypage.dto.UploadRequestDto;
import com.app.property.dao.SearchAllDAO;
import com.app.property.dto.PropertyResultDTO;

@Service
public class SearchAllService {

	@Autowired
	private SearchAllDAO alldao;

//	public List<PropertyDTO> searchAll(String keyword) {
//		return alldao.searchAll(keyword);
//	}

	public List<PropertyResultDTO> getAllProperties(String keyword) {
		return alldao.getAllProperties(keyword);
	}

}
