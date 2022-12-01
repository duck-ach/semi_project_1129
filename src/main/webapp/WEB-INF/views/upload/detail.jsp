<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드게시판-${upload.uploadTitle}" name="title" />
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
					<c:if test="${loginUser.id == upload.id} || ${loginUser.userNo == 1}">
						<input type="button" value="게시글편집" id="btn_upload_edit" class="btn"> 			
						<input type="button" value="게시글삭제" id="btn_upload_remove" class="btn"> 			
					</c:if>
					<input type="button" value="게시글목록" id="btn_upload_list" class="btn"> 			
				</form>
			</div>
			<div class="date_location">
				<span class="view_date">작성일 : <fmt:formatDate value="${upload.createDate}" pattern="yyyy. M. d HH:mm" /></span>
				&nbsp;&nbsp;&nbsp;
				<span class="view_date">수정일 <fmt:formatDate value="${upload.modifyDate}" pattern="yyyy. M. d HH:mm" /></span>
			</div>
		<!-- 내용 -->
		<div>
			<div>
				<span class="view_title">${upload.uploadTitle}</span>
			</div>
		</div>
		<hr>
		<!-- 첨부파일 -->

			<div>
				<div class="attach_location">
					<span id="cnt"></span>
					<div class="view_attach blind">
						<c:forEach items="${attachList}" var="attach" varStatus="status">
						<input type="hidden" class="attachCnt" value="${status.count}">	
							<div>
								<a class="attachFile attachFileDown" href="${contextPath}/upload/download?attachNo=${attach.attachNo}&uploadNo=${attach.uploadNo}">${attach.origin}</a>
							</div>
						</c:forEach>
						<div>
							<a class="attachFile attachFileDownAll" href="${contextPath}/upload/downloadAll?uploadNo=${upload.uploadNo}">모두 다운로드</a>
						</div>
					</div>
				
				</div>
				
			</div>

		<div class="view_content">
			<span>${upload.uploadContent}</span>
		</div>
		
		

		<hr>
		<div>
			<c:if test="${loginUser.id != null}">
				<form id="frm_add_comment">
					<div class="add_comment">
						<div class="add_comment_input">
								<input type="text" name="commContent" id="content" placeholder="댓글을 작성해주세요.">
						</div>
						<div class="add_comment_btn">
							<input type="button" value="작성완료" id="btn_add_comment">
						</div>
					</div>
					<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
				</form>
				<div>
					<span id="btn_comment_list">
						댓글<span id="comment_count"></span>개
					</span>
					<hr>
			
					<div id="comment_area">
						<div id="comment_list"></div>
						<div id="paging"></div>
					</div>
				</div>
			</c:if>
		</div>
		<c:if test="${loginUser.id == null}">
			<div class="unlogin_comment">
				<span>댓글을 작성하시려면 로그인이 필요합니다.</span>
			</div>
		</c:if>
</div>
	
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
	
	<script>
		
		// 함수 호출	
		fn_comment_submit_return();
		fn_attach_download_return();
		fn_attachblind();
		fn_commentCount();
		fn_switchCommentList();
		fn_addComment();
		fn_commentList();
		fn_changePage();
		fn_removeComment();
		fn_switchReplyArea();
		fn_addReply();
		
		// 로그인안된 사용자가 댓글을 달려고할 때 막기
 		function fn_comment_submit_return() {
			$('.unlogin_comment').click(function(){
				location.href='${contextPath}/user/login/form';
				return;
			});
		};
		
		// 로그인안된 사용자가 첨부파일 다운로드 받으려고할 때 막기
		function fn_attach_download_return() {
			if(${loginUser == null}) {
				$('#cnt').click(function(){
					alert('첨부파일을 다운로드 받기 위해서는 로그인이 필요합니다.');
					event.preventDefault();
					location.href='${contextPath}/user/login/form';
					return;
				});			
			} else {
				fn_switchAttachList();
			}
		};

		
		// 첨부파일 없으면 안보이게 하는 것
		function fn_attachblind() {
			// 첨부파일 개수
			var att_cnt = $('.attachCnt').length;
			$('#cnt').text('첨부파일 (' + att_cnt + ')');
			
			if(att_cnt == 0) {
				$('.attach_location').prop('class', 'blind');
			}
		}
		
		// 첨부파일 toggle
		function fn_switchAttachList() {
			$('#cnt').click(function(){
				$('.view_attach').toggleClass('blind');
			});
		}
		
		// 함수 정의
		function fn_commentCount(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/comment/getCount',
				data: 'uploadNo=${upload.uploadNo}',
				dataType: 'json',
				success: function(resData){  // resData = {"commentCount": 개수}
					$('#comment_count').text(resData.commentCount);
				}
			});
		}
		
		function fn_switchCommentList(){
			$('#btn_comment_list').click(function(){
				$('#comment_area').toggleClass('blind');
			});
		}
		
		function fn_addComment(){
			$('#btn_add_comment').click(function(){
				if($('#comment').val() == ''){
					alert('댓글 내용을 입력하세요');
					return;
				}
				$.ajax({
					type: 'post',
					url: '${contextPath}/comment/add',
					data: $('#frm_add_comment').serialize(),
					dataType: 'json',
					success: function(resData){  // resData = {"isAdd", true}
						if(resData.isAdd){
							alert('댓글이 등록되었습니다.');
							$('#content').val('');
							fn_commentList();   // 댓글 목록 가져와서 뿌리는 함수
							fn_commentCount();  // 댓글 목록 개수 갱신하는 함수
						}
					}
				});
			});
		}
		
		function fn_commentList(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/comment/list',
				data: 'uploadNo=${upload.uploadNo}&page=' + $('#page').val(),
				dataType: 'json',
				success: function(resData){
					/*
						resData = {
							"commentList": [
								{댓글하나},
								{댓글하나},
								...
							],
							"pageUtil": {
								page: x,
								...
							}
						}
					*/
					// 화면에 댓글 목록 뿌리기
					$('#comment_list').empty();
					$.each(resData.commentList, function(i, comment){
						var date = '${comment.commDate}';
						var div = '';
						if(comment.depth == 0){
							div += '<div>';
						} else {
							div += '<div style="margin-left: 40px;">';
						}
						if(comment.state == 1) {
							div += '<div>';
							div += comment.id;
							div += comment.commContent;
							// 작성자만 지울 수 있도록 if 처리 필요
							if(${loginUser.id == 'admin'}) {
								div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.uploadCommNo + '">';
							} else if ('${loginUser.id}' == comment.id){
								div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.uploadCommNo + '">';
							}
							if(comment.depth == 0) {
								div += '<input type="button" value="답글" class="btn_reply_area">'; // comment의 commentNo가 groupNo와 같다.
							}
							div += comment.commDate;
							div += '</div>';
						} else {
							if(comment.depth == 0) {
								div += '<div>삭제된 댓글입니다.</div>';
							} else {
								div += '<div>삭제된 답글입니다.</div>';
							}
						}
						div += '<div style="margin-left:40px;" class="reply_area blind">';
						div += '<form class="frm_reply">';
						div += '<input type="hidden" name="uploadNo" value="' + comment.uploadNo + '">'; // hidden에는 name속성이 있어야함(serialize로 보낼것임)
						div += '<input type="hidden" name="groupNo" value="' + comment.uploadCommNo + '">';
						div += '<input type="text" name="commContent" placeholder="답글을 작성하려면 로그인을 해 주세요">'
						// 로그인한 사용자만 볼 수 있도록 if 처리
						div += '<input type="button" value="답글작성완료" class="btn_reply_add">' // type을 submit으로 해버리면 ajax 처리가 안됨. mvc처리가 됨
						div += '</form>';
						div += '</div>';
						$('#comment_list').append(div);
						$('#comment_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
					});
					// 페이징
					$('#paging').empty();
					var pageUtil = resData.pageUtil;
					var paging = '';
					// 이전 블록
					if(pageUtil.beginPage != 1) {
						paging += '<span class="enable_link" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
					}
					// 페이지번호
					for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++) {
						if(p == $('#page').val()){
							paging += '<strong>' + p + '</strong>';
						} else {
							paging += '<span class="enable_link" data-page="'+ p +'">' + p + '</span>';
						}
					}
					// 다음 블록
					if(pageUtil.endPage != pageUtil.totalPage){
						paging += '<span class="enable_link" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
					}
					$('#paging').append(paging);
				}
			});
		}  // fn_commentList
		
		function fn_changePage(){
			$(document).on('click', '.enable_link', function(){
				$('#page').val( $(this).data('page') );
				fn_commentList();
			});
		}
		
		function fn_removeComment() {
			$(document).on('click', '.btn_comment_remove', function(){
				if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')){
					$.ajax({
						type : 'post', // 큰 차이는 없음
						url : '${contextPath}/comment/remove',
						data : 'uploadCommNo=' + $(this).data('comment_no'), // 클릭한 버튼의 data속성에 넣음
						dataType : 'json',
						success : function(resData) { // resData = {"isRemove" : true}
							if(resData.isRemove) {
								alert('댓글이 삭제되었습니다.');
								fn_commentList(); // 목록갱신
								fn_commentCount(); // 개수갱신
							}
						}
					}); // ajax
				} // if
			}); // event
		} // function
		
		function fn_switchReplyArea() {
			$(document).on('click', '.btn_reply_area', function() {
				$(this).parent().next('.reply_area').toggleClass('blind'); // this의 부모의 형제의 형제
			}); // event
		} // function
		
		function fn_addReply() {
			$(document).on('click', '.btn_reply_add', function(){
				// 공백검사
				if($(this).prev().val() == '') {
					alert('답글 내용을 입력하세요.');
					return;
				}
				$.ajax({ // parent() 는 부모, closest()는 가장가까운
					type : 'post',
					url : '${contextPath}/comment/reply/add', 
					data : $(this).closest('.frm_reply').serialize(), // 이건 form이 많아서 안 됩니다 $('.frm_reply').serialize(),
					dataType : 'json',
					success : function(resData) { // resData = {"isAdd", true}
						alert('답글이 등록되었습니다.');
						fn_commentList(); // 목록갱신
						fn_commentCount(); // 개수갱신
					}
				});
			});
		}
		
		
		
	</script>
	
</body>
</html>