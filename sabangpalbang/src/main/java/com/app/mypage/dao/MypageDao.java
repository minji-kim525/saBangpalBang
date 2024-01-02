package com.app.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.app.dto.ConfirmDTO;
import com.app.dto.ImagesDTO;
import com.app.mypage.dto.UploadRequestDto;

@Mapper
public interface MypageDao {
	

	int insertRoomInfo(UploadRequestDto dto);
	
	
	int insertFile(@Param("list")List<ImagesDTO>list,@Param("id")int id);

	@Insert("insert into confirm(confirm_check,ps_service_type,property_service_id)"+
	"values(#{confirm_check},#{ps_service_type},#{property_service_id})")
	int insertConfirm(ConfirmDTO confirmDto);
	
//	List<>
//	List<PropertyServiceDTO> 
}
