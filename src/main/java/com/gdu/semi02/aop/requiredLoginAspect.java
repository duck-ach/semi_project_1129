package com.gdu.semi02.aop;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
@EnableAspectJAutoProxy
@Aspect
public class requiredLoginAspect {

	@Pointcut("execution(* com.gdu.semi02.controller.*Controller.requiredLogin_*(..))")
	public void requiredLogin() { }
	
	@Before("requiredLogin()")
	public void requiredLoginHandler(JoinPoint joinPoint) throws Throwable {
		
		ServletRequestAttributes servletWebRequest = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		
		HttpServletRequest request = servletWebRequest.getRequest();
		HttpServletResponse response = servletWebRequest.getResponse();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") == null) {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("if(confirm('로그인이 필요한 기능입니다. 로그인 하시겠습니까?')) {;");
			out.println("location.href='" + request.getContextPath() + "/user/login/form';");
			out.println("} else {");
			out.println("history.back();");
			out.println("}");
			out.println("</script>");
			out.close();
			
		}

	}
	
}