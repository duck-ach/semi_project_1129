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
<style type="text/css">
.master_area{
	border:1px solid #fff;
	cursor:pointer;
}

h1{color:#fff;}

body {
  background: #000;
  padding: 2rem;
}

h2 {
  font-family: 'Arial';
  color: #fff;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 3rem;
  line-height: 0.75;
}

span {
  display: block;
  margin:15px 0;
  line-height: 50px;
}

span:not(.light) {
  opacity: 0;
  animation: flashText .5s ease-out alternate infinite;
}

span.light {
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
</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.master_area').click(function(){
		location.href= '${contextPath}/admin/adminIndex';
		 
	})
	
	
})

</script>
</head>
<body>
	
	<h1>이곳은 인덱스 임</h1>
	
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
	
</body>
</html>