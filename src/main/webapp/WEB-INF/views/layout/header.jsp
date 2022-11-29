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
	padding-top: 20px;
  border:1px solid #000;
}

.header_top_menu_area {
	margin:10px auto 0px;
    display: flex;
    justify-content: space-around;
    align-items: center;
	background-color: #faebd7;
}

.header_top_menu_area li{
	
	width: 100%;
	text-align: center;
	outline: 1px solid #000;

}
.header_top_menu_area li:hover{
	font-weight: bold;
	background-color: #eec794;
}
.header_top_menu_area li a{
	display: block;
	padding: 10px;
}

</style>
</head>
<body>
	
	<div class="header_wrap">
		we are best team
		<h1>2조 Semi Project   header 임</h1>
		<ul class="header_top_menu_area">
			<li><a href="${contextPath}/user/login">로그인</a></li>
			<li><a href="${contextPath}/user/join">회원가입</a></li>
			<li><a href="${contextPath}/user/info">회원정보</a></li>
			<li><a href="${contextPath}/bbs/list">자유게시판</a></li>
			<li><a href="${contextPath}/gallery/list">이미지게시판</a></li>
			<li><a href="${contextPath}/upload/list">업로드게시판</a></li>
			<li><a href="${contextPath}/admin/adminIndex">관리자게시판</a></li>		
		</ul>	
		
	</div>
	

</body>
</html>