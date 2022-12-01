package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.UserDTO;

@Mapper
public interface AdminMapper {	
	public List<UserDTO> selectAllUsers();
	public int selectAllUsersCount();
	public List<UserDTO> selectUsersByQuery(Map<String, Object> map);
	public List<UserDTO> selectComedyUser();
	public int deleteUsers(Map<String, Object> userNo);
	public int deleteUser(int userNo);
	public int insertRetireUser(Map<String, Object> map);
	
	public UserDTO selectUsersByNo(int userNo);
	
	public int selectUploadUserAll();
	
	public List<RetireUserDTO> selectRemoveAllUsers();
	 
}
