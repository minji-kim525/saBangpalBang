package com.app.property.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.ImagesDTO;
import com.app.dto.PropertyDTO;
import com.app.dto.PropertyServiceDTO;
import com.app.dto.TransactionPriceDTO;
import com.app.property.dao.SearchAllDAO;
import com.app.property.dto.PropertyDetailDTO;
import com.app.property.dto.PropertyResultDTO;
import com.google.gson.Gson;

@Service
public class SearchAllService {

	@Autowired
	private SearchAllDAO alldao;

	// 검색
	public List<PropertyResultDTO> getAllProperties(String keyword) {
		List<PropertyResultDTO> result = alldao.getAllProperties(keyword);
		for (PropertyResultDTO propertyResultDTO : result) {
			// 각 매물에 대한 이미지 가져옴
			ImagesDTO imageDTO = alldao.getImage(propertyResultDTO.getProperty_service_id(),
					propertyResultDTO.getPs_service_type());
			ImagesDTO imageDTO2 = alldao.getImage(propertyResultDTO.getProperty_id(),
					propertyResultDTO.getP_service_type());
			// 이미지를 PropertyResultDTO에 설정
			propertyResultDTO.addImage(imageDTO);
			propertyResultDTO.addImage(imageDTO2);
		}
		return result;
	}

	// 서비스 매물 상세정보
	public PropertyDetailDTO getpsDetail(int propertyId, int psServiceType, String address, String pname) {
		PropertyDetailDTO psImagedto = alldao.getpsDetail(propertyId, psServiceType, address, pname);
		List<ImagesDTO> Idto = alldao.AllImages(propertyId, psServiceType);
		psImagedto.setImages(Idto);
		return psImagedto;
	}

	// 크롤링 매물 상세정보
	public PropertyDetailDTO getpDetail(int propertyId, int pServiceType, String address, String pname) {
		PropertyDetailDTO pImagedto = alldao.getpDetail(propertyId, pServiceType, address, pname);
		List<ImagesDTO> Idto = alldao.AllImages(propertyId, pServiceType);
		pImagedto.setImages(Idto);
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
//		List<ConfirmDTO> confirmList = alldao.getConfirm();
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
	
	// 서비스매물 랜덤 정보
	public List<PropertyServiceDTO> getRanServiceProperties() {
		List<PropertyServiceDTO> result = new ArrayList<>();
//		List<ConfirmDTO> confirmList = alldao.getConfirm();
		// 매물 서비스 정보 가져오기
		List<PropertyServiceDTO> propertyServiceList = alldao.getRanServiceProperties();
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

	// 상세정보 실거래가 그래프
	public List<TransactionPriceDTO> getTransaction(String address, String pname) {
		List<TransactionPriceDTO> chart = alldao.getTransaction(address, pname);
		return chart;
	}
	
	//아파트 실거래가 비교
	public List<TransactionPriceDTO> getAllTransaction() {
		List<TransactionPriceDTO> getAllTransaction = alldao.getAllTransaction();
		return getAllTransaction;
	}
	
	//아파트 실거래가 비교 그래프 정보
	public List<TransactionPriceDTO> getTransGraph(int regcd, int dongcd, int apartcd) {
		List<TransactionPriceDTO> getTransGraph = alldao.getTransGraph(regcd, dongcd, apartcd);
		return getTransGraph;
	}
	
	//동 이름
	public List<TransactionPriceDTO> getAllDong(int regcd){
		List<TransactionPriceDTO> getAllDong = alldao.getAllDong(regcd);
		return getAllDong;
	}
	
	//아파트 이름
	public List<TransactionPriceDTO> getAllName(int regcd, int dongcd){
		List<TransactionPriceDTO> getAllName = alldao.getAllName(regcd, dongcd);
		return getAllName;
	}
}
