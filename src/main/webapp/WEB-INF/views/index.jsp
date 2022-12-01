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
.master_area{
	border:1px solid #fff;
	cursor:pointer;
}

.h1{color:#fff;}

body {
  background: #000;
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


    

      .swiper {
        width: 300px;
        height: 300px;
        position: absolute;
        left: 50%;
        top: 50%;
        margin-left: -150px;
        margin-top: -150px;
      } 

      .swiper-slide {
        background-position: center;
        background-size: cover;
      }

      .swiper-slide img {
        display: block;
        width: 100%;
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
		
	<div class="team_area">    
    <div class="swiper mySwiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/juno.png">
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/ny.png">
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/jw.png">
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/hr.png">
        </div>
        <div class="swiper-slide">
          <img src="${contextPath}/resources/image/jh.png">
        </div>
      </div>
      <div class="swiper-pagination"></div>   
    </div>    
	
	</div>
		
	
	
	
	<c:if test="${loginUser.id == 'admin'}">
		<div class="master_area">
			
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