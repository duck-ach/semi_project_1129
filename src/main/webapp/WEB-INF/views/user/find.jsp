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

	$

</script>
</head>
<body>

	<h1>아이디 찾기</h1>
	<div>
		<label for="find_name">이름</label>
		<input type="text" name="find_name" id="find_name"><br>
		<label for="find_email">이메일</label>
		<input type="text" name="find_email" id="find_email">
		<input type="button" value="인증번호받기" id="btn_getAuthCode">
		<span id="msg_email"></span><br>
		<input type="text" name="authCode" id="authCode" placeholder="인증코드 입력">
		<input type="button" value="인증하기" id="btn_verifyAuthCode"><br>
		<input type="button" value="아이디찾기" id="btn_find_id">
	</div>
	
	<hr>
	
	<h1>비밀번호 찾기</h1>
	<div>
		<label for="find_name">이름</label>
		<input type="text" name="find_name" id="find_name"><br>
		<label for="find_id">아이디</label>
		<input type="text" name="find_id" id="find_id"><br>
		<label for="find_email">이메일</label>
		<input type="text" name="find_email" id="find_email">
		<input type="button" value="인증번호받기" id="btn_getAuthCode">
		<span id="msg_email"></span><br>
		<input type="text" name="authCode" id="authCode" placeholder="인증코드 입력">
		<input type="button" value="인증하기" id="btn_verifyAuthCode"><br>
		<input type="button" value="비밀번호찾기" id="btn_find_id">
	</div>

</body>
</html>