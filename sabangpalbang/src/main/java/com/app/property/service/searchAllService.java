package com.app.property.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.PropertyDTO;
import com.app.property.dao.searchAllDAO;

@Service
public class searchAllService {

	@Autowired

	searchAllDAO alldao;
	
	public List<PropertyDTO> getAllProperties(){
		return alldao.getAllProperties();
	}
	
	public List <PropertyDTO> searchAll(String keyword){
		return alldao.searchAll(keyword);
		
	}	
}
