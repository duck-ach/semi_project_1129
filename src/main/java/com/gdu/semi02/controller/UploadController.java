package com.gdu.semi02.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi02.service.UploadService;

@Controller
public class UploadController {
	
	@Autowired
	private UploadService uploadService;
	
	@GetMapping("/upload/list")
	public String list(HttpServletRequest request, Model model) {
		uploadService.getUploadList(request, model);
		return "upload/list";
	}
	
	@GetMapping("/upload/write")
	public String requiredLogin_write() {
		return "upload/write";
	}
	
	@PostMapping("/upload/add")
	public void requiredLogin_add(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		uploadService.save(multipartRequest, response);
	}
	
	@GetMapping("/upload/increase/hit")
	public String increaseHit(@RequestParam(value="uploadNo", required=false, defaultValue="0") int uploadNo) {
		int result = uploadService.increaseUploadHit(uploadNo);
		if(result > 0) {
			return "redirect:/upload/detail?uploadNo=" + uploadNo;
		} else {
			return "redirect:/upload/list";
		}
	}
	
	@GetMapping("/upload/detail")
	public String detail(@RequestParam(value="uploadNo", required=false, defaultValue="0") int uploadNo, Model model) {
		uploadService.getUploadByNo(uploadNo, model);
		return "upload/detail";
	}
	
	// [첨부파일] 다운로드
	@ResponseBody // 요청헤더를 뒤지는 애 @RequestHeader              // attachNo는 @RequestParam을 생략한 것 1. @RequestParam적어도되고, 2.뒤에 "attachNo"적고싶으면 적어도 되고, 3 생략하고 int attachNo만해도 되고
	@GetMapping("/upload/download")
	public ResponseEntity<Resource> requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		return uploadService.download(request, response);
	}
	
	@ResponseBody
	@GetMapping("/upload/downloadAll")
	public ResponseEntity<Resource> requiredLogin_downloadAll(HttpServletRequest request, HttpServletResponse response) {
		return uploadService.downloadAll(request, response);
	}
	
	@PostMapping("/upload/edit")
	public String requiredLogin_edit(@RequestParam("uploadNo") int uploadNo, Model model) {
		uploadService.getUploadByNo(uploadNo, model);
		return "upload/edit";
	}
	
	@PostMapping("/upload/modify")
	public void requiredLogin_modify(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		uploadService.modifyUpload(multipartRequest, response);
	}
	
	// [첨부파일] 삭제
	@GetMapping("/upload/attach/remove")
	public String requiredLogin_attachRemove(@RequestParam("uploadNo") int uploadNo, @RequestParam("attachNo") int attachNo) {
		uploadService.removeAttachByAttachNo(attachNo);
		return "redirect:/upload/detail?uploadNo=" + uploadNo; // uploadNo를 가지고 가야함
	}
	
	@PostMapping("/upload/remove")
	public void requiredLogin_remove(HttpServletRequest request, HttpServletResponse response) {
		uploadService.removeUpload(request, response);
	}
}
