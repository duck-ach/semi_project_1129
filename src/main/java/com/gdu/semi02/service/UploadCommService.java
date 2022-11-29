package com.gdu.semi02.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.semi02.domain.UploadCommDTO;

public interface UploadCommService {
	public Map<String, Object> getCommentCount(int blogNo);
	public Map<String, Object> addComment(UploadCommDTO comment);
	public Map<String, Object> getCommentList(HttpServletRequest request);
	public Map<String, Object> removeComment(int commentNo);
	public Map<String, Object> addReply(UploadCommDTO reply);
}
