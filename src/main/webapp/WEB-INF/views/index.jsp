<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="layout/header.jsp">
	<jsp:param value="프로젝트_메인" name="title" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인덱스_메인</title>
 <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
    />
<style type="text/css">
a{
	text-decoration: none;
	color:#fff;
}
.master_area{
	border:1px solid #fff;
	cursor:pointer;
	background-color: #000;
}

.h1{color:#fff;}

body {
 /* background: #000;*/
  padding: 2rem;
}

.master_area h2 {
  font-family: 'Arial';
  color: #fff;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 3rem;
  line-height: 0.75;
}

.master_area span {
  display: block;
  margin:15px 0;
  line-height: 50px;
}
  
.master_area span:not(.light) {
  opacity: 0;
  animation: flashText .5s ease-out alternate infinite;
}

.master_area span.light {
  position: relative;
  display: inline-block;
  
  &:before {
    position: absolute;
    left: 0;
    top: -10%;
    width: 100%;
    height: 120%;
    background: #fff;
    filter: blur(10px);
    content: "";
    opacity: 0;
    animation: flash .5s ease-out alternate infinite;
  }
}

@keyframes flash{
  to {
    opacity: 1;
  }
}

@keyframes flashText {
  to {
    opacity: 0.15;
  }
}


.wrap{
	outline: #fff;
	width:70%;
	margin:50px auto;
}

.boxss{
	width:100%;
	height: 200px;

}
.team_area{
	position: relative;
	width:800px;
	margin:50px auto;

}
    

      .swiper {
        width: 800px;
        height: 600px;
        /*
        position: absolute;
        left: 50%;
        top: 50%;
        
        margin-left: -150px;
        */
        margin-top: -150px;
        background-color: #fff;
    	overflow: hidden;
}
      .swiper-slide {
        background-position: center;
        background-size: cover;
      }
		.swiper-slide p{
			position: absolute;
			right:0;
			top:0;
			width:20%;
			 font-family: 'Black Han Sans', sans-serif;
	font-size:25px;
			
		}
      .swiper-slide img {
        display: block;
        width: 70%;
      }
	
	
	
	.boards_box_area{
		display:flex;
	    justify-content: space-between;
	    margin:0 auto 40px;
}
	
	.boards_box{
		width:400px;
		height:400px; 
		border:3px solid #cbb8ee;
		position:relative;
		border-radius:0 20px 20px 20px;
	}
	
	.boards_box span{
		position:absolute;
		padding:20px;
		top:0;
		left:0;
		color:#000;
		font-size: 24px;
	}
	
	.boards_box i{
		position:absolute;
		padding:10px;
		top:0;
		right:0;
		color:#000;
		font-size: 30px;
		font-style: unset;
	}
	
	.boards_box div{
		width:100%;
		height:90px;
	
	}
	
	.boards_box p{
		color:#000;
		font-size:20px;
		width:90%;
		margin:0 auto 10px;
	}
	.boards_box p::after{
	content:"";
	}
	.boards_box p:hover::after{
	
	display:block;
	width:70%;
	height:2px;
	float:left;
	border-bottom: 1px solid #cbb8ee;
}
.boards_box p a{
	color:#000;
}



</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.master_area').click(function(){
		location.href= '${contextPath}/admin/adminIndex';
		 
	})
	
	
})

</script>
</head>
<body>
	
	<div class="wrap">
		<div class="boxss">
		</div>
	<div class="team_area">    
    <div class="swiper mySwiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/juno.png">
          <p>
          	안녕하세요. <br>
          	신준호 입니다.
          	저는 조장입니다.
          	돈 내놓으세요 십새들아
          </p>
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/ny.png">
          <p>
          	안녕하세요.   <br>
          	김나영 입니다.
          	저는 조장입니다.
          	돈 내놓으세요 십새들아
          </p>
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/jw.png">
          <p>
          	안녕하세요.   <br>
          	박지원 입니다.
          	저는 조장입니다.
          	돈 내놓으세요 십새들아
          </p>
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/hr.png">
          <p>
          	안녕하세요.   <br>
          	엄희라 입니다.
          	저는 조장입니다.
          	돈 내놓으세요 십새들아
          </p>
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/jh.png">
           <p>
          	안녕하세요.   <br>
          	이정행 입니다.
          	저는 조장입니다.
          	돈 내놓으세요 십새들아
          </p>
        </div>
      </div>
      <div class="swiper-pagination"></div>   
    </div>    
	
	</div>
		
	<div class="boxss">
		</div>
	<div class="boards_box_area">
		<div class="boards_box">
			<span>자유 게시판</span>
			<i>+</i>
			<div></div>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
		</div>
		<div class="boards_box">
			<span>갤러리 게시판</span>
			<i>+</i>
			<div></div>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
		</div>
		<div class="boards_box">
			<span>업로드 게시판</span>
			<i>+</i>
			<div></div>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
			<p><a href=>최근 작성글 입니다~~~~~~~~~</a></p>
		</div>
	
	</div>
	
	<c:if test="${loginUser.id == 'admin'}">
		<div class="master_area"  >
			
			<h2>
			  <span>어서오세요 주인님</span>  
			  <span>제가 볼 때는</span> 
			  <span>다른 팀들보다</span>  
			  <span>우리팀이 최고입니다 주인님 (굽신굽신)</span>
			  <span class="light">관리자 페이지로 이동</span> 
			  
			</h2>
					
		</div>
	</c:if>
	
	
	
	
	
	
	
	
	</div><!-- wrap -->
	
	
	<script>
      var swiper = new Swiper(".mySwiper", {
        effect: "cube",
        grabCursor: true,
        autoplay: {
            delay: 2500,
            disableOnInteraction: false,
          },
        cubeEffect: {
          shadow: true,
          slideShadows: true,
          shadowOffset: 20,
          shadowScale: 0.94,
        },
        pagination: {
          el: ".swiper-pagination",
        },
      });
    </script>
	
</body>
</html>