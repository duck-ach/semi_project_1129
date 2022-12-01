package com.gdu.semi02.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi02.domain.GalleryDTO;
import com.gdu.semi02.domain.LikedDTO;

public interface GalleryService {
	
	public void getGalleryList(HttpServletRequest request, Model model);
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	public void saveGallery(HttpServletRequest request, HttpServletResponse response);
	public int increaseGalleryHit(int galleryNo);
	public GalleryDTO getGalleryByNo(int galleryNo);
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response);
	public void removeGallery(HttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> getLikedUser(LikedDTO liked);
	
}
