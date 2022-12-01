package com.gdu.semi02.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface UploadService {
	public void getUploadList(HttpServletRequest request, Model model);
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	public void getUploadByNo(int uploadNo, Model model);
	public int increaseUploadHit(int uploadNo);
	public ResponseEntity<Resource> download(HttpServletRequest request, HttpServletResponse response);
	public ResponseEntity<Resource> downloadAll(HttpServletRequest request, HttpServletResponse response);
	public void modifyUpload(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	public void removeAttachByAttachNo(int attachNo); // 삭제하려면 attachNo필요
	public void removeUpload(HttpServletRequest request, HttpServletResponse response);
}
