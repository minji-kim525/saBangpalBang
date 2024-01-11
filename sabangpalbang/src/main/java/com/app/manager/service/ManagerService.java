package com.app.manager.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.dto.PaginationDto;
import com.app.dto.PagingResponseDto;
import com.app.dto.SearchDto;
import com.app.manager.dao.ManagerDao;
import com.app.manager.dto.PropertyResponseDto;
import com.app.manager.dto.UsersResponseDto;

@Service
public class ManagerService {
	@Autowired
	ManagerDao dao;
	
	//매물 검색 및 조회
	public PagingResponseDto<PropertyResponseDto> searchPropertyManage(SearchDto searchDto) {
		
		//조건에 해당하는 데이터가 없는 경우 null
		int count = dao.count(searchDto);
		if(count<1) {
			return new PagingResponseDto<>(Collections.emptyList(),null);
		}
		PaginationDto paginationDto = new PaginationDto(count,searchDto);
		searchDto.setPaginationDto(paginationDto);
		
		List<PropertyResponseDto> list=dao.searchPropertyManage(searchDto);
		return new PagingResponseDto<>(list, paginationDto);
	}
	
	//매물 삭제
	public void deleteProperty(int property_service_id) {
		 dao.deleteProperty(property_service_id);
	}
	
	//매물 승인요청 조회
	public PagingResponseDto<PropertyResponseDto> getConfirm(SearchDto searchDto) {

		//조건에 해당하는 데이터가 없는 경우 null
		int count = dao.countConfirm(searchDto);
		if(count<1) {
			return new PagingResponseDto<>(Collections.emptyList(),null);
		}
		PaginationDto paginationDto = new PaginationDto(count,searchDto);
		searchDto.setPaginationDto(paginationDto);
					
		List<PropertyResponseDto> list=dao.getConfirm(searchDto);
		return new PagingResponseDto<>(list, paginationDto);
	}
	
	@Transactional
	//승인및반려
	public void updateConfirm(int property_service_id,int confirmcheck) {
		dao.updateConfirm(property_service_id,confirmcheck);
		int user_id=dao.findUser(property_service_id);
		int confirm_id=dao.findConfirm(property_service_id);
		dao.insertNotify(user_id,confirm_id);
		
	}

	

	//매물 검색 및 조회
	public PagingResponseDto<UsersResponseDto> getUsers(SearchDto searchDto) {
		
		//조건에 해당하는 데이터가 없는 경우 null
		int count = dao.countUsers(searchDto);
		if(count<1) {
			return new PagingResponseDto<>(Collections.emptyList(),null);
		}
		PaginationDto paginationDto = new PaginationDto(count,searchDto);
		searchDto.setPaginationDto(paginationDto);
		
		List<UsersResponseDto> list=dao.getUsers(searchDto);
		return new PagingResponseDto<>(list, paginationDto);
	}

	public void deleteUser(int user_id) {
		dao.deleteUser(user_id);
		
	}
}
