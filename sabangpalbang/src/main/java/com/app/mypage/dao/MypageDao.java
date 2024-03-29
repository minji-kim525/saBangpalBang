package com.app.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.app.dto.ImagesDTO;
import com.app.dto.LikeListDTO;
import com.app.mypage.dto.MyUploadResponseDto;
import com.app.mypage.dto.NotifyResponseDto;
import com.app.mypage.dto.UploadRequestDto;
import com.app.property.dto.PropertyResultDTO;
import com.app.question.dto.titleDto;

@Mapper
public interface MypageDao {

	int insertRoomInfo(UploadRequestDto dto);

	int insertFile(@Param("list") List<ImagesDTO> list, @Param("id") int id);

	@Insert("insert into confirm(confirm_check,ps_service_type,property_service_id)"
			+ "values(0,1,#{property_service_id})")
	int insertConfirm(@Param("property_service_id") int property_service_id);

	@Select("select property_service_id, ps_service_type,property_type_id,price,pname,private_property,telephone,month_price,deposit from property_service where user_id=#{user_id}")
	List<MyUploadResponseDto> getMyUploadAll(int user_id);

	ImagesDTO getImageP(@Param("id1") int id, @Param("id2") int p_type);
	ImagesDTO getImagePs(@Param("id1") int id, @Param("id2") int ps_type);

	@Update("update property_service set private_property = not private_property where property_service_id = #{property_service_id} and user_id=#{user_id}")
	int updatePrivate(@Param("property_service_id") int property_service_id, @Param("user_id") int user_id);

	int insertLikeList(@Param("likeListDto")LikeListDTO likeListDto);
	
	List<PropertyResultDTO>getMyLikeList(@Param("user_id")int user_id);
  
	@Select("select question_id,title,created_at,id from question natural join users where user_id=#{user_id}")
	List<titleDto> myQuestionList(@Param("user_id")int user_id);

	List<NotifyResponseDto> getNotify(int user_id);

	@Select("select title from question where question_id=#{question_id}")
	String getNotifyQ(Integer question_id);
	@Select("select pname from property_service where property_service_id=#{property_service_id}")
	String getNotifyP(int property_service_id);

	@Update("update notify set notify_check = not notify_check where notify_id = #{notify_id}")
	void updateNotifyStatus(int notify_id);
	
}

