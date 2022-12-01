package com.gdu.semi02.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.semi02.domain.BbsCommDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.BbsCommMapper;
import com.gdu.semi02.util.BbsPageUtil;

//@AllArgsConstructor
@Service
public class BbsCommServiceImpl implements BbsCommService {
	
    @Autowired
	private BbsCommMapper bbsCommMapper;
    @Autowired
	private BbsPageUtil pageUtil;

	@Override
	public Map<String, Object> getBbsCommentCount(int bbsNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("bbsCommCount", bbsCommMapper.selectBbsCommentCount(bbsNo));
		return result;
	}
	
	
	@Override
	public Map<String, Object> addBbsComment(BbsCommDTO bbsComm, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		bbsComm.setId(loginUser.getId());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", bbsCommMapper.insertBbsComment(bbsComm));

		return result;
	}
	
	
	
	@Override
	public Map<String, Object> getBbsCommentList(HttpServletRequest request) {
		int bbsNo = Integer.parseInt(request.getParameter("bbsNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		
		int bbsCommCount = bbsCommMapper.selectBbsCommentCount(bbsNo);
		pageUtil.setPageUtil(page, bbsCommCount);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsNo", bbsNo);
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("bbsCommList", bbsCommMapper.selectBbsCountList(map));
		result.put("pageUtil", pageUtil);
		System.out.println(result);
		
		return result;
	}
	
	
	@Override
	public Map<String, Object> removeBbsComment(int bbsCommNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", bbsCommMapper.deleteBbsComment(bbsCommNo));
		return result;
	}
	
	
	@Override
	public Map<String, Object> addReply(BbsCommDTO reply, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		reply.setId(loginUser.getId());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", bbsCommMapper.insertReply(reply) == 1);

		return result;
	}
	
}
