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

	$function(){
		id_search();
		pw_search();
	}

	function id_search() { 
	 	var frm = document.frm_find_id;
	
	 	if (frm.find_name.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }
	
			frm.method = "post";
			frm.action = "findIdResult.jsp";
			frm.submit();  
	 }
	
	function pw_search() { 
	 	var frm = document.frm_find_pw;
	
	 	if (frm.find_name.value.length < 1) {
			alert("이름을 입력해주세요");
			return;
		}
	
			frm.method = "post";
			frm.action = "findPwResult.jsp";
			frm.submit();  
	 }

</script>
</head>
<body>

	<h1>아이디 찾기</h1>
	<form name="frm_find_id" method="post">
		<div>
			<label for="find_name">이름</label>
			<input type="text" name="find_name" id="find_name"><br>
			<label for="find_email">이메일*</label>
			<input type="text" name="find_email" id="find_email" value="${profile.email}">
			<input type="button" value="중복체크" id="btn_check">
			<span id="msg_email"></span><br>
			<input type="button" value="아이디찾기" id="btn_find_id">
		</div>
	</form>
	
	<hr>
	
	<h1>비밀번호 찾기</h1>
	<form name="frm_find_pw" method="post">
		<div>
			<label for="find_name">이름</label>
			<input type="text" name="find_name" id="find_name"><br>
			<label for="find_id">아이디</label>
			<input type="text" name="find_id" id="find_id"><br>
			<label for="find_email">이메일*</label>
			<input type="text" name="find_email" id="find_email" value="${profile.email}">
			<input type="button" value="중복체크" id="btn_check">
			<span id="msg_email"></span><br>
			<input type="button" value="비밀번호찾기" id="btn_find_pw">
		</div>
	</form>

</body>
</html>