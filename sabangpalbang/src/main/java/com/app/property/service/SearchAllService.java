package com.app.property.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.ImagesDTO;
import com.app.dto.PropertyDTO;
import com.app.dto.PropertyServiceDTO;
import com.app.property.dao.SearchAllDAO;
import com.app.property.dto.PropertyDetailDTO;
import com.app.property.dto.PropertyResultDTO;

@Service
public class SearchAllService {

	@Autowired
	private SearchAllDAO alldao;

	// 검색
	public List<PropertyResultDTO> getAllProperties(String keyword) {
		List<PropertyResultDTO> result = alldao.getAllProperties(keyword);
		for (PropertyResultDTO propertyResultDTO : result) {
			// 각 매물에 대한 이미지 가져옴
			ImagesDTO imageDTO = alldao.getImage(propertyResultDTO.getProperty_service_id(), propertyResultDTO.getPs_service_type());
			ImagesDTO imageDTO2 = alldao.getImage(propertyResultDTO.getProperty_id(), propertyResultDTO.getP_service_type());
			// 이미지를 PropertyResultDTO에 설정
			propertyResultDTO.addImage(imageDTO);
			propertyResultDTO.addImage(imageDTO2);
		}
		return result;
	}
//		return alldao.getAllProperties(keyword);
//	}

	// 서비스 매물 상세정보
	public PropertyDetailDTO getpsDetail(int propertyId, int psServiceType) {
		PropertyDetailDTO psImagedto = alldao.getpsDetail(propertyId, psServiceType);
		List<ImagesDTO> Idto = alldao.AllImages(propertyId, psServiceType);
		psImagedto.setImages(Idto);
//		for(ImagesDTO i : Idto) {
//			
//		}
		System.out.println(Idto);
		return psImagedto;
	}

	// 크롤링 매물 상세정보
	public PropertyDetailDTO getpDetail(int propertyId, int pServiceType) {
		PropertyDetailDTO pImagedto = alldao.getpDetail(propertyId, pServiceType);
		List<ImagesDTO> Idto = alldao.AllImages(propertyId, pServiceType);
		pImagedto.setImages(Idto);
		System.out.println(Idto);
		return pImagedto;
	}

	// 크롤링매물 정보
	public List<PropertyDTO> getProperties() {
		List<PropertyDTO> result = new ArrayList<>();
		// 매물 서비스 정보 가져오기
		List<PropertyDTO> propertyList = alldao.getProperties();
		for (PropertyDTO propertyDTO : propertyList) {
			// 이미지 정보 가져오기
			ImagesDTO imageDTO = alldao.getImage(propertyDTO.getProperty_id(), propertyDTO.getP_service_type());
			// 이미지를 매물 서비스에 설정
			propertyDTO.setImages(imageDTO);
			result.add(propertyDTO);
		}
		return result;
	}

	// 서비스매물 정보
	public List<PropertyServiceDTO> getServiceProperties() {
		List<PropertyServiceDTO> result = new ArrayList<>();
		// 매물 서비스 정보 가져오기
		List<PropertyServiceDTO> propertyServiceList = alldao.getServiceProperties();
		for (PropertyServiceDTO propertyServiceDTO : propertyServiceList) {
			// 이미지 정보 가져오기
			ImagesDTO imageDTO = alldao.getImage(propertyServiceDTO.getProperty_service_id(),
					propertyServiceDTO.getPs_service_type());
			// 이미지를 매물 서비스에 설정
			propertyServiceDTO.setImages(imageDTO);
			result.add(propertyServiceDTO);
		}
		return result;
	}

}
