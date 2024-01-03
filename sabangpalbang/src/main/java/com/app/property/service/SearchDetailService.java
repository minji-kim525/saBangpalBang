package com.app.property.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.property.dao.SearchDetailDAO;
import com.app.property.dto.PropertyDetailDTO;

@Service
public class SearchDetailService {

	@Autowired
	private SearchDetailDAO detaildao;

	public List<PropertyDetailDTO> getDetail(String keyword) {
        return detaildao.getDetail(keyword);
    }
}
