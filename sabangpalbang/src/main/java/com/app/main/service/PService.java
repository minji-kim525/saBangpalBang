package com.app.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.PropertyDTO;
import com.app.main.dao.PDAO;
import com.app.property.dto.PropertyResultDTO;

@Service
public class PService {

	@Autowired
	private PDAO pdao;
	
	public List<PropertyDTO> getProperties() {
		return pdao.getProperties();
	}

}
