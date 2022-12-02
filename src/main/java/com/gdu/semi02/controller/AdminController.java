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
import com.gdu.semi02.domain.SleepUserDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.service.AdminService;
import com.gdu.semi02.service.BbsService;
import com.gdu.semi02.service.GalleryService;
import com.gdu.semi02.service.UploadService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BbsService bbsService;
	
	
	@Autowired
	private GalleryService galleryService;
	
	@Autowired
	private UploadService uploadService;
	
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
	
	@ResponseBody
	@GetMapping(value="/searchSleepAllUsers", produces="application/json; charset=UTF-8")
	public List<SleepUserDTO> sleepList(HttpServletRequest request, Model model) {
		return adminService.selectSleepAllUsers(model, request);
	}
	
	
	 
	
	
	
	@PostMapping("/admin/remove")
	public String remove(@RequestParam List<String> userNo, HttpServletResponse response, HttpServletRequest request ) {
		for (String c : userNo) {
			adminService.removeUsers(c,  response,  request );
		}
        return "/admin/remove";
	}
	
	
	@PostMapping("/admin/sleep")
	public String sleep(@RequestParam List<String> userNo, HttpServletResponse response, HttpServletRequest request ) {
		for (String c : userNo) {
			adminService.SleepAllUsers(c,  response,  request );
		}
        return "/admin/sleep";
	}

	
	@GetMapping("/admin/removeAdmin")
	public String requiredAdmin_removeAdmin() {
		return "admin/removeAdmin";
	}
	
	@GetMapping("/admin/sleepAdmin")
	public String requiredAdmin_sleepAdmin() {
		return "admin/sleepAdmin";
	}
	
	
	
	
	
   @GetMapping("/admin/bbsAdmin")
   public String requiredAdmin_bbsAdmin(HttpServletRequest request, Model model) {
      bbsService.findAllBbsList(request, model);
      return "admin/bbsAdmin";
   }
	
	
	@GetMapping("/admin/galleryAdmin")
	public String list(HttpServletRequest request, Model model) {
		galleryService.getGalleryList(request, model);
		return "admin/galleryAdmin";
	}
	
	@GetMapping("/admin/uploadAdmin")
	public String requiredAdmin_uploadAdminlist(HttpServletRequest request, Model model) {
		uploadService.getUploadList(request, model);
		return "admin/uploadAdmin";
	}
	
	@PostMapping("/upload/adminRemove")
	public String requiredLogin_remove(HttpServletRequest request, HttpServletResponse response) {
		uploadService.removeUpload(request, response);
		return "redirect:/admin/uploadAdmin";
	}
	
}
