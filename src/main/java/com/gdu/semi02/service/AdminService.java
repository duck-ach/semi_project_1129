package com.gdu.semi02.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.semi02.domain.AdminDTO;


public interface AdminService {
	
	
	public int getAllUsercount(HttpServletRequest request);
	public List<AdminDTO> getAllUserList(HttpServletRequest request);
	public List<AdminDTO> findSearchUserList(HttpServletRequest request, Model model); 
	public void removeUsers(String userNo , HttpServletResponse response, HttpServletRequest request );   
//	public void retire(HttpServletRequest request, HttpServletResponse response);

}
 