package com.gdu.semi02.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.semi02.domain.BbsDTO;

public interface BbsService {

	public void findAllBbsList(Model model);
	public void saveBbs(HttpServletRequest request, HttpServletResponse response);
	public int increaseBbsHit(int bbsNo);
	public BbsDTO getBbsByNo(int bbsNo);
	public void modifyBbs(HttpServletRequest request, HttpServletResponse response);
	public void removeBbs(HttpServletRequest request, HttpServletResponse response);
}
