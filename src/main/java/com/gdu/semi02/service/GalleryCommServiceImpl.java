package com.gdu.semi02.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.semi02.domain.GalleryCommDTO;
import com.gdu.semi02.mapper.GalleryCommMapper;
import com.gdu.semi02.util.GalleryPageUtil;

@Service
public class GalleryCommServiceImpl implements GalleryCommService {

	@Autowired
	private GalleryCommMapper commentMapper;
	
	@Autowired
	private GalleryPageUtil galleryPageUtil;
	
	@Override
	public Map<String, Object> getCommentCnt(int galleryNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt", commentMapper.selectCommentCnt(galleryNo));
		return result;
	}
	
	@Override
	public Map<String, Object> addComment(GalleryCommDTO comment) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertComment(comment) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> getCommentList(HttpServletRequest request) {
		
		int galleryNo = Integer.parseInt(request.getParameter("galleryNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		
		int commentCnt = commentMapper.selectCommentCnt(galleryNo);
		galleryPageUtil.setPageUtil(page, commentCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("galleryNo", galleryNo);
		map.put("begin", galleryPageUtil.getBegin());
		map.put("end", galleryPageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentList", commentMapper.selectCommentList(map));
		result.put("galleryPageUtil", galleryPageUtil);
		
		return result;
		
	}
	
	@Override
	public Map<String, Object> removeComment(int commentNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", commentMapper.deleteComment(commentNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> addReply(GalleryCommDTO reply) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertReply(reply) == 1);
		return result;
	}
	
}