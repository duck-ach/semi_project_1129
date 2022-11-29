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

import com.gdu.semi02.domain.AdminDTO;
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
		
		
		map.put("userNo", userNo);
		result = adminMapper.deleteUsers(map);
		
		
		response.setContentType("text/html; charset=UTF-8");
		
		try {
			PrintWriter out = response.getWriter();
			if(result > 0) {  // if(result == 1) {
				out.println("<script>");
				out.println("alert('회원정보가 삭제되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/admin/userAdmin';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('회원정보가 삭제되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	
}

	
	
	
