<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="${bbs.bbsNo}번 게시글 수정" name="edit" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.js"></script> <!-- ajax 날짜 시간 처리 -->
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.css">
<style>
	.btn {
	   width : 75px;
	   display : inline-block;
	   height: 30px;
	   border-radius: 3px;
	   box-sizing: border-box;
	   line-height: 30px;
	   text-align: center;
	   background: #FFF;
	   border: 1px solid #D5C2EE;
	   color: #D5C2EE;
	   font-size: 14px;
	   margin: 1px;
	   margin-left: 10px;
	}

	.btn:hover {
	   width : 75px;
	   display : inline-block;
	   height: 30px;
	   border-radius: 3px;
	   box-sizing: border-box;
	   line-height: 30px;
	   text-align: center;
	   background-color: #D5C2EE;
	   border: 1px solid #D5C2EE;
	   color: #fff;
	   font-size: 14px;
	   margin: 1px;
	   margin-left: 10px;
	}
	.div-write {
		width: 70%;
    	margin: auto;	
	}
	.note-editor {
		width: 100% !important;
	}
	.title-class {
		border: 0px;
		font-size: 32px;
	}
	
	input::placeholder {
	  color: #c8c8c8;
	
	}
</style>
</head>
<body>
<script>

	//contextPath를 반환
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		return location.href.substring(begin, end);
	}
	
	$(document).ready(function(){
		
		console.log(getContextPath());
		
		// 서머노트
		$('#bbsContent').summernote({
			width: 800,
			height: 400,
			lang: 'ko-KR',
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			]
			
         });
		
		// 목록
		$('#btn_list').click(function(){
			location.href = '${contextPath}/bbs/list';
		});
		

		// 서브밋
		$('#frm_edit').submit(function(event){
			if($('#bbsTitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			}
		})

	});

</script>


	<div class="div-write">
		<form id="frm_edit" action="${contextPath}/bbs/modify" method="post">
			
			<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">
			
			<div style="margin-top: 50px; margin-bottom: 15px">
				<input class="title-class" type="text" name="bbsTitle" id="bbsTitle" value="${bbs.bbsTitle}" placeholder="제목">
			</div>
			
			<hr style="background: #D5C2EE; height: 1px; color: #D5C2EE;">
			
			<div style="margin-top: 20px">
				<textarea name="bbsContent" id="bbsContent">${bbs.bbsContent}</textarea>
			</div>
			<div style="margin-top: 20px; text-align: right;">
				<button class="btn">작성완료</button>
				<input class="btn" type="reset" value="입력초기화">
				<input class="btn" type="button" value="목록" id="btn_list"> 
			</div>
		</form>
	</div>


</body>
</html>