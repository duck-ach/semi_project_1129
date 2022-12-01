<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Optional<String> opt = Optional.ofNullable(request.getParameter("title"));
	String title = opt.orElse("Welcome");
	pageContext.setAttribute("title", title);  // EL사용을 위함 (${title})
	pageContext.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>${title}</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<style type="text/css">

	body, button, dd, dl, dt, fieldset, form, h1, h2, h3, h4, h5, h6, input, legend, li, ol, p, select, table, td, textarea, th, ul {
    margin: 0;
    padding: 0;
}

a{
	text-decoration: none;
	color:#000;
}	
li{list-style: none;}

.header_wrap{
	width:70%;
	margin:0 auto;
	padding-top: 20px;
  	border:1px solid #000;
  	color:#fff;
}

.header_top_menu_area {
	margin:10px auto 0px;
    display: flex;
    justify-content: space-around;
    align-items: center;
	background-color: #d0c2ee;
}

.header_top_menu_area li{
	position:relative;	
	width: 100%;
	height:40px;
	text-align: center;
/*	outline: 1px solid #000;*/
	overflow:hidden;
	line-height: 45px;
	color:#000;
	font-family: 'Black Han Sans', sans-serif;
	font-size:25px;
}
.header_top_menu_area li:hover{
	/*font-weight: bold;*/
/*	background-color: #eec794;*/
/*	border-bottom:1px solid #8572ee; */
}


.header_top_menu_area li span {
    display: block;
    position: absolute;
    bottom: -110px;
    left: -440px;
    width: 100%;
    height: 100px;
    background-color:#8572ee;
    
    opacity:0.2;
}
.header_top_menu_area li:hover span{
	left: 0px;
	bottom:0px;
/*	border-bottom:2px solid #8572ee;*/
	transition: all ease 0.5s 0s;
}

.header_top_menu_area li span a{
	display: block;
	width:100%;
	height: 100%;
	
}


h1 a{text-decoration: none; color:#fff !important;}
</style>
</head>
<body>
	
	<div class="header_wrap">
		we are best team
		<h1><a href="${contextPath}/">2조 Semi Project   header 임</a></h1>
		<ul class="header_top_menu_area">
		<!--  
			<li><a href="${contextPath}/user/login/form">로그인</a></li>
			<li><a href="${contextPath}/user/join">회원가입</a></li>
			<li><a href="${contextPath}/user/info">회원정보</a></li>
		-->
			
			<li>
				자유게시판
				<span><a href="${contextPath}/bbs/list"></a></span>
			</li>
			<li>
				갤러리게시판
				<span><a href="${contextPath}/gallery/list"></a></span>
			</li>
			<li>
				업로드게시판
				<span><a href="${contextPath}/upload/list"></a></span>
			</li>
			<!--  
			<li><a href="${contextPath}/admin/adminIndex">관리자게시판</a></li>	
			-->	
		</ul>	
		
	</div>
	

</body>
</html>