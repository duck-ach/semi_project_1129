package com.gdu.semi02.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi02.domain.GalleryCommDTO;
import com.gdu.semi02.service.GalleryCommService;

@Controller
public class GalleryCommController {

	@Autowired
	private GalleryCommService galleryCommService;
	
	@ResponseBody//(ajax반환한거니까)
	@GetMapping(value="/galleryComm/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("galleryNo") int galleryNo) {
		return galleryCommService.getCommentCnt(galleryNo);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryComm/add", produces="application/json")
	public Map<String, Object> add(GalleryCommDTO comment, HttpServletRequest request) {
		return galleryCommService.addComment(comment, request);
	}
	
	@ResponseBody
	@GetMapping(value="/galleryComm/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return galleryCommService.getCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryComm/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("galleryCommNo") int galleryCommNo){
		return galleryCommService.removeComment(galleryCommNo);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryComm/reply/add", produces="application/json")
	public Map<String, Object> replyAdd(GalleryCommDTO reply){
		return galleryCommService.addReply(reply);
	}
	
}