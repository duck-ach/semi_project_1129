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
	$(function() {
		fn_checkAll();
		fn_checkOne();
		fn_toggleCheck();
		fn_submit();
	});
	
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
	
	function fn_submit() {
		$('#frm_agree').submit(function(event) {
			if($('#service').is(':checked') == false || $('#privacy').is(':checked') == false) {
				alert('필수 약관에 동의하세요.');
				event.preventDefault();
				return;
			}
		});
	}
</script>
<style>
	.blind {
		display: none;
	}
	.lbl_all, .lbl_one {
		padding-left: 20px;
		background-image: url(${contextPath}/resources/userImages/uncheck.png);
		background-size: 18px 18px;
		background-repeat: no-repeat;
	}
	.lbl_checked {
		background-image:  url(${contextPath}/resources/userImages/check.png);
	}
</style>
</head>
<body>

	<div>
	
		<h1>약관 동의하기</h1>
		
		<form id="frm_agree" action="${contextPath}/user/join/write">
		
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
				<input type="button" value="취소" onclick="history.back();">
				<button>다음</button>
			</div>
			
		</form>
		
	</div>

</body>
</html>