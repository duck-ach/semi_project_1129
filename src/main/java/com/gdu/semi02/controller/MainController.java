package com.gdu.semi02.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.semi02.service.BbsService;
import com.gdu.semi02.service.GalleryService;
import com.gdu.semi02.service.UploadService;

@Controller
public class MainController {
	
	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private GalleryService galleryService;
	
	@Autowired
	private UploadService uploadService;
	
	@GetMapping("/")
	public String index(HttpServletRequest request, Model model) {
		bbsService.findAllBbsList(request, model);
		galleryService.getGalleryList(request, model);
		uploadService.getUploadList(request, model);
		return "index";
	}
	
}
