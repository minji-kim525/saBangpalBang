package com.app.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.app.dto.ConfirmDTO;
import com.app.dto.ImagesDTO;
import com.app.mypage.dto.MyUploadResponseDto;
import com.app.mypage.dto.UploadRequestDto;

@Mapper
public interface MypageDao {
	

	int insertRoomInfo(UploadRequestDto dto);
	
	
	int insertFile(@Param("list")List<ImagesDTO>list,@Param("id")int id);

	@Insert("insert into confirm(confirm_check,ps_service_type,property_service_id)"+
	"values(false,1,#{property_service_id})")
	int insertConfirm(@Param("property_service_id")int property_service_id );

	@Select("select property_service_id, ps_service_type,property_type_id,price,pname,private_property from property_service where user_id=#{user_id}")
	List<MyUploadResponseDto>getMyUploadAll(int user_id);

	ImagesDTO getImage(@Param("id1")int id, @Param("id2")int ps_type);
	
//	List<>
//	List<PropertyServiceDTO> 
	@Update("update property_service set private_property = not private_property where property_service_id = #{property_service_id} and user_id=#{user_id}")
	int updatePrivate(@Param("property_service_id") int property_service_id,@Param("user_id")int user_id);
}
