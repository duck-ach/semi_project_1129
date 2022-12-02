package com.gdu.semi02.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.semi02.service.BbsService;

@Controller
public class BbsController {

	@Autowired
	private BbsService bbsService;
	
	@GetMapping("/bbs/list")
	public String list(HttpServletRequest request, Model model) {
		bbsService.findAllBbsList(request, model);
		return "bbs/list";
	}
	
	@GetMapping("/bbs/write")
	public String requiredLogin_write() {
		return "bbs/write";
	}
	
	@PostMapping("/bbs/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		bbsService.saveBbs(request, response);
	}
	
	@GetMapping("/bbs/increase/hit")
	public String increaseHit(@RequestParam(value="bbsNo", required=false, defaultValue="0") int bbsNo) {
		int result = bbsService.increaseBbsHit(bbsNo);
		if(result > 0) {			// 조회수 증가 성공하면 상세보기로 이동
			return "redirect:/bbs/detail?bbsNo=" + bbsNo;
		}else {						// 조회수 증가 실패하면 목록보기로 이동
			return "redirect:/bbs/list";
		}
	}
	
	@GetMapping("/bbs/detail")
	public String detail(@RequestParam(value="bbsNo", required=false, defaultValue="0") int bbsNo, Model model) {
		model.addAttribute("bbs", bbsService.getBbsByNo(bbsNo));
		return "bbs/detail";
	}
	
	
	@PostMapping("bbs/edit")
	public String requiredLogin_edit(int bbsNo, Model model) {
		model.addAttribute("bbs", bbsService.getBbsByNo(bbsNo));
		return "bbs/edit";
	}

	@PostMapping("bbs/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		bbsService.modifyBbs(request, response);
	}
	
	@PostMapping("bbs/remove")
	public void requiredLogin_remove(HttpServletRequest request, HttpServletResponse response) {
		bbsService.removeBbs(request, response);
	}
	
	
	
}
