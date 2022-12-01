package com.gdu.semi02.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	
	@GetMapping("/admin/adminIndex")
	public String requiredAdmin_adminIndex() {
		return "admin/adminIndex";
	}
	
	
	
	@GetMapping("/admin/userAdmin")
	public String requiredAdmin_userAdmin() {
		return "admin/userAdmin";
	}
	
	
	
	@ResponseBody
	@GetMapping(value="/searchAllUsers", produces="application/json; charset=UTF-8")
	public List<UserDTO> list(Model model, HttpServletRequest request) {
		return adminService.getAllUserList(model, request);
	}

	@ResponseBody
	@GetMapping(value="/searchUser", produces="application/json; charset=UTF-8")
	public List<UserDTO> getSearchUser(HttpServletRequest request, Model model) {
		
		return adminService.findSearchUserList(request, model);
	}
	
	
	@ResponseBody
	@GetMapping(value="/searchRemoveAllUsers", produces="application/json; charset=UTF-8")
	public List<RetireUserDTO> Removelist(Model model, HttpServletRequest request) {
		return adminService.selectRemoveAllUsers(model, request);
	}
	
	
	 
	
	
	
	@PostMapping("/admin/remove")
	public String remove(@RequestParam List<String> userNo, HttpServletResponse response, HttpServletRequest request ) {
		for (String c : userNo) {
			adminService.removeUsers(c,  response,  request );
		}
        return "/admin/remove";
	}

	
	@GetMapping("/admin/removeAdmin")
	public String requiredAdmin_removeAdmin() {
		return "admin/removeAdmin";
	}
	
	/*
	@PostMapping("/admin/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		adminService.removeUsers(request, response);
	}
	*/
	
}
