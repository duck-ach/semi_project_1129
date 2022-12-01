package com.gdu.semi02.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi02.domain.BbsCommDTO;
import com.gdu.semi02.service.BbsCommService;

@Controller
public class BbsCommController {

	@Autowired
	private BbsCommService bbsCommService;
	
	@ResponseBody
	@GetMapping(value="/bbsComm/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("bbsNo") int bbsNo){
		return bbsCommService.getBbsCommentCount(bbsNo);
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/bbsComm/add", produces="application/json")
	public Map<String, Object> add(BbsCommDTO bbsComm, HttpServletRequest request){
		return bbsCommService.addBbsComment(bbsComm, request);
	}
	
	
	@ResponseBody
	@GetMapping(value="/bbsComm/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request){
		return bbsCommService.getBbsCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/bbsComm/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("bbsCommNo") int bbsCommNo){
		return bbsCommService.removeBbsComment(bbsCommNo);
	}
	
	@ResponseBody
	@PostMapping(value="/bbsComm/reply/add", produces="application/json")
	public Map<String, Object> replyAdd(BbsCommDTO reply, HttpServletRequest request){
		return bbsCommService.addReply(reply, request);
	}
	
	
	
}
