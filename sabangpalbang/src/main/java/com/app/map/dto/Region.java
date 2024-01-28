package com.app.map.dto;

import lombok.Data;

@Data
public class Region {
	private int seoul_id;
	private String sido=null;
	private String sigungu=null;
	private String dong=null;
	private double lat;
	private double lon;
	private int mapLevel;

}
