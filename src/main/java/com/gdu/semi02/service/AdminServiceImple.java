package com.gdu.semi02.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.SleepUserDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.AdminMapper;
import com.gdu.semi02.util.SecurityUtil;
	
	


@Service
public class AdminServiceImple implements AdminService {
	@Autowired
	private AdminMapper adminMapper;

	
	@Autowired
	private SecurityUtil securityUtil;
	
	@Override
	public int getAllUsercount(HttpServletRequest request) {
		request.setAttribute("usersCnt", adminMapper.selectAllUsersCount());
		return adminMapper.selectAllUsersCount();
	}
	
	@Override
	public List<UserDTO> getAllUserList(Model model, HttpServletRequest request) {
		request.setAttribute("usersCnt", adminMapper.selectAllUsersCount());
		model.addAttribute("cntUserBoard", adminMapper.selectUploadUserAll());
		
		return adminMapper.selectAllUsers();
	}
	
	@Override
	public List<RetireUserDTO> selectRemoveAllUsers(Model model, HttpServletRequest request) {
		return adminMapper.selectRemoveAllUsers();
	}
	
	@Override
	public List<SleepUserDTO> selectSleepAllUsers(Model model, HttpServletRequest request) {
		return adminMapper.selectSleepAllUsers(); 
	}
	
	@Override
	public List<UserDTO> findSearchUserList(HttpServletRequest request, Model model) {
		// 파라미터
		String column = request.getParameter("column");
		String searchText = securityUtil.preventXSS(request.getParameter("searchText"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("searchText", searchText);
		
		return adminMapper.selectUsersByQuery(map);
	}
		
	@Transactional
	@Override
	public void removeUsers(String userNo, HttpServletResponse response, HttpServletRequest request) {
		
		int userIntNo = Integer.parseInt(userNo);

	    
		int result = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 유저정보 불러오기
		UserDTO user = adminMapper.selectUsersByNo(userIntNo);
	
		map.put("userNo", userNo);
		map.put("id", user.getId());
		map.put("joinDate", user.getJoinDate());
		result = adminMapper.deleteUsers(map);
		int retireUserResult = adminMapper.insertRetireUser(map);
		
		response.setContentType("text/html; charset=UTF-8");
		
		try {
			PrintWriter out = response.getWriter();
			if(result > 0 && retireUserResult > 0) {  // if(result == 1) {
				out.println("<script>");
				out.println("alert('회원 탈퇴되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/admin/userAdmin';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('회원 탈퇴에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}
	
	
	@Override
	public void SleepAllUsers(String userNo, HttpServletResponse response, HttpServletRequest request) {
		int userIntNo = Integer.parseInt(userNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 유저정보 불러오기
		UserDTO user = adminMapper.selectUsersByNo(userIntNo);
	
		map.put("userNo", userNo);
		map.put("id", user.getId());
		int sleepUserResult = adminMapper.insertSleepAllUsers(map);
		int deleteUserResult = adminMapper.deleteUsers(map);
		
		response.setContentType("text/html; charset=UTF-8");
		
		try {
			PrintWriter out = response.getWriter();
			if(sleepUserResult > 0 && deleteUserResult > 0) {  // if(result == 1) {
				out.println("<script>");
				out.println("alert('회원 휴면 처리가 되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/admin/userAdmin';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('회원 휴면 처리에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	
}
	

	