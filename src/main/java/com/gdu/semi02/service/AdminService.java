package com.gdu.semi02.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.SleepUserDTO;
import com.gdu.semi02.domain.UserDTO;


public interface AdminService {
	
	
	public int getAllUsercount(HttpServletRequest request);
	public List<UserDTO> getAllUserList(Model model, HttpServletRequest request);
	public List<UserDTO> findSearchUserList(HttpServletRequest request, Model model); 
	public void removeUsers(String userNo, HttpServletResponse response, HttpServletRequest request );   
//	public void removeUsers(String userNo ,List<String> id,List<String> joinDate, HttpServletResponse response, HttpServletRequest request );   
//	public void retire(HttpServletRequest request, HttpServletResponse response);
	public void SleepAllUsers(String userNo, HttpServletResponse response, HttpServletRequest request );
	
	
	
	public List<RetireUserDTO> selectRemoveAllUsers(Model model, HttpServletRequest request);
	
	public List<SleepUserDTO> selectSleepAllUsers(Model model, HttpServletRequest request);
	
}
 