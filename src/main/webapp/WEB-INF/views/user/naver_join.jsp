<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/agree.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/agree.css" />
<script>
	
	$(function(){
		fn_emailCheck();
		fn_checkAll();
		fn_checkOne();
		fn_toggleCheck();
		fn_join();
	});
	
	var emailPass = false;
	
	function fn_emailCheck(){	
		$('#btn_check').click(function(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/user/checkReduceEmail',
				data: 'email=' + $('#email').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						$('#msg_email').text('이미 사용중인 이메일입니다.');
						emailPass = false;
					} else {
						$('#msg_email').text('사용 가능한 이메일입니다.');
						emailPass = true;
					}
				}
			});
		});
	}
	
	function fn_checkAll() {
		$('#check_all').click(function() {
			$('.check_one').prop('checked', $(this).prop('checked'));
			if($(this).is(':checked')) {
				$('.lbl_one').addClass('lbl_checked');
			} else {
				$('.lbl_one').removeClass('lbl_checked');
			}
		});
	}
	
	function fn_checkOne() {
		$('.check_one').click(function() {
			let checkCount = 0;
			for(let i = 0; i < $('.check_one').length; i++) {
				checkCount += $($('.check_one')[i]).prop('checked');
			}
			$('#check_all').prop('checked', $('.check_one').length == checkCount);
			if($('#check_all').is(':checked')) {
				$('.lbl_all').addClass('lbl_checked');
			} else{
				$('.lbl_all').removeClass('lbl_checked');
			}
		});
	}
	
	function fn_toggleCheck() {
		$('.lbl_all, .lbl_one').click(function() {
			$(this).toggleClass('lbl_checked');
		});
	}
	
	function fn_join(){
		$('#frm_join').submit(function(event){
			if(emailPass == false){
				alert('${profile.id}');
				alert('이메일을 확인하세요.');
				event.preventDefault();
				return;
			}
			if($('#service').is(':checked') == false || $('#privacy').is(':checked') == false){
				alert('필수 약관에 동의하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
</script>
</head>
<body>

	<div>
	
		<h1>네이버 간편 가입</h1>
	
		<div>* 표시는 필수 입력사항입니다.</div>
		
		<hr>
		
		<form id="frm_join" action="${contextPath}/user/naver/join" method="post">
		
			<input type="hidden" name="id" id="id" value="${profile.id}">
			
			
			
			<div>
				<label for="name">이름*</label>
				<input type="text" name="name" id="name" value="${profile.name}">
			</div>
			
			<div>
				<input type="radio" name="gender" id="none" value="NO" checked="checked">
				<label for="none">선택 안함</label>
				<input type="radio" name="gender" id="male" value="M">
				<label for="male">남자</label>
				<input type="radio" name="gender" id="female" value="F">
				<label for="female">여자</label>
				<script>
					$(':radio[name="gender"][value="${profile.gender}"]').prop('checked', true);
				</script>
			</div>
		
			<div>
				<label for="mobile">휴대전화*</label>
				<input type="text" name="mobile" id="mobile" value="${profile.mobile}">
			</div>
		
			<div>
				<label for="birthyear">생년월일*</label>
				<input type="text" name="birthyear" id="birthyear" value="${profile.birthyear}">
				<input type="text" name="birthmonth" id="birthmonth" value="${profile.birthday.substring(0,2)}">
				<input type="text" name="birthdate" id="birthdate" value="${profile.birthday.substring(2)}">
			</div>
			
			<div>
				<label for="email">이메일*</label>
				<input type="text" name="email" id="email" value="${profile.email}">
				<input type="button" value="중복체크" id="btn_check">
				<span id="msg_email"></span>
			</div>
			
			<hr>
			
			<div>
				<input type="checkbox" id="check_all" class="blind">
				<label for="check_all" class="lbl_all">모두 동의</label>
			</div>
			
			<hr>
			
			<div>
				<input type="checkbox" id="service" class="check_one blind">
				<label for="service" class="lbl_one">이용약관 동의(필수)</label>
				<div>
					<textarea>본 약관은 ...</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="privacy" class="check_one blind">
				<label for="privacy" class="lbl_one">개인정보수집 동의(필수)</label>
				<div>
					<textarea>개인정보보호법에 따라 ...</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="location" name="location" class="check_one blind">
				<label for="location" class="lbl_one">위치정보수집 동의(선택)</label>
				<div>
					<textarea>위치정보 ...</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="promotion" name="location" class="check_one blind">
				<label for="promotion" class="lbl_one">마케팅 동의(선택)</label>
				<div>
					<textarea>이벤트 ...</textarea>
				</div>
			</div>
			
			<hr>
			
			<div>
				<button>가입하기</button>
				<input type="button" value="취소하기" onclick="history.back();">
			</div>
		
		</form>
	
	</div>

</body>
</html>