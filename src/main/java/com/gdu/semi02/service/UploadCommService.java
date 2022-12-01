package com.gdu.semi02.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.semi02.domain.UploadCommDTO;

public interface UploadCommService {
	public Map<String, Object> getCommentCount(int uploadNo);
	public Map<String, Object> addComment(UploadCommDTO comment, HttpServletRequest request);
	public Map<String, Object> getCommentList(HttpServletRequest request);
	public Map<String, Object> removeComment(int commentNo);
	public Map<String, Object> addReply(UploadCommDTO reply, HttpServletRequest request);
}
