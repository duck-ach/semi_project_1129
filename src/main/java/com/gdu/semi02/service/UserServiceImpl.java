package com.gdu.semi02.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.semi02.domain.RetireUserDTO;
import com.gdu.semi02.domain.SleepUserDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.UserMapper;
import com.gdu.semi02.util.SecurityUtil;

@PropertySource(value = {"classpath:email.properties"})
@Service
public class UserServiceImpl implements UserService {

	@Value(value = "${mail.username}")
	private String username;
	
	@Value(value="${mail.password}")
	private String password;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private SecurityUtil securityUtil;
	
	@Override
	public Map<String, Object> isReduceId(String id) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", userMapper.selectUserByMap(map) != null);
		result.put("isRetireUser", userMapper.selectRetireUserById(id) != null);
		return result;
		
	}
	
	@Override
	public Map<String, Object> isReduceEmail(String email) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", userMapper.selectUserByMap(map) != null);
		return result;
		
	}
	
	@Override
	public Map<String, Object> sendAuthCode(String email) {
		
		String authCode = securityUtil.getAuthCode(6);
		System.out.println("발송된 인증코드 : " + authCode);
		
		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		
		try {
			
			Message message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(username, "인증코드관리자"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("[Application] 인증 요청 메일입니다.");
			message.setContent("인증번호는 <strong>" + authCode + "</strong>입니다.", "text/html; charset=UTF-8");
			
			Transport.send(message);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("authCode", authCode);
		return result;
		
	}
	
	@Transactional
	@Override
	public void join(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthdate = request.getParameter("birthdate");
		String postcode = request.getParameter("postcode");
		String roadAddress = request.getParameter("roadAddress");
		String jibunAddress = request.getParameter("jibunAddress");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String promotion = request.getParameter("promotion");
		
		pw = securityUtil.sha256(pw);
		name = securityUtil.preventXSS(name);
		String birthday = birthmonth + birthdate;
		detailAddress = securityUtil.preventXSS(detailAddress);
		int agreeCode = 0;
		if(!location.isEmpty() && promotion.isEmpty()) {
			agreeCode = 1;
		} else if(location.isEmpty() && !promotion.isEmpty()) {
			agreeCode = 2;
		} else if(!location.isEmpty() && !promotion.isEmpty()) {
			agreeCode = 3;
		}
		
		UserDTO user = UserDTO.builder()
				.id(id)
				.pw(pw)
				.name(name)
				.gender(gender)
				.email(email)
				.mobile(mobile)
				.birthyear(birthyear)
				.birthday(birthday)
				.postcode(postcode)
				.roadAddress(roadAddress)
				.jibunAddress(jibunAddress)
				.detailAddress(detailAddress)
				.extraAddress(extraAddress)
				.agreeCode(agreeCode)
				.build();
				
		int result = userMapper.insertUser(user);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				
				request.getSession().setAttribute("loginUser", userMapper.selectUserByMap(map));
				
				int updateResult = userMapper.updateAccessLog(id);
				if(updateResult == 0) {
					userMapper.insertAccessLog(id);
				}
				
				out.println("<script>");
				out.println("alert('회원 가입되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('회원 가입에 실패했습니다.');");
				out.println("history.go(-2);");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	@Override
	public void retire(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		
		RetireUserDTO retireUser = RetireUserDTO.builder()
				.userNo(loginUser.getUserNo())
				.id(loginUser.getId())
				.joinDate(loginUser.getJoinDate())
				.build();
		
		int deleteResult = userMapper.deleteUser(loginUser.getUserNo());
		int insertResult = userMapper.insertRetireUser(retireUser);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(deleteResult > 0 && insertResult > 0) {
				
				session.invalidate();
				
				out.println("<script>");
				out.println("alert('회원 탈퇴되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('회원 탈퇴에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) {
		
		String url = request.getParameter("url");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		pw = securityUtil.sha256(pw);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		
		UserDTO loginUser = userMapper.selectUserByMap(map);
		
		if(loginUser != null) {
			
			keepLogin(request, response);
			
			request.getSession().setAttribute("loginUser", loginUser);

			int updateResult = userMapper.updateAccessLog(id);
			if(updateResult == 0) {
				userMapper.insertAccessLog(id);
			}
			
			try {
				response.sendRedirect(url);
			} catch(IOException e) {
				e.printStackTrace();
			}
			
		}
		else {

			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('일치하는 회원 정보가 없습니다.');");
				out.println("location.href='" + request.getContextPath() + "';");
				out.println("</script>");
				out.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}
	
	@Override
	public void keepLogin(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");
		String keepLogin = request.getParameter("keepLogin");
		
		if(keepLogin != null) {
			
			String sessionId = request.getSession().getId();
			
			Cookie cookie = new Cookie("keepLogin", sessionId);
			cookie.setMaxAge(60 * 60 * 24 * 15);
			cookie.setPath(request.getContextPath());
			response.addCookie(cookie);
			
			UserDTO user = UserDTO.builder()
					.id(id)
					.sessionId(sessionId)
					.sessionLimitDate(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 15))
					.build();

			userMapper.updateSessionInfo(user);
			
		}
		else {
			
			Cookie cookie = new Cookie("keepLogin", "");
			cookie.setMaxAge(0);
			cookie.setPath(request.getContextPath());
			response.addCookie(cookie);
			
		}
		
	}
	
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			session.invalidate();
		}
		
		Cookie cookie = new Cookie("keepLogin", "");
		cookie.setMaxAge(0); 
		cookie.setPath(request.getContextPath());
		response.addCookie(cookie);
		
	}
	
	@Override
	public UserDTO getUserBySessionId(Map<String, Object> map) {
		return userMapper.selectUserByMap(map);
	}
	
	@Override
	public Map<String, Object> confirmPassword(HttpServletRequest request) {

		String pw = securityUtil.sha256(request.getParameter("pw"));
		
		HttpSession session = request.getSession();
		String id = ((UserDTO)session.getAttribute("loginUser")).getId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		
		UserDTO user = userMapper.selectUserByMap(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", user != null);
		return result;
		
	}
	
	
	@Override
	public void modifyInfo(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		UserDTO loginUser = ((UserDTO)session.getAttribute("loginUser"));
		
		
		String postcode = request.getParameter("postcode"); 
		String roadAddress = request.getParameter("roadAddress");
		String jibunAddress = request.getParameter("jibunAddress");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		
		
		String id = loginUser.getId();
		/*
		 * String postcode = loginUser.getPostcode(); String roadAddress =
		 * loginUser.getRoadAddress(); String jibunAddress =
		 * loginUser.getJibunAddress(); String detailAddress =
		 * loginUser.getDetailAddress(); String extraAddress =
		 * loginUser.getExtraAddress(); String mobile = loginUser.getMobile(); String
		 * email = loginUser.getEmail();
		 */
		
		UserDTO user = UserDTO.builder()
				.id(id)
				.postcode(postcode)
				.roadAddress(roadAddress)
				.jibunAddress(jibunAddress)
				.detailAddress(detailAddress)
				.extraAddress(extraAddress)
				.mobile(mobile)
				.email(email)
				.build();
		
		int result = userMapper.updateUserInfo(user);
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				loginUser.setId(id);
				loginUser.setPostcode(postcode);
				loginUser.setJibunAddress(jibunAddress);
				loginUser.setDetailAddress(detailAddress);
				loginUser.setExtraAddress(extraAddress);
				loginUser.setMobile(mobile);
				loginUser.setEmail(email);
				
				out.println("<script>");
				out.println("alert('정보가 수정되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/user/mypage';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('정보가 수정되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	
	@Override
	public void modifyPassword(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		UserDTO loginUser = ((UserDTO)session.getAttribute("loginUser"));
		
		String pw = securityUtil.sha256(request.getParameter("pw"));
		
		if(pw.equals(loginUser.getPw())) {

			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		String id = loginUser.getId();
		
		UserDTO user = UserDTO.builder()
				.id(id)
				.pw(pw)
				.build();
		
		int result = userMapper.updateUserPassword(user);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				loginUser.setPw(pw);
				
				out.println("<script>");
				out.println("alert('비밀번호가 수정되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/user/mypage';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('비밀번호가 수정되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	@Override
	public void sleepUserHandle() {
		int insertCount = userMapper.insertSleepUser();
		if(insertCount > 0) {
			userMapper.deleteUserForSleep();
		}
	}
	
	@Override
	public SleepUserDTO getSleepUserById(String id) {
		return userMapper.selectSleepUserById(id);
	}
	
	@Transactional
	@Override
	public void restoreUser(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		SleepUserDTO sleepUser = (SleepUserDTO)session.getAttribute("sleepUser");
		String id = sleepUser.getId();
		
		int insertCount = userMapper.insertRestoreUser(id);
		int deleteCount = 0;
		if(insertCount > 0) {
			deleteCount = userMapper.deleteSleepUser(id);
		}
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(insertCount > 0 && deleteCount > 0) {
				
				out.println("<script>");
				out.println("alert('휴면 계정이 복구되었습니다. 휴면 계정 활성화를 위해 곧바로 로그인을 해 주세요.');");
				out.println("location.href='" + request.getContextPath() + "/user/login/form';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('휴면 계정이 복구되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
				
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
			
	}
	
	@Override
	public String getNaverLoginApiURL(HttpServletRequest request) {
	    
		String apiURL = null;
		
		try {
			
			String clientId = "bRRJOp5FZR_iFTOgpM3k";
			String redirectURI = URLEncoder.encode("http://localhost:9090" + request.getContextPath() + "/user/naver/login", "UTF-8");  
			SecureRandom random = new SecureRandom();
			String state = new BigInteger(130, random).toString();
			
			apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			apiURL += "&client_id=" + clientId;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&state=" + state;
			
			HttpSession session = request.getSession();
			session.setAttribute("state", state);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return apiURL;
		
	}
	
	@Override
	public String getNaverLoginToken(HttpServletRequest request) {
		
		String clientId = "bRRJOp5FZR_iFTOgpM3k";
		String clientSecret = "diyC_RRtYP";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		
		String redirectURI = null;
		try {
			redirectURI = URLEncoder.encode("http://localhost:9090" + request.getContextPath(), "UTF-8");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		StringBuffer res = new StringBuffer();
		try {
			
			String apiURL;
			apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
			apiURL += "client_id=" + clientId;
			apiURL += "&client_secret=" + clientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			con.disconnect();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		JSONObject obj = new JSONObject(res.toString());
		String access_token = obj.getString("access_token");
		return access_token;
		
	}
	
	@Override
	public UserDTO getNaverLoginProfile(String access_token) {
		
		String header = "Bearer " + access_token;
		
		StringBuffer sb = new StringBuffer();
		
		try {
			
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();
			con.disconnect();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		UserDTO user = null;
		try {
			
			JSONObject profile = new JSONObject(sb.toString()).getJSONObject("response");
			String id = profile.getString("id");
			String name = profile.getString("name");
			String gender = profile.getString("gender");
			String email = profile.getString("email");
			String mobile = profile.getString("mobile").replaceAll("-", "");
			String birthyear = profile.getString("birthyear");
			String birthday = profile.getString("birthday").replace("-", "");
			
			user = UserDTO.builder()
					.id(id)
					.name(name)
					.gender(gender)
					.email(email)
					.mobile(mobile)
					.birthyear(birthyear)
					.birthday(birthday)
					.build();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return user;
		
	}
	
	@Override
	public UserDTO getNaverUserById(String id) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		return userMapper.selectUserByMap(map);
		
	}
	
	@Transactional
	@Override
	public void naverLogin(HttpServletRequest request, UserDTO naverUser) {
		
		request.getSession().setAttribute("loginUser", naverUser);
		
		String id = naverUser.getId();
		int updateResult = userMapper.updateAccessLog(id);
		if(updateResult == 0) {
			userMapper.insertAccessLog(id);
		}
		
	}
	
	@Override
	public void naverJoin(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthdate = request.getParameter("birthdate");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String promotion = request.getParameter("promotion");
		
		name = securityUtil.preventXSS(name);
		String birthday = birthmonth + birthdate;
		String pw = securityUtil.sha256(birthyear + birthday);  
		
		int agreeCode = 0;  
		if(location != null && promotion == null) {
			agreeCode = 1; 
		} else if(location == null && promotion != null) {
			agreeCode = 2; 
		} else if(location != null && promotion != null) {
			agreeCode = 3; 
		}
		
		UserDTO user = UserDTO.builder()
				.id(id)
				.pw(pw)
				.name(name)
				.gender(gender)
				.email(email)
				.mobile(mobile)
				.birthyear(birthyear)
				.birthday(birthday)
				.agreeCode(agreeCode)
				.snsType("naver") 
				.build();
				
		int result = userMapper.insertNaverUser(user);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				
				request.getSession().setAttribute("loginUser", userMapper.selectUserByMap(map));
				
				int updateResult = userMapper.updateAccessLog(id);
				if(updateResult == 0) {
					userMapper.insertAccessLog(id);
				}
				
				out.println("<script>");
				out.println("alert('회원 가입되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('회원 가입에 실패했습니다.');");
				out.println("history.go(-2);");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
}