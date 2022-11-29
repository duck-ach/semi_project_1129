package com.gdu.semi02.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.semi02.domain.BbsCommDTO;

public interface BbsCommService {
	public Map<String, Object> getBbsCommentCount(int bbsNo);
	public Map<String, Object> addBbsComment(BbsCommDTO bbsComm);
	public Map<String, Object> getBbsCommentList(HttpServletRequest request);
	public Map<String, Object> removeBbsComment(int bbsCommNo);
	public Map<String, Object> addReply(BbsCommDTO reply);
}
