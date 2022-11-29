<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드게시판-${upload.uploadTitle}번게시글" name="title" />
</jsp:include>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/uploadcss/detail.css">
<script>

	$(function(){
		
		// 게시글 수정화면으로 이동
		$('#btn_upload_edit').click(function(event){
			$('#frm_upload').attr('action', '${contextPath}/upload/edit');
			$('#frm_upload').submit();
		});
		
		// 게시글 삭제
		$('#btn_upload_remove').click(function(event){
			if(confirm('첨부된 모든 파일이 함께 삭제됩니다. 삭제할까요?')){
				$('#frm_upload').attr('action', '${contextPath}/upload/remove');
				$('#frm_upload').submit();
			}
		});
		
		// 게시글 목록
		$('#btn_upload_list').click(function(event){
			location.href = '${contextPath}/upload/list';
		});
		
	});

</script>
</head>
<body>

	<div class="frm_detail">
			<div class="btn_location">
				<form id="frm_upload" method="post">
					<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
					<input type="button" value="게시글편집" id="btn_upload_edit" class="btn"> 			
					<input type="button" value="게시글삭제" id="btn_upload_remove" class="btn"> 			
					<input type="button" value="게시글목록" id="btn_upload_list" class="btn"> 			
				</form>
			</div>
			<div class="date_location">
				<span class="view_date">작성일 : ${upload.createDate}&nbsp;&nbsp;&nbsp;수정일 : ${upload.modifyDate}</span>
			</div>
		<div>
			<div>
				<span class="view_title">${upload.uploadTitle}</span>
			</div>
		<hr>
			<div class="view_content">
				<span>${upload.uploadContent}</span>
			</div>
		</div>
		
		
		<div class="view_attach">
			<span id="cnt"></span>
			<c:forEach items="${attachList}" var="attach" varStatus="status">
			<input type="hidden" class="attachCnt" value="${status.count}">	
				<div>
					<a href="${contextPath}/upload/download?attachNo=${attach.attachNo}">${attach.origin}</a>
				</div>
			</c:forEach>
			<br>
			<div>
				<a href="${contextPath}/upload/downloadAll?uploadNo=${upload.uploadNo}">모두 다운로드</a>
			</div>
		</div>
	
		<script>
			// 첨부파일 개수
			var att_cnt = $('.attachCnt').length;
			console.log(att_cnt);
			$('#cnt').text('첨부파일 (' + att_cnt + ')');
			
		</script>
		<div>
			<c:if test="">
				<form id="frm_add_comment">
					<div class="add_comment">
						<div class="add_comment_input">
							<input type="text" name="content" id="content" placeholder="댓글을 작성하려면 로그인 해 주세요">
						</div>
						<div class="add_comment_btn">
							<input type="button" value="작성완료" id="btn_add_comment">
						</div>
					</div>
					<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
				</form>
			</c:if>
		</div>
	</div>
	
</body>
</html>