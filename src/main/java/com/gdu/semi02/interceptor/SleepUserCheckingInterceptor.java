package com.gdu.semi02.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gdu.semi02.domain.SleepUserDTO;
import com.gdu.semi02.service.UserService;


@Component
public class SleepUserCheckingInterceptor implements HandlerInterceptor {

	@Autowired
	private UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String id = request.getParameter("id");
		
		SleepUserDTO sleepUser = userService.getSleepUserById(id);
		
		HttpSession session = request.getSession();
		session.setAttribute("sleepUser", sleepUser);
		
		if(sleepUser != null) {
			response.sendRedirect(request.getContextPath() + "/user/sleep/display");
			return false;
		}
		else {
			return true;
		}
		
	}
	
}