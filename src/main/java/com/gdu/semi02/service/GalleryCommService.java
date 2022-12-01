package com.gdu.semi02.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.semi02.domain.GalleryCommDTO;

public interface GalleryCommService {
	public Map<String, Object> getCommentCnt(int galleryNo);
	public Map<String, Object> addComment(GalleryCommDTO comment, HttpServletRequest request);
	public Map<String, Object> getCommentList(HttpServletRequest request);
	public Map<String, Object> removeComment(int galleryCommNo);
	public Map<String, Object> addReply(GalleryCommDTO reply);
}