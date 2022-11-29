<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="블로그목록" name="title" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
	$(function(){
		
		fn_login();
		fn_displayRememberId();
		
	});
	
	function fn_login(){
		
		$('#frm_login').submit(function(event){
			
			if($('#id').val() == '' || $('pw').val() == ''){
				alert('아이디와 패스워드를 모두 입력하세요.');
				event.preventDefault();
				return;
			}
			
			if($('#rememberId').is(':checked')){
				$.cookie('rememberId', $('#id').val());
			} else {
				$.cookie('rememberId', '');
			}
			
		});
		
	}
	
	function fn_displayRememberId(){
		
		let rememberId = $.cookie('rememberId');
		if(rememberId == ''){
			$('#id').val('');
			$('#rememberId').prop('checked', false);
		} else {
			$('#id').val(rememberId);
			$('#rememberId').prop('checked', true);
		}
		
	}
	
	
</script>
</head>
<body>
	
	<c:if test="${loginUser == null}">
	
		<div>
		
			<header>
			
				<h1>로그인</h1>
			</header>
			
			
			<section>
			
				<form id="frm_login" action="${contextPath}/user/login" method="post">
				
					<input type="hidden" name="url" value="${url}">
				
					<div>
					
						<label for="id">아이디</label>
						<input type="text" name="id" id="id" placeholder="아이디">
						<div id="id_msg"></div>
						
					</div>
						
					<div>
					
						<label for="pw">비밀번호</label>
						<input type="password" name="pw" id="pw" placeholder="비밀번호">
						<div id="pw_msg"></div>
						
						<button id="btn_signin" class="btn_signin">Sign In</button>
						
					</div>
					
					<div>			
						<label for="rememberId">
							<input type="checkbox" id="rememberId">
							아이디 저장
						</label>
						<label for="keepLogin">
							<input type="checkbox" name="keepLogin" id="keepLogin">
							로그인 유지
						</label>
					</div>
				
				</form>
				
			</section>
			
			<footer>
				
				<div>
					<a class="btn_footer" href="${contextPath}/user/agree">회원가입</a>
					<a class="btn_footer" href="${contextPath}/user/find">아이디/비밀번호 찾기</a>
				</div><br>
				
				<div>
				<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=bRRJOp5FZR_iFTOgpM3k&redirect_uri=http%3A%2F%2Flocalhost%3A9990%2Fsemi_pjt_2%2Fuser%2Fnaver%2Flogin&state=369583993916108389369394549118797326852"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
				</div>
				
			</footer>
			
		</div>
		
	</c:if>
	
	<c:if test="${loginUser != null}">
	
		<div>
			<a href="${contextPath}/user/check/form">${loginUser.name}</a> 님 반갑습니다.
		</div>
		<a href="${contextPath}/user/logout">로그아웃</a>
		
	</c:if>

</body>
</html>