package com.gdu.semi02.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.semi02.domain.AdminDTO;
import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.AdminMapper;
import com.gdu.semi02.mapper.UserMapper;
import com.gdu.semi02.util.SecurityUtil;
	
	


@Service
public class AdminServiceImple implements AdminService {
	@Autowired
	private AdminMapper adminMapper;
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private SecurityUtil securityUtil;
	
	@Override
	public int getAllUsercount(HttpServletRequest request) {
		request.setAttribute("usersCnt", adminMapper.selectAllUsersCount());
		return adminMapper.selectAllUsersCount();
	}
	
	@Override
	public List<AdminDTO> getAllUserList(HttpServletRequest request) {
		request.setAttribute("usersCnt", adminMapper.selectAllUsersCount());
		return adminMapper.selectAllUsers();
	}
	
	
	@Override
	public List<AdminDTO> findSearchUserList(HttpServletRequest request, Model model) {
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
		
		int result = 0;
	
		System.out.println(userNo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 탈퇴할 회원의 userNo, id, joinDate는 session의 loginUser에 저장되어 있다.
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		
		// 탈퇴할 회원 RetireUserDTO 생성
		RetireUserDTO retireUser = RetireUserDTO.builder()
				.userNo(loginUser.getUserNo())
				.id(loginUser.getId())
				.joinDate(loginUser.getJoinDate())
				.build();

		// 탈퇴처리
		int deleteResult = userMapper.deleteUser(loginUser.getUserNo());
		int insertResult = userMapper.insertRetireUser(retireUser);

		
		
		
		map.put("userNo", userNo);
		result = adminMapper.deleteUsers(map);
		
		
		response.setContentType("text/html; charset=UTF-8");
		
		try {
			PrintWriter out = response.getWriter();
			if(result > 0) {  // if(result == 1) {
				session.invalidate();
				
				
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
	
	
	
}

	
	
	