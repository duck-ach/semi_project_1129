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
		fn_pwCheckAgain();
		fn_nameCheck();
		fn_mobileCheck();
		fn_birthyear();
		fn_birthmonth();
		fn_birthdate();
		fn_emailCheck();
		fn_join();
	});
	
	var idPass = false;
	var pwPass = false;
	var rePwPass = false;
	var namePass = false;
	var mobilePass = false;
	var authCodePass = false;
	
	function fn_idCheck(){
		
		$('#id').keyup(function(){
			
			let idValue = $(this).val();
			
			let regId = /^[0-9a-z][0-9a-z-_]{3,19}$/;
			
			if(regId.test(idValue) == false){
				$('#msg_id').text('4~20자의 소문자, 숫자, 특수문자(-,_)를 조합해야 합니다.');
				idPass = false;
				return; 
			}
			
			$.ajax({
				type: 'get',
				url: '${contextPath}/user/checkReduceId',
				data: 'id=' + idValue,
				dataType: 'json',
				success: function(resData){   
					if(resData.isUser || resData.isRetireUser){
						$('#msg_id').text('이미 사용중이거나 탈퇴한 아이디입니다.');
						idPass = false;
					} else {
						$('#msg_id').text('사용 가능한 아이디입니다.');
						idPass = true;
					}
				}
			}); 
			
		});  
		
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
	
	function fn_nameCheck(){
		
		$('#name').keyup(function(){
			
			let nameValue = $(this).val();
			
			namePass = (nameValue != '');
			
		}); 
		
	}   
	
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
	
	function fn_birthyear(){
		let year = new Date().getFullYear();
		let strYear = '<option value="">년도</option>';
		for(let y = year - 100; y <= year + 1; y++){
			strYear += '<option value="' + y + '">' + y + '</option>';
		}
		$('#birthyear').append(strYear);
	}  
	
	function fn_birthmonth(){
		let strMonth = '<option value="">월</option>';
		for(let m = 1; m <= 12; m++){
			if(m < 10){
				strMonth += '<option value="0' + m + '">' + m + '월</option>';
			} else {
				strMonth += '<option value="' + m + '">' + m + '월</option>';
			}
		}
		$('#birthmonth').append(strMonth);
	}  
	
	function fn_birthdate(){
		
		$('#birthdate').append('<option value="">일</option>');
		
		$('#birthmonth').change(function(){
			
			$('#birthdate').empty();
			$('#birthdate').append('<option value="">일</option>');
			let endDay = 0;
			let strDay = '';
			switch($(this).val()){
			case '02':
				endDay = 29; break;
			case '04':
			case '06':
			case '09':
			case '11':
				endDay = 30; break;
			default:
				endDay = 31; break;
			}
			for(let d = 1; d <= endDay; d++){
				if(d < 10){
					strDay += '<option value="0' + d + '">' + d + '일</option>';
				} else {
					strDay += '<option value="' + d + '">' + d + '일</option>';
				}
			}
			$('#birthdate').append(strDay);
			
		}); 
		
	} 
	
	function fn_emailCheck(){
		
		$('#btn_getAuthCode').click(function(){
			
			$('#authCode').prop('readonly', false);
			
			new Promise(function(resolve, reject) {
		
				let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
				
				let emailValue = $('#email').val();
				
				if(regEmail.test(emailValue) == false){
					reject(1);  
					authCodePass = false;
					return;  
				}
				
				$.ajax({
					type: 'get',
					url: '${contextPath}/user/checkReduceEmail',
					data: 'email=' + $('#email').val(),
					dataType: 'json',
					success: function(resData){
						if(resData.isUser){
							reject(2); 
						} else {
							resolve();  
						}
					}
				}); 
				
			}).then(function(){
				
				$.ajax({
					type: 'get',
					url: '${contextPath}/user/sendAuthCode',
					data: 'email=' + $('#email').val(),
					dataType: 'json',
					success: function(resData){
						alert('인증코드를 발송했습니다. 이메일을 확인하세요.');
						$('#btn_verifyAuthCode').click(function(){
							if(resData.authCode == $('#authCode').val()){
								alert('인증되었습니다.');
								authCodePass = true;
							} else {
								alert('인증에 실패했습니다.');
								authCodePass = false;
							}
						});
					},
					error: function(jqXHR){
						alert('인증번호 발송이 실패했습니다.');
						authCodePass = false;
					}
				}); 
				
			}).catch(function(code){ 
				switch(code){
				case 1:
					$('#msg_email').text('이메일 형식이 올바르지 않습니다.');
					break;
				case 2:
					$('#msg_email').text('이미 사용중인 이메일입니다.');
					break;
				}
			
				authCodePass = false;
			
				$('#authCode').prop('readonly', true);
				
			}); 
		}); 
	}  
	
	function fn_join(){
		
		$('#frm_join').submit(function(event){
			
			if(idPass == false){
				alert('아이디를 확인하세요.');
				event.preventDefault();
				return;
			} else if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if(namePass == false){
				alert('이름을 확인하세요.');
				event.preventDefault();
				return;
			} else if(mobilePass == false){
				alert('휴대전화번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if($('#birthyear').val() == '' || $('#birthmonth').val() == '' || $('#birthdate').val() == ''){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return;
			} else if(authCodePass == false){
				alert('이메일 인증을 받으세요.');
				event.preventDefault();
				return;
			}
			
		}); 
		
	}  
	
</script>
</head>
<body>

	<div>
	
		<h1>회원 가입</h1>
	
		<div>* 표시는 필수 입력사항입니다.</div>
		
		<hr>
		
		<form id="frm_join" action="${contextPath}/user/join" method="post">
		
			<input type="hidden" name="location" value="${location}">
			<input type="hidden" name="promotion" value="${promotion}">
		
			<div>
				<label for="id">아이디*</label>
				<input type="text" name="id" id="id">
				<span id="msg_id"></span>
			</div>
			
			<div>
				<label for="pw">패스워드*</label>
				<input type="password" name="pw" id="pw">
				<span id="msg_pw"></span>
			</div>
			
			<div>
				<label for="re_pw">패스워드 확인*</label>
				<input type="password" id="re_pw">
				<span id="msg_re_pw"></span>
			</div>
			
			<div>
				<label for="name">이름*</label>
				<input type="text" name="name" id="name">
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
				<script>
				    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
				    function fn_execDaumPostcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
				                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
				                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				                var roadAddr = data.roadAddress; // 도로명 주소 변수
				                var extraRoadAddr = ''; // 참고 항목 변수
				
				                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				                    extraRoadAddr += data.bname;
				                }
				                // 건물명이 있고, 공동주택일 경우 추가한다.
				                if(data.buildingName !== '' && data.apartment === 'Y'){
				                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                }
				                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				                if(extraRoadAddr !== ''){
				                    extraRoadAddr = ' (' + extraRoadAddr + ')';
				                }
				
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                document.getElementById('postcode').value = data.zonecode;
				                document.getElementById("roadAddress").value = roadAddr;
				                document.getElementById("jibunAddress").value = data.jibunAddress;
				                
				                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
				                if(roadAddr !== ''){
				                    document.getElementById("extraAddress").value = extraRoadAddr;
				                } else {
				                    document.getElementById("extraAddress").value = '';
				                }
				
				                var guideTextBox = document.getElementById("guide");
				                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				                if(data.autoRoadAddress) {
				                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
				                    guideTextBox.style.display = 'block';
				
				                } else if(data.autoJibunAddress) {
				                    var expJibunAddr = data.autoJibunAddress;
				                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
				                    guideTextBox.style.display = 'block';
				                } else {
				                    guideTextBox.innerHTML = '';
				                    guideTextBox.style.display = 'none';
				                }
				            }
				        }).open();
				    }
				</script>
			</div>
			
			<div>
				<label for="email">이메일*</label>
				<input type="text" name="email" id="email">
				<input type="button" value="인증번호받기" id="btn_getAuthCode">
				<span id="msg_email"></span><br>
				<input type="text" name="authCode" id="authCode" placeholder="인증코드 입력">
				<input type="button" value="인증하기" id="btn_verifyAuthCode">
			</div>
			
			<hr>
			
			<div>
				<button>가입하기</button>
				<input type="button" value="취소하기" onclick="location.href='${contextPath}'">
			</div>
		
		</form>
	
	</div>

</body>
</html>