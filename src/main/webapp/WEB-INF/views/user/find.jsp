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
<script>

	$(function(){
		fn_idCheck();
		fn_pwCheck();
	});

	function fn_idCheck(){
		$('#btn_find_id').click(function(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/user/find/id',
				data: 'email=' + $('#id_find_email').val() + '&name=' + $('#id_find_name').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.user){
						alert('회원님의 아이디는 \'' + resData.user.id + '\' 입니다');
						return;
					} else if(resData.sleepUser) {
						alert('회원님의 아이디는 \'' + resData.sleepUser.id + '\' 입니다');
						return;
					} else if(resData){
						alert('탈퇴했거나 없는 아이디입니다.');
					}
				}
			});
			
		})
	}
	
	function fn_pwCheck(){
		$('#btn_find_pw').click(function(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/user/find/pw',
				data: 'email=' + $('#pw_find_email').val() + '&name=' + $('#pw_find_name').val() + '&id=' + $('#pw_find_id').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.user){
						alert('회원님의 임시 비밀번호를 메일로 전송했습니다. 로그인해주세요.');
						location.href='${contextPath}/user/modify/pwac';
						return;
					} else if(resData.sleepUser){
						alert('회원님의 임시 비밀번호를 메일로 전송했습니다. 로그인해주세요.');
						location.href='${contextPath}/user/modify/pwac';
						return;
					} else {
						alert(resData.authCode);
						alert('일치하는 회원정보가 없습니다. 다시 확인해주세요.');
					}
				}
			});
			
		})
	}  

</script>
</head>
<body>

	<h1>아이디 찾기</h1>
	<form name="frm_find_id" method="post">
		<div>
			<label for="id_find_name">이름</label>
			<input type="text" name="id_find_name" id="id_find_name"><br>
			<label for="id_find_email">이메일*</label>
			<input type="text" name="id_find_email" id="id_find_email" value="${loginUser.email}">
			<input type="button" value="중복체크" id="btn_check">
			<span id="msg_email"></span><br>
			<input type="button" value="아이디찾기" id="btn_find_id">
		</div>
	</form>
	
	<hr>
	
	<h1>비밀번호 찾기</h1>
	<form name="frm_find_pw" method="post">
		<div>
			<label for="pw_find_name">이름</label>
			<input type="text" name="pw_find_name" id="pw_find_name"><br>
			<label for="pw_find_id">아이디</label>
			<input type="text" name="pw_find_id" id="pw_find_id"><br>
			<label for="pw_find_email">이메일*</label>
			<input type="text" name="pw_find_email" id="pw_find_email" value="${loginUser.email}">
			<input type="button" value="중복체크" id="btn_check">
			<span id="msg_email"></span><br>
			<input type="button" value="비밀번호찾기" id="btn_find_pw">
		</div>
	</form>

</body>
</html>