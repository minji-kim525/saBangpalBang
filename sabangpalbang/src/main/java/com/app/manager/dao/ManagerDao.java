package com.app.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.app.dto.SearchDto;
import com.app.manager.dto.PropertyResponseDto;
import com.app.manager.dto.UsersResponseDto;

@Mapper
public interface ManagerDao {
	
	
	List<PropertyResponseDto> searchPropertyManage(SearchDto searchDto);
	//게시글 삭제
	@Delete("delete from property_service where property_service_id = #{property_service_id}")
	int deleteProperty(@Param("property_service_id")int property_service_id);
		
	//게시글 수 카운팅
	int count(SearchDto searchDto );
	
	List<PropertyResponseDto> getConfirm(SearchDto searchDto);
	//승인요청 수 카운팅
	int countConfirm(SearchDto searchDto);
	
	// 승인, 반려, 취소
	@Update("update confirm set confirm_check = #{confirmcheck} where property_service_id = #{property_service_id}")
	int updateConfirm(@Param("property_service_id")int property_service_id,@Param("confirmcheck")int confirmcheck);

	//사용자 조회
	List<UsersResponseDto> getUsers(SearchDto searchDto);
	//사용자 수 카운팅
	int countUsers(SearchDto searchDto);
	//사용자 삭제
	@Delete("delete from users where user_id = #{user_id}")
	int deleteUser(int user_id);
	
	@Select("select user_id from property_service where property_service_id=#{property_service_id}")
	int findUser(int property_service_id);
	
	@Select("select confirm_id from confirm where property_service_id=#{property_service_id}")
	int findConfirm(int property_service_id);
	
	@Insert("insert into notify(notify_check, user_id, confirm_id)values(0,#{user_id},#{confirm_id})")
	int insertNotify(@Param("user_id")int user_id,@Param("confirm_id")int confirm_id);
	
}
