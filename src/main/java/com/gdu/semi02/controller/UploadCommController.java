package com.gdu.semi02.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi02.domain.UploadCommDTO;
import com.gdu.semi02.service.UploadCommService;

@Controller
public class UploadCommController {

	@Autowired
	private UploadCommService commentService;
	
	@ResponseBody
	@GetMapping(value="/comment/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("uploadNo") int uploadNo) {
		return commentService.getCommentCount(uploadNo);
	}
	
	@ResponseBody
	@PostMapping(value="/comment/add", produces="application/json")
	public Map<String, Object> add(UploadCommDTO comment, HttpServletRequest request) {
		return commentService.addComment(comment, request);
	}
	
	@ResponseBody
	@GetMapping(value="/comment/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return commentService.getCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/comment/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("uploadCommNo") int uploadCommNo) { // CommentNo만 받으면되니까 requestParam으로 바로 받아줌
		return commentService.removeComment(uploadCommNo);
	}
	
	@ResponseBody
	@PostMapping(value="/comment/reply/add", produces="application/json")
	public Map<String, Object> addReply(UploadCommDTO reply, HttpServletRequest request) {
		return commentService.addReply(reply, request);
	}
}
