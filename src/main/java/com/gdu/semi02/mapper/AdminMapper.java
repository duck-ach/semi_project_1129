package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.AdminDTO;

@Mapper
public interface AdminMapper {	
	public List<AdminDTO> selectAllUsers();
	public int selectAllUsersCount();
	public List<AdminDTO> selectUsersByQuery(Map<String, Object> map);
	public List<AdminDTO> selectComedyUser();
	public int deleteUsers(Map<String, Object> userNo);
	
	
}
