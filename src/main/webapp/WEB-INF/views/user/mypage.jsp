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
	
		fn_mobileCheck();
		fn_emailCheck();
		fn_init();
		fn_pwCheck();
		fn_pwCheckAgain();
		
	});
	
	var mobilePass = false;
	var emailPass = false;
	var pwPass = false;
	var rePwPass = false;
	
	function fn_mobileCheck(){
		
		$('#mobile').keyup(function(){
			
			let mobileValue = $(this).val();
			
			let regMobile = /^010[0-9]{7,8}$/;
			
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('휴대전화를 확인하세요.');
				mobilePass = false;
			} else {
				$('#msg_mobile').text('');
				mobilePass = true;
			}
			
		}); 
		
	}
	
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
	
</script>
</head>
<body>

	<div>
		
		<h1>마이페이지</h1>
		
			<form id="frm_edit_info" action="${contextPath}/user/modify/info" method="post">
			
				<div>
					아이디 : ${loginUser.id}
				</div>
							
				<div>
					레벨 : ${loginUser.userLevel}
				</div>
							
				<div>
					포인트 : ${loginUser.point}
				</div>
				
				<div>
					이름 : ${loginUser.name}
				</div>
				
				<div>
					성별 : ${loginUser.gender}
				</div>
			
				<div>
					<label for="mobile">휴대전화*</label>
					<input type="text" name="mobile" id="mobile" placeholder=" - 제외" value="${loginUser.mobile}">
					<span id="msg_mobile"></span>
				</div>
			
				<div>
					생년월일 : ${loginUser.birthyear}${loginUser.birthday}
				</div>
				
				<div>
					<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="우편번호" readonly value="${loginUser.postcode}">
					<input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소" readonly value="${loginUser.roadAddress}">
					<input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소" readonly value="${loginUser.jibunAddress}"><br>
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${loginUser.detailAddress}">
					<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목" readonly value="extraAddress">
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				</div>
				
				<div>
					<label for="email">이메일*</label>
					<input type="text" name="email" id="email" value="${loginUser.email}">
					<input type="button" value="중복체크" id="btn_check">
					<span id="msg_email"></span>
				</div>
				
				<div>
					<button>개인정보 변경하기</button>
					<input type="button" value="취소하기" id="btn_edit_info_cancel">
				</div>
				
			</form>
		
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
					<input type="button" value="취소하기">
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
		

</body>
</html>