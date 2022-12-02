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
  	
  	color:#fff;
  	overflow: hidden;
}

.header_top_menu_area {
	margin:10px auto 0px;
    display: flex;
    justify-content: space-around;
    align-items: center;
	background-color: #d0c2ee;
	 border-radius:0 0 14px 14px;
}

.header_top_menu_area li{
	position:relative;	
	width: 100%;
	height:40px;
	text-align: center;
/*	outline: 1px solid #000;*/

	line-height: 45px;
	color:#fff;
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
    left: 0px;
    width: 100%;
    height: 100px;
    /*
    background-color:#8572ee;
    */
    background-color: #d0c2ee;
    border-radius: 14px 14px 0 0;
    
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

.top_gnb_btn_area{
	position: relative;
	
}

.top_login_btn_area{
position:absolute;
	top:0;
	right:0px;
	transition: all 0.3s ease-in-out;
}
.top_login_area{
	position:absolute;
	top:300px;
	right:-850px;
	border:1px solid #000;
	width:100px; 
	height:100px;
	border-radius: 15px;
	background: linear-gradient(135deg, #6e8efb, #a777e3);
	transition: all 0.3s ease-in-out;
}
.top_login_area_move{right:75px !important ;  }
.top_login_area span{
	display:block;	
	padding:5px 5px;
	border-bottom: 1px solid #fff;
	width:70%;
	margin:0 auto;
	text-align: center;
}
.top_login_area span a{color:#fff; }
h1 a{text-decoration: none; color:#000 !important;}

/*** 햄버거 영역  ***/
/* GRID */

.twelve { width: 100%; }
.eleven { width: 91.53%; }
.ten { width: 83.06%; }
.nine { width: 74.6%; }
.eight { width: 66.13%; }
.seven { width: 57.66%; }
.six { width: 49.2%; }
.five { width: 40.73%; }
.four { width: 32.26%; }
.three { width: 23.8%; }
.two { width: 15.33%; }
.one { width: 6.866%; }

/* COLUMNS */

.col {
  display: block;
  float:left;
  margin: 1% 0 1% 1.6%;
}

.col:first-of-type {
  margin-left: 0;
}

.container{
  width: 100%;
  max-width: 940px;
  margin: 0 auto;
  position: relative;
  text-align: center;
}

/* CLEARFIX */

.cf:before,
.cf:after {
    content: " ";
    display: table;
}

.cf:after {
    clear: both;
}

.cf {
    *zoom: 1;
}

/* ALL */

.row .three{
  padding: 80px 30px;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  background-color: #2c3e50;
  color: #ecf0f1;
  text-align: center;
}

.hamburger .line{
  width: 50px;
  height: 5px;
  background-color: #ecf0f1;
  display: block;
  margin: 8px auto;
  -webkit-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}

.hamburger:hover{
  cursor: pointer;
}

/* ONE */

#hamburger-1.is-active .line:nth-child(2){
  opacity: 0;
}

#hamburger-1.is-active .line:nth-child(1){
  -webkit-transform: translateY(13px) rotate(45deg);
  -ms-transform: translateY(13px) rotate(45deg);
  -o-transform: translateY(13px) rotate(45deg);
  transform: translateY(13px) rotate(45deg);
}

#hamburger-1.is-active .line:nth-child(3){
  -webkit-transform: translateY(-13px) rotate(-45deg);
  -ms-transform: translateY(-13px) rotate(-45deg);
  -o-transform: translateY(-13px) rotate(-45deg);
  transform: translateY(-13px) rotate(-45deg);
}

/* TWO */

#hamburger-2.is-active .line:nth-child(1){
  -webkit-transform: translateY(13px);
  -ms-transform: translateY(13px);
  -o-transform: translateY(13px);
  transform: translateY(13px);
}

#hamburger-2.is-active .line:nth-child(3){
  -webkit-transform: translateY(-13px);
  -ms-transform: translateY(-13px);
  -o-transform: translateY(-13px);
  transform: translateY(-13px);
}

/* THREE */

#hamburger-3.is-active .line:nth-child(1),
#hamburger-3.is-active .line:nth-child(3){
  width: 40px;
}

#hamburger-3.is-active .line:nth-child(1){
  -webkit-transform: translateX(-10px) rotate(-45deg);
  -ms-transform: translateX(-10px) rotate(-45deg);
  -o-transform: translateX(-10px) rotate(-45deg);
  transform: translateX(-10px) rotate(-45deg);
}

#hamburger-3.is-active .line:nth-child(3){
  -webkit-transform: translateX(-10px) rotate(45deg);
  -ms-transform: translateX(-10px) rotate(45deg);
  -o-transform: translateX(-10px) rotate(45deg);
  transform: translateX(-10px) rotate(45deg);
}

/* FOUR */

#hamburger-4.is-active .line:nth-child(1),
#hamburger-4.is-active .line:nth-child(3){
  width: 40px;
}

#hamburger-4.is-active .line:nth-child(1){
  -webkit-transform: translateX(10px) rotate(45deg);
  -ms-transform: translateX(10px) rotate(45deg);
  -o-transform: translateX(10px) rotate(45deg);
  transform: translateX(10px) rotate(45deg);
}

#hamburger-4.is-active .line:nth-child(3){
  -webkit-transform: translateX(10px) rotate(-45deg);
  -ms-transform: translateX(10px) rotate(-45deg);
  -o-transform: translateX(10px) rotate(-45deg);
  transform: translateX(10px) rotate(-45deg);
}

/* FIVE */

#hamburger-5.is-active{
  -webkit-transform: rotate(90deg);
  -ms-transform: rotate(90deg);
  -o-transform: rotate(90deg);
  transform: rotate(90deg);
}

#hamburger-5.is-active .line:nth-child(2){
  -webkit-transition: none;
  -o-transition: none;
  transition: none;
}

#hamburger-5 .line:nth-child(2){
  -webkit-transition-delay: 0.3s;
  -o-transition-delay: 0.3s;
  transition-delay: 0.3s;
}


#hamburger-5.is-active .line:nth-child(2){
  opacity: 0;
}

#hamburger-5.is-active .line:nth-child(1),
#hamburger-5.is-active .line:nth-child(3){
  width: 35px;
  -webkit-transform-origin: right;
  -moz-transform-origin: right;
  -ms-transform-origin: right;
  -o-transform-origin: right;
  transform-origin: right;
}

#hamburger-5.is-active .line:nth-child(1){
  -webkit-transform: translateY(15px) rotate(45deg);
  -ms-transform: translateY(15px) rotate(45deg);
  -o-transform: translateY(15px) rotate(45deg);
  transform: translateY(15px) rotate(45deg);
}

#hamburger-5.is-active .line:nth-child(3){
  -webkit-transform: translateY(-15px) rotate(-45deg);
  -ms-transform: translateY(-15px) rotate(-45deg);
  -o-transform: translateY(-15px) rotate(-45deg);
  transform: translateY(-15px) rotate(-45deg);
}

/* SIX */

#hamburger-6.is-active{
  -webkit-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
  -webkit-transition-delay: 0.6s;
  -o-transition-delay: 0.6s;
  transition-delay: 0.6s;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  -o-transform: rotate(45deg);
  transform: rotate(45deg);
}

#hamburger-6.is-active .line:nth-child(2){
  width: 0px;
}

#hamburger-6.is-active .line:nth-child(1),
#hamburger-6.is-active .line:nth-child(3){
  -webkit-transition-delay: 0.3s;
  -o-transition-delay: 0.3s;
  transition-delay: 0.3s;
}

#hamburger-6.is-active .line:nth-child(1){
  -webkit-transform: translateY(13px);
  -ms-transform: translateY(13px);
  -o-transform: translateY(13px);
  transform: translateY(13px);
}

#hamburger-6.is-active .line:nth-child(3){
  -webkit-transform: translateY(-13px) rotate(90deg);
  -ms-transform: translateY(-13px) rotate(90deg);
  -o-transform: translateY(-13px) rotate(90deg);
  transform: translateY(-13px) rotate(90deg);
}

/* SEVEN */

#hamburger-7.is-active .line:nth-child(1){
  width: 30px;
}

#hamburger-7.is-active .line:nth-child(2){
  width: 40px;
}

#hamburger-7.is-active .line{
  -webkit-transform: rotate(30deg);
  -ms-transform: rotate(30deg);
  -o-transform: rotate(30deg);
  transform: rotate(30deg);
}

/* EIGHT */

#hamburger-8.is-active .line:nth-child(2){
  opacity: 0;
}

#hamburger-8.is-active .line:nth-child(1){
  -webkit-transform: translateY(13px);
  -ms-transform: translateY(13px);
  -o-transform: translateY(13px);
  transform: translateY(13px);
}

#hamburger-8.is-active .line:nth-child(3){
  -webkit-transform: translateY(-13px) rotate(90deg);
  -ms-transform: translateY(-13px) rotate(90deg);
  -o-transform: translateY(-13px) rotate(90deg);
  transform: translateY(-13px) rotate(90deg);
}

/* NINE */

#hamburger-9{
  position: relative;
  -webkit-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}

#hamburger-9.is-active{
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  -o-transform: rotate(45deg);
  transform: rotate(45deg);
}

#hamburger-9:before{
  content: "";
  position: absolute;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  width: 70px;
  height: 70px;
  border: 5px solid transparent;
  top: calc(50% - 35px);
  left: calc(50% - 35px);
  border-radius: 100%;
  -webkit-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}

#hamburger-9.is-active:before{
  border: 5px solid #ecf0f1;
}

#hamburger-9.is-active .line{
  width: 35px;
}

#hamburger-9.is-active .line:nth-child(2){
  opacity: 0;
}

#hamburger-9.is-active .line:nth-child(1){
  -webkit-transform: translateY(13px);
  -ms-transform: translateY(13px);
  -o-transform: translateY(13px);
  transform: translateY(13px);
}

#hamburger-9.is-active .line:nth-child(3){
  -webkit-transform: translateY(-13px) rotate(90deg);
  -ms-transform: translateY(-13px) rotate(90deg);
  -o-transform: translateY(-13px) rotate(90deg);
  transform: translateY(-13px) rotate(90deg);
}

/* TEN */

#hamburger-10{
  -webkit-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}

#hamburger-10.is-active{
  -webkit-transform: rotate(90deg);
  -ms-transform: rotate(90deg);
  -o-transform: rotate(90deg);
  transform: rotate(90deg);
}

#hamburger-10.is-active .line:nth-child(1){
  width: 30px
}

#hamburger-10.is-active .line:nth-child(2){
  width: 40px
}

/* ELEVEN */

#hamburger-11{
  -webkit-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}

#hamburger-11.is-active{
  animation: smallbig 0.6s forwards;
}

@keyframes smallbig{
  0%, 100%{
    -webkit-transform: scale(1);
    -ms-transform: scale(1);
    -o-transform: scale(1);
    transform: scale(1);
  }

  50%{
    -webkit-transform: scale(0);
    -ms-transform: scale(0);
    -o-transform: scale(0);
    transform: scale(0);
  }
}

#hamburger-11.is-active .line:nth-child(1),
#hamburger-11.is-active .line:nth-child(2),
#hamburger-11.is-active .line:nth-child(3){
  -webkit-transition-delay: 0.2s;
  -o-transition-delay: 0.2s;
  transition-delay: 0.2s;
}

#hamburger-11.is-active .line:nth-child(2){
  opacity: 0;
}

#hamburger-11.is-active .line:nth-child(1){
  -webkit-transform: translateY(13px) rotate(45deg);
  -ms-transform: translateY(13px) rotate(45deg);
  -o-transform: translateY(13px) rotate(45deg);
  transform: translateY(13px) rotate(45deg);
}

#hamburger-11.is-active .line:nth-child(3){
  -webkit-transform: translateY(-13px) rotate(-45deg);
  -ms-transform: translateY(-13px) rotate(-45deg);
  -o-transform: translateY(-13px) rotate(-45deg);
  transform: translateY(-13px) rotate(-45deg);
}

/* TWELVE */

#hamburger-12.is-active .line:nth-child(1){
  opacity: 0;
  -webkit-transform: translateX(-100%);
  -ms-transform: translateX(-100%);
  -o-transform: translateX(-100%);
  transform: translateX(-100%);
}

#hamburger-12.is-active .line:nth-child(3){
  opacity: 0;
  -webkit-transform: translateX(100%);
  -ms-transform: translateX(100%);
  -o-transform: translateX(100%);
  transform: translateX(100%);
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	  $(".hamburger").click(function(){
	    $(this).toggleClass("is-active");
	    $('.top_login_area').toggleClass("top_login_area_move");
	    
	  });
	  
	 
	});

</script>

</head>
<body>
	
	<div class="header_wrap">
	<div class="top_gnb_btn_area" >
		we are best team
		<h1><a href="${contextPath}/">2조 Semi Project   header 임</a></h1>
		<div class="top_login_btn_area">
			<div class="three col">
		        <div class="hamburger" id="hamburger-6">
		          <span class="line"></span>
		          <span class="line"></span>
		          <span class="line"></span>
		        </div>
		    </div>
		</div>
		
	</div>
		<div class="top_login_area">
			<span><a href="${contextPath}/user/login/form">로그인</a></span>
			<br>
			<span><a href="${contextPath}/user/join">회원가입</a></span>
		</div>
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