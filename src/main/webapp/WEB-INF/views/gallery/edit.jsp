<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="갤러리게시판-수정" name="title" />
</jsp:include>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/galleryjs/moment-with-locales.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.css">
</head>
<body>
	
<script>
	
	// contextPath를 반환하는 자바스크립트 함수
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		return location.href.substring(begin, end);
	}
	
	$(document).ready(function(){
		
		// summernote
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
			    ['insert', ['link', 'picture', 'video']]
			],
			callbacks: {
				onImageUpload: function(files){
					var formData = new FormData();
					formData.append('file', files[0]);
					$.ajax({
						type: 'post',
						url: getContextPath() + '/gallery/uploadImage',
						data: formData,
						contentType: false,
						processData: false,
						dataType: 'json',
						success: function(resData){
							$('#content').summernote('insertImage', resData.src);
						}
					});
				}
			}
		});
		
		// 목록
		$('#btn_list').click(function(){
			location.href = getContextPath() + '/gallery/list';
		});
		
		// 서브밋
		$('#frm_edit').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			}
		});
		
	});
	
</script>


<div>

	<h1>작성 화면</h1>
	
	<form id="frm_edit" action="${contextPath}/gallery/modify" method="post">
	
		<input type="hidden" name="galleryNo" value="${gallery.galleryNo}">
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" value="${gallery.galleryTitle}">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content">${gallery.galleryContent}</textarea>				
		</div>
		
		<div>
			<button>수정완료</button>
			<input type="reset" value="작성초기화">
			<input type="button" value="목록" id="btn_list">
		</div>
		
	</form>
	
</div>

</body>
</html>