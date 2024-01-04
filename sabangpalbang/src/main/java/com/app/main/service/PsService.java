package com.app.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.PropertyServiceDTO;
import com.app.main.dao.PsDAO;

@Service
public class PsService {

	@Autowired
	private PsDAO psdao;

	public List<PropertyServiceDTO> getServiceProperties() {
		return psdao.getServiceProperties();
	}
}
