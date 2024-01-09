package com.app.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

//Generic<T> 어떤타입의 객체던 데이터로 받음
@Data
public class PagingResponseDto<T> {

	private List<T> list = new ArrayList<>();
	private PaginationDto paginationDto;
	
	public PagingResponseDto(List<T> list, PaginationDto paginationDto) {
		this.list.addAll(list);
		this.paginationDto=paginationDto;
	}
}
