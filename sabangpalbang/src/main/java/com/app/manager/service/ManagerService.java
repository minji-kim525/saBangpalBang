package com.app.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.manager.dao.ManagerDao;
import com.app.manager.dto.PropertyResponseDto;

@Service
public class ManagerService {
	@Autowired
	ManagerDao dao;
	public List<PropertyResponseDto> getPropertyManage() {
		return dao.getPropertyManage();
	}
	
	public void deleteProperty(int property_service_id) {
		 dao.deleteProperty(property_service_id);
	}
}
