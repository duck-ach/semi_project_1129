package com.gdu.semi02.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi02.service.GalleryService;

@Controller
public class GalleryController {

	@Autowired
	private GalleryService galleryService;
	
	@GetMapping("/gallery/list")
	public String list(HttpServletRequest request, Model model) {
		galleryService.getGalleryList(request, model);
		return "gallery/list";
	}
	
	@GetMapping("/gallery/write")
	public String requiredLogin_write() {
		return "gallery/write";
	}
	
	@PostMapping("/gallery/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		galleryService.saveGallery(request, response);
	}
	
	@ResponseBody // ajax
	@PostMapping(value="/gallery/uploadImage", produces = "application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest multipartRequest){
		return galleryService.saveSummernoteImage(multipartRequest);
	}
	
	@GetMapping("/gallery/increase/hit")
	public String increaseHit(@RequestParam(value="galleryNo", required=false, defaultValue="0") int galleryNo) { // 꼭 필요하지만 혹시 안 올수 있으니까
		int result = galleryService.increaseGalleryHit(galleryNo);
		if(result > 0) { // 조회수 증가 성공하면 상세보기로 이동
			return "redirect:/gallery/detail?galleryNo=" + galleryNo;
		} else {		 // 조회수 증가 실패하면 목록으로 이동
			return "redirect:/gallery/list";
		}
	}
	
	@GetMapping("/gallery/detail") // model에다 실어놓으면 수정하기 할때 재활용이 X
	public String detail(@RequestParam(value="galleryNo", required=false, defaultValue="0") int galleryNo, Model model) {
		model.addAttribute("gallery", galleryService.getGalleryByNo(galleryNo));
		return "/gallery/detail";
	}
	
	@PostMapping("/gallery/edit")
	public String edit(int galleryNo, Model model) {
		model.addAttribute("gallery", galleryService.getGalleryByNo(galleryNo));
		return "gallery/edit";
	}
	
	@PostMapping("/gallery/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		galleryService.modifyGallery(request, response); // 수정 후 상세보기로
	}
	
	@PostMapping("/gallery/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		galleryService.removeGallery(request, response); // 수정 후 목록보기로
	}
	
}


