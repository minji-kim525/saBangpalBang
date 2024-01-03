package com.app.property.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.PropertyDTO;
import com.app.property.dao.SearchAllDAO;

@Service
public class SearchAllService {

	@Autowired
	private SearchAllDAO alldao;

//	public List<PropertyDTO> searchAll(String keyword) {
//		return alldao.searchAll(keyword);
//	}

	public List<PropertyDTO> getAllProperties(String keyword) {
		return alldao.getAllProperties(keyword);
	}
}
