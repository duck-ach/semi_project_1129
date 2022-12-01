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

import com.gdu.semi02.domain.UserDTO;

@EnableAspectJAutoProxy
@Component
@Aspect

public class RequiredAdminAspect {
	
	@Pointcut("execution(* com.gdu.semi02.controller.*Controller.requiredAdmin_*(..))")	
	public void requiredAdmin() {}
	
	@Before("requiredAdmin()") // 포인트컷 실행 전에 requiredLogin() 메소드 실행
	public void requiredAdminAspect(JoinPoint joinPoint) throws Throwable{
		
		// 로그인이 되어있는지 확인하기 위해서 sesstion이 필요하므로,
		// request가 필요하다.
		// 응답을 만들기 위해서 response도 필요하다.
		ServletRequestAttributes servletWebRequest = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = servletWebRequest.getRequest();
		HttpServletResponse response = servletWebRequest.getResponse();
		
		
		// 세션
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("loginUser");
		System.out.println("유저정보  getId는"+user.getId());
		System.out.println("유저정보는 getName "+user.getName());
		// 로그인 여부 확인
		if(!user.getId().equals("admin")) {
			
	//	if(session.getAttribute("loginUser") == null) {
	       response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	            
            out.println("<script>");
            out.println("if(confirm('접근 권한 밖입니다. 정상적인 경로를 이용해주세요.')) {");
            out.println("location.href='"+ request.getContextPath() +"/';");
            out.println("} else {");
            out.println("history.back();");
            out.println("}");
            out.println("</script>");

            out.close();
		
		}
		
		
	}
	
	
	
	
	
}
