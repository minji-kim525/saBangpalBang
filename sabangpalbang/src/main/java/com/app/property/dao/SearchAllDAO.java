package com.app.property.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.ImagesDTO;
import com.app.dto.PropertyDTO;
import com.app.dto.PropertyServiceDTO;
import com.app.dto.TransactionPriceDTO;
import com.app.property.dto.PropertyDetailDTO;
import com.app.property.dto.PropertyResultDTO;

@Mapper
public interface SearchAllDAO {
	
	//검색정보
	List<PropertyResultDTO> getAllProperties(@Param("keyword") String keyword);
	
	//썸네일
	ImagesDTO getImage(@Param("id1") int id, @Param("id2") int ps_type);
	
	//다중이미지
	List<ImagesDTO> AllImages(@Param("Id") int Id, @Param("ServiceType") int ServiceType);
	
	//서비스 매물 상세정보
	PropertyDetailDTO getpsDetail(@Param("propertyId") int propertyId, @Param("psServiceType") int psServiceType, @Param("address") String address, @Param("pname") String pname);
	
	//크롤링 매물 상세정보
	PropertyDetailDTO getpDetail(@Param("propertyId") int propertyId, @Param("pServiceType") int pServiceType, @Param("address") String address, @Param("pname") String pname);
	
	//크롤링매물 정보
	List<PropertyDTO> getProperties();
	
	//서비스매물 정보
	List<PropertyServiceDTO> getServiceProperties();
	
	//상세정보 실거래가 그래프
	List<TransactionPriceDTO> getTransaction(@Param("address") String address, @Param("pname") String pname);
	
	//아파트 실거래가 비교
	List<TransactionPriceDTO> getAllTransaction();
	
	//아파트 실거래가 비교 그래프 정보
	List<TransactionPriceDTO> getTransGraph(@Param("regional_cd") int regcd, @Param("dong_cd") int dongcd, @Param("apart_cd") int apartcd);
	
	//동 이름
	List<TransactionPriceDTO> getAllDong(@Param("regional_cd") int regcd);
	
	//아파트 이름
	List<TransactionPriceDTO> getAllName(@Param("regional_cd") int regcd, @Param("dong_cd") int dongcd);
}