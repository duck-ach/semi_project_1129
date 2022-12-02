<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드게시판-작성" name="title" />
</jsp:include>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.js"></script> <!-- ajax 날짜 시간 처리 -->
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.css">
<link rel="stylesheet" href="${contextPath}/resources/uploadcss/write_edit.css">
<script>
	
	$(function(){
		fn_fileCheck();
		fn_removeAttach();
		
		// summernote
 		$('#content').summernote({
			width: 800,
         	height: 400,
         	lang: 'ko-KR',
         	placeholder: '내용을 입력해주세요.',
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']]
			]
		}); 
	});
		
	function fn_fileCheck(){
		
		$('#files').change(function(){
			
			// 첨부 가능한 파일의 최대 크기
			let maxSize = 1024 * 1024 * 10;  // 10MB
			
			// 첨부된 파일 목록
			let files = this.files;
			
			// 첨부된 파일 순회
			for(let i = 0; i < files.length; i++){
				
				// 크기 체크
				if(files[i].size > maxSize){
					alert('10MB 이하의 파일만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일을 모두 없애줌
					return;
				}
				
			}
			
		});
		
	}
	
	function fn_removeAttach(){
		// 첨부 삭제
		$('.btn_attach_remove').click(function(){
			if(confirm('해당 첨부파일을 삭제할까요?')){
				location.href = '${contextPath}/upload/attach/remove?uploadNo=' + $(this).data('upload_no') + '&attachNo=' + $(this).data('attach_no');
			}
		});
	}
	
	
	
</script>
</head>
<body>

	<div>
		
		<div class="frm_write">
		
			<form id="frm_upload_add" action="${contextPath}/upload/modify" method="post" enctype="multipart/form-data">
			
				<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
			
				<div>
					<label for="title"></label>
					<input type="text" id="title" name="title" value="${upload.uploadTitle}" required="required" maxlength="30">
				</div>
				<hr class="hr_color">
				<div class="filebox">
					<label for="files">파일첨부</label>
					<input type="file" id="files" name="files" multiple="multiple">
				</div>
				<div>
		            <label for="content"></label>
		            <textarea name="content" id="content">${upload.uploadContent}</textarea>            
	         	</div>
				<div class="btn_location">
					<input type="button" class="btn" value="목록" onclick="location.href='${contextPath}/upload/list'">
					<button class="btn_submit">수정완료</button>
				</div>
			
			</form>
		
			<div>
				<h3>첨부파일 목록</h3>	
				<c:forEach items="${attachList}" var="attach">
					<div>
						${attach.origin}<input type="button" class="remove_btn btn_attach_remove" value="삭제" data-upload_no="${upload.uploadNo}" data-attach_no="${attach.attachNo}">
					</div>
				</c:forEach>
			</div>
		</div>
	
	</div>
	
</body>
</html>