package com.gdu.semi02.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.SleepUserDTO;
import com.gdu.semi02.domain.UserDTO;


@Mapper
public interface UserMapper {
	public UserDTO selectUserByMap(Map<String, Object> map);
	public RetireUserDTO selectRetireUserById(String id);
	public int insertUser(UserDTO user);
	public int updateAccessLog(String id);
	public int insertAccessLog(String id);
	public int deleteUser(int userNo);
	public int insertRetireUser(RetireUserDTO retireUser);
	public int updateSessionInfo(UserDTO user);
	public UserDTO selectUserById(String id);
	public int updateUserPassword(UserDTO user);
	public int updateUserInfo(UserDTO user);
	public int insertSleepUser();
	public int deleteUserForSleep();
	public SleepUserDTO selectSleepUserById(String id);
	public int insertRestoreUser(String id);
	public int deleteSleepUser(String id);
	public int insertNaverUser(UserDTO user);
}
