<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
	
		fn_showHide();
		fn_init();
		fn_pwCheck();
		fn_pwCheckAgain();
		fn_pwSubmit();
		
	});
	
	var pwPass = false;
	var rePwPass = false;
	
	function fn_showHide(){
		
		$('#modify_pw_area').hide();
		
		$('#btn_edit_pw').click(function(){
			fn_init();
			$('#modify_pw_area').show();
			
		});
		
		$('#btn_edit_pw_cancel').click(function(){
			fn_init();
			$('#modify_pw_area').hide();
			
		});
		
	}
	
	function fn_init(){
		$('#pw').val('')
		$('#re_pw').val('')
		$('#msg_pw').text('');
		$('#msg_re_pw').text('');
	}
	
	function fn_pwCheck(){
		
		$('#pw').keyup(function(){
			
			let pwValue = $(this).val();
			
			let regPw = /^[0-9a-zA-Z!@#$%^&*]{8,20}$/;
			
			let validatePw = /[0-9]/.test(pwValue) 
			               + /[a-z]/.test(pwValue) 
			               + /[A-Z]/.test(pwValue) 
			               + /[!@#$%^&*]/.test(pwValue); 
			
			if(regPw.test(pwValue) == false || validatePw < 3){
				$('#msg_pw').text('8~20자의 소문자, 대문자, 숫자, 특수문자(!@#$%^&*)를 3개 이상 조합해야 합니다.');
				pwPass = false;
			} else {
				$('#msg_pw').text('사용 가능한 비밀번호입니다.');
				pwPass = true;
			}
			               
		});
		
	}
	
	function fn_pwCheckAgain(){
		
		$('#re_pw').keyup(function(){
			
			let rePwValue = $(this).val();
			
			if(rePwValue != '' && rePwValue != $('#pw').val()){
				$('#msg_re_pw').text('비밀번호를 확인하세요.');
				rePwPass = false;
			} else {
				$('#msg_re_pw').text('');
				rePwPass = true;
			}
			
		});
		
	}
	
	function fn_pwSubmit(){
		
		$('#frm_edit_pw').submit(function(event){
			
			if(pwPass == false || rePwPass == false){
				alert('비밀번호 입력을 확인하세요.');
				event.preventDefault();
				return;
			}
			
		});	
	}
	
</script>
</head>
<body>

	<div>
		
		<h1>마이페이지</h1>
		
		<form>
			<div>
				<label for="id">아이디*</label>
				<input type="text" name="id" id="id" readonly value="${user.id}">
				<span id="msg_id"></span>
			</div>
			
			<div>
				<label for="name">이름*</label>
				<input type="text" name="name" id="name" value="${user.name}">
			</div>
			
			<div>
				<label for="none">선택 안함</label>
				<input type="radio" name="gender" id="none" value="NO" checked="checked">
				<label for="male">남자</label>
				<input type="radio" name="gender" id="male" value="M">
				<label for="female">여자</label>
				<input type="radio" name="gender" id="female" value="F">
			</div>
		
			<div>
				<label for="mobile">휴대전화*</label>
				<input type="text" name="mobile" id="mobile" placeholder=" - 제외">
				<span id="msg_mobile"></span>
			</div>
		
			<div>
				<label for="birthyear">생년월일*</label>
				<select name="birthyear" id="birthyear"></select>
				<select name="birthmonth" id="birthmonth"></select>
				<select name="birthdate" id="birthdate"></select>				
			</div>
			
			<div>
				<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="우편번호" readonly>
				<input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소" readonly>
				<input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소" readonly><br>
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
				<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목" readonly>
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			</div>
			
			<div>
				<label for="email">이메일*</label>
				<input type="text" name="email" id="email">
				<input type="button" value="인증번호받기" id="btn_getAuthCode">
				<span id="msg_email"></span><br>
				<input type="text" name="authCode" id="authCode" placeholder="인증코드 입력">
				<input type="button" value="인증하기" id="btn_verifyAuthCode">
			</div>
		</form>
		
		<div>
			<input type="button" value="비밀번호변경" id="btn_edit_pw">
		</div>
		<div id="modify_pw_area">
			<form id="frm_edit_pw" action="${contextPath}/user/modify/pw" method="post">
				<div>
					<label for="pw">비밀번호</label>
					<input type="password" name="pw" id="pw">
					<span id="msg_pw"></span>
				</div>
				
				<div>
					<label for="re_pw">비밀번호 확인</label>
					<input type="password" id="re_pw">
					<span id="msg_re_pw"></span>
				</div>
				<div>
					<button>비밀번호 변경하기</button>
					<input type="button" value="취소하기" id="btn_edit_pw_cancel">
				</div>
			</form>
		</div>
		
		
		<a href="javascript:fn_abc()">회원탈퇴</a>
		<form id="lnk_retire" action="${contextPath}/user/retire" method="post"></form>
		<script>
			function fn_abc(){
				if(confirm('탈퇴하시겠습니까?')){
					$('#lnk_retire').submit();
				}
			}
		</script>
		
	</div>
	

</body>
</html>