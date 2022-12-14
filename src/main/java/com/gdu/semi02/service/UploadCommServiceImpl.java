package com.gdu.semi02.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.semi02.domain.UploadCommDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.UploadCommMapper;
import com.gdu.semi02.util.UploadCommPageUtil;

@Service
public class UploadCommServiceImpl implements UploadCommService {

	@Autowired
	private UploadCommMapper commentMapper;
	
	@Autowired
	private UploadCommPageUtil pageUtil;
	
	@Override
	public Map<String, Object> getCommentCount(int uploadNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCount", commentMapper.selectCommentCount(uploadNo)); // ajax로 넘겨줄 resData
		return result;
	}
	
	@Override
	public Map<String, Object> addComment(UploadCommDTO comment, HttpServletRequest request) {
		
		// Session의 User 정보
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		comment.setId(loginUser.getId());
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertComment(comment) == 1); // ajax로 넘겨줄 resData
		return result;
	}
	
	@Override
	public Map<String, Object> getCommentList(HttpServletRequest request) {
		
		// 파라미터
		int uploadNo = Integer.parseInt(request.getParameter("uploadNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		
		// comment 개수
		int commentCount = commentMapper.selectCommentCount(uploadNo);
		
		pageUtil.setPageUtil(page, commentCount); // 페이지에대한 계산(페이지수, 댓글개수)
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uploadNo", uploadNo);
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentList", commentMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);
		
		return result;
	}

	@Override
	public Map<String, Object> removeComment(int uploadCommNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", commentMapper.deleteComment(uploadCommNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> addReply(UploadCommDTO reply, HttpServletRequest request) {
		// Session의 User 정보
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		reply.setId(loginUser.getId());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertReply(reply) == 1);
		return result;
	}
}
