<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드게시판-작성" name="title" />
</jsp:include>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.js"></script> <!-- ajax 날짜 시간 처리 -->
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.css">
<link rel="stylesheet" href="${contextPath}/resources/uploadcss/write_edit.css">
</head>
<body>
	
<script>
	$(function(){
		// function 실행 목록
		fn_fileCheck();
		
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
		
		// fileList 전역변수
		var fileList = null;
		
		// 파일 첨부 목록 출력
		$("#files").on('change',function(){
			console.log($(this));
			fileList = $('#files')[0].files;
			fileListTag = '<h3>첨부파일 목록</h3>' + fileList.length + '개의 파일이 첨부되었습니다.';
			for(i = 0; i < fileList.length; i++) {
				fileListTag += '<li>' + fileList[i].name + '</li>';
			}
			$('#fileList').html(fileListTag);
			  
		});
	});
	
	function fn_fileCheck() {
		$('#files').change(function(){ // 파일 첨부를 인식하는 change 이벤트
			
			// 첨부 가능한 파일의 최대 크기 (10MB) 
			let maxSize = 1024 * 1024 * 10; // 10MB (1kB = 1024 byte)
			
			// 첨부된 파일 목록
			let files = this.files; // 첨부된 파일들의 목록 확인
			
			// 첨부된 파일 순회
			for(let i = 0; i < files.length; i++){
				// 크기 체크
				if(files[i].size > maxSize) {
					alert('10MB 이하의 파일만 첨부할 수 있습니다.');
					$(this).val(''); // 첨부된 파일을 모두 없애줌
					return;
				}
			}
		});
	};
	
</script>
</head>
<body>

<div class="frm_write">
	<div>
							<!-- 첨부할 때는 method="post" enctype="multipart/form-data" 적어주는거 기본적인 약속 -->
		<form id="frm_upload_add" action="${contextPath}/upload/add" method="post" enctype="multipart/form-data">
				<div>
					<label for="title"></label>
					<input type="text" id="title" name="title" required="required" placeholder="제목">
				</div>
				<hr>
				<div class="filebox">
					<label for="files">업로드</label>
					<input type="file" id="files" name="files" multiple="multiple"> <!-- multiple을 해주어야 다중첨부 가능 -->
				</div>
				<div>
		            <label for="content"></label>
		            <textarea name="content" id="content"></textarea>            
	         	</div>
				<div class="btn_location">
					<input type="button" class="btn" value="목록" onclick="location.href='${contextPath}/upload/list'">
					<button class="btn_submit">작성완료</button>
				</div>
		</form>
		
		<div>
				<!-- 여기에 파일목록 추가 -->
				<ul id="fileList"></ul>
		</div>
	</div>
</div>
	
</body>
</html>