package com.gdu.semi02.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class UploadUnloginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(request.getSession().getAttribute("loginUser") != null ) {
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('해당 기능은 로그인 후 사용할 수 있습니다.');");
			out.println("location.href='" + request.getContextPath() + "/user/login/form';");
			out.println("</script>");
			out.close();
			
			return false; 
		} else {
			return true;
		}
		
		
	}
	
}
