<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="게시글작성" name="title"/>
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
		var end = location.href.indexOf("/", begin+1);
		return location.href.substring(begin, end);
	}
	
	$(document).ready(function(){
		
		//console.log(getContextPath());// 로그용 호출
		
		// summernote
		$('#content').summernote({
			width: 800,
			height: 400,
			lang : 'ko_KR',
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['insert', ['link', 'picture', 'video']],
			    ['height', ['height']]
			  ],
			  callbacks: {
				  
				  // summernote 편집기에 이미지를 로드할 때 이미지는 function의 매개변수 files로 전달됨
				  onImageUpload: function(files){
					  // 이미지 ajax를 이용해서 서버로 보낼때 가상 form 데이터 사용
					  var formData = new FormData();
					  formData.append('file', files[0]); // 파라미터 file, summernote 편집기에 추가

					  // 이미지를 hdd에 저장하고 경로를 받아오는 ajax
					  $.ajax({
						  type: 'post',
						  url: getContextPath() + '/gallery/uploadImage',
						  data : formData,
						  contentType: false,
						  processData: false,
						  dataType : 'json',
						  success: function(resData){
							  $('#content').summernote('insertImage', resData.src);
							  
							  /*
							  	src =${contextPath}/load/image/aaa.jpg 값이 넘어온 경우
							  	summernote는
							  	<img src="${contextPath}/load/image/aaa.jpg"> 태그를 만든다.
							  	
							  	스프링에서 정적 자원 표시하는 방법은 servlet-context.xml에 있다
							  	
							  	mapping=${contextPath}/load/image/aaa.jpg 인 파일의
							  	location=C:\\upload\\aaa.jpg이다.
							  	이미지의 매핑과 로케이션을 서블릿 콘택스트에 저장해야ㅎ한다
							  */
						  }
						});  // ajax
					}  // onImageUpload
				}  // callbacks
			});
			
		
		// 목록
		$('#btn_list').click(function(){
			location.href = getContextPath() + '/gallery/list';// taglib 사용이 어려울수도 있으니까
		})
		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault(); // 서브밋 취소
				return; // 더 이상 코드 실행할 필요 없음
			}else if()
		});
		
	});
	
</script>

<div>

	<h1>작성 화면</h1>
	
	<form id="frm_write" action="${contextPath}/gallery/add" method="post">
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"></textarea>				
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