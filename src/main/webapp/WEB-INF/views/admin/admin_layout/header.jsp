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
<!-- 
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<style type="text/css">

	body, button, dd, dl, dt, fieldset, form, h1, h2, h3, h4, h5, h6, input, legend, li, ol, p, select, table, td, textarea, th, ul {
    margin: 0;
    padding: 0;
}
/* 베스트팀 시작  */
#bestTeam_area{
	background-color:#000;
	padding:20px 0;
	text-align:center;
	cursor:pointer;
}
@font-face {
  font-family: neon;
  src: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/707108/neon.ttf);
}

.container {
/*  display: table-cell;*/
  text-align: center;
  vertical-align: middle;
  
}

.neon {
  font-family: neon;
  color: #FB4264;
  font-size: 9vw;
  line-height: 9vw;
  text-shadow: 0 0 3vw #F40A35;
}

.flux {
  font-family: neon;
  color: #426DFB;
  font-size: 9vw;
  line-height: 9vw;
  text-shadow: 0 0 3vw #2356FF;
}

.neon {
  animation: neon 1s ease infinite;
  -moz-animation: neon 1s ease infinite;
  -webkit-animation: neon 1s ease infinite;
}

@keyframes neon {
  0%,
  100% {
    text-shadow: 0 0 1vw #FA1C16, 0 0 3vw #FA1C16, 0 0 10vw #FA1C16, 0 0 10vw #FA1C16, 0 0 .4vw #FED128, .5vw .5vw .1vw #806914;
    color: #FED128;
  }
  50% {
    text-shadow: 0 0 .5vw #800E0B, 0 0 1.5vw #800E0B, 0 0 5vw #800E0B, 0 0 5vw #800E0B, 0 0 .2vw #800E0B, .5vw .5vw .1vw #40340A;
    color: #806914;
  }
}

.flux {
  animation: flux 2s linear infinite;
  -moz-animation: flux 2s linear infinite;
  -webkit-animation: flux 2s linear infinite;
  -o-animation: flux 2s linear infinite;
}

@keyframes flux {
  0%,
  100% {
    text-shadow: 0 0 1vw #1041FF, 0 0 3vw #1041FF, 0 0 10vw #1041FF, 0 0 10vw #1041FF, 0 0 .4vw #8BFDFE, .5vw .5vw .1vw #147280;
    color: #28D7FE;
  }
  50% {
    text-shadow: 0 0 .5vw #082180, 0 0 1.5vw #082180, 0 0 5vw #082180, 0 0 5vw #082180, 0 0 .2vw #082180, .5vw .5vw .1vw #0A3940;
    color: #146C80;
  }
}

/* 베스트팀 끝  */


@keyframes bestTeam{
  10%{background:#c00; } 
  25%{background:#c0c; }
  45%{background:#f1c5d1; }
  60%{background:#c7254e; }
  80%{background:#FFFFAF; }
  100%{background:#93CC8D; }
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

.head_area{
	position: relative;
	height:80px;
	background-color: antiquewhite;
}

.header_top_menu_area {
	position: relative;
	margin:0px auto 0px;
	height: 100%;
    display: flex;
    justify-content: space-around;
    align-items: center;
	
}



.header_top_menu_area .header_top_menu_area_li{
	padding-top:30px;
	position: relative;
	width: 100%;
	height: 50px;
	text-align: center;
	outline: 1px solid #000;

}
.header_top_menu_area .header_top_menu_area_li:hover{
	font-weight: bold;
}
.header_top_menu_area .header_top_menu_area_li a{
	display: block;
	padding: 10px;
}


.close_ul_area{
	width: 100%;
	position:absolute;
	top:80px;
	background-color: cornsilk;
	display:none;
	
}
.close_ul_area a{
	display: block;
	width: 100%;
	text-align: center;
}


.wrap{
	width:80%; 
	margin:20px auto;
}
</style>
<script type="text/javascript">
$(function(){
	
	$('.header_top_menu_area_li').hover(function(){
		$('.close_ul_area').hide();
		$(this).children('.close_ul_area').show();
	}, function() {
		$('.close_ul_area').hide();
    });
	
	
	$('#bestTeam_area').click(function(){
		location.href='${contextPath}/';
	})
	
	
	
});
</script>
</head>
<body>
	<!--  
	<h1 id="bestTeam">we are best team</h1>
	-->
	<div id="bestTeam_area" >
		<div class="container">
		  <div class="neon">we are </div>
		  <div class="flux">best team </div>
		</div>
	</div>
	
		
	<div class="header_wrap" > 
		<div class="head_area" >
			
			<ul class="header_top_menu_area">
				<li class="header_top_menu_area_li">
					회원
					<ul class="close_ul_area">
						<li> <a href="${contextPath}/admin/userAdmin">- 전체유저 정보 및 탈퇴시키기</a> </li>		
						<li> <a href="${contextPath}/admin/removeAdmin">- 탈퇴한 유저 조회</a> </li>		
						<li> <a href="${contextPath}/admin/sleepAdmin">- 휴면 유저 조회</a> </li>						
					</ul>
				</li>
				<li class="header_top_menu_area_li">
					자유 게시판
					<ul class="close_ul_area">
						<li> <a href="${contextPath}/admin/bbsAdmin">-자유게시판 리스트 및 삭제</a></li>						
					</ul>
				</li>

				<li class="header_top_menu_area_li">
					이미지 게시판
					<ul class="close_ul_area">
						<li> <a href="${contextPath}/admin/galleryAdmin">- 이미지 게시판 리스트 및 삭제</a> </li>						
					</ul>
				</li>

				<li class="header_top_menu_area_li">
					업로드/다운게시판
					<ul class="close_ul_area">
						<li> <a href="${contextPath}/admin/uploadAdmin">- 업로드 게시판 리트트 및 삭제</a> </li>						
					</ul>
				</li>		


			</ul>


		</div>
	</div>

</body>
</html>