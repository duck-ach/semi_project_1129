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
<script src="${contextPath}/resources/js/moment-with-locales.js"></script> <!-- ajax 날짜 시간 처리 -->
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.css">
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
		$('#content').summernote({
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
		$('#frm_write').submit(function(event){
			if($('#bbsTitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			}
		})

	});


    $(window).on("beforeunload", function() {
        return "작성중인 글이 존재합니다. 페이지를 나가시겠습니까?";
    });
	
    $("#admin_post_write_form").on("submit", function() {
        $(window).off("beforeunload");
    });


	
</script>
</head>
<body>
	

	<div>
		<form id="frm_write" action="${contextPath}/bbs/add" method="post">
			<div>
				<label for="title">제목</label>
				<input type="text" name="bbsTitle" id="title">
			</div>
			<div>
				<label for="content">내용</label>
				<textarea name="bbsContent" id="content"></textarea>
			</div>
			<div>
				<button>작성완료</button>
				<input type="reset" value="입력초기화">
				<input type="button" value="목록" id="btn_list"> 
			</div>
		</form>
	</div>


</body>
</html>