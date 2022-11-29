<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="${bbs.bbsNo}번 게시글 상세내용" name="title" />
</jsp:include>

<style>
	.blind {
		display: none;
	}
</style>

<div>

	<div>제목</div>
	
	<div>${bbs.bbsTitle}</div>
	
	<hr>	
	
	<div>${bbs.bbsContent}</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">
			<input type="button" value="수정" id="btn_edit_bbs">
			<input type="button" value="삭제" id="btn_remove_bbs">
			<input type="button" value="목록" onclick="location.href='${contextPath}/bbs/list'">
		</form>
		<script>
			$('#btn_edit_bbs').click(function(){
				$('#frm_btn').attr('action','${contextPath}/bbs/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_bbs').click(function(){
				if(confirm('게시글을 삭제하면 게시글에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
					$('#frm_btn').attr('action','${contextPath}/bbs/remove');
					$('#frm_btn').submit();
				}
			});		
		</script>
	</div>
	
	<hr>
	
	<span id="btn_comment_list">
		<span id="bbs_comm_count"></span>개의 댓글
	</span>
	
	<hr>
	
	<div id="comment_area" class="blind">
		<div id="bbs_comm_list"></div>
		<div id="paging"></div>
	</div>
	
	<hr>
	
	<div>
		<form id="frm_add_comment">
			<div class="add_comment">
				<div class="add_comment_input">
					<input type="text" name="commContent" id="commContent" placeholder="댓글을 작성해주세요" >
				</div>
				<div class="add_comment_btn">
					<input type="button" value="작성완료" id="btn_add_comment">
				</div>
			</div>
			<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">
		</form>
	</div>
	
	<input type="hidden" id="page" value="1">
	
	<script>
		// 함수호출
		fn_commentCount();
		fn_switchCommentList();
		fn_addComment();
		fn_commentList();
		fn_changePage();
		fn_removeComment();
		fn_switchReplyArea();
		fn_addReply();
		
		
		// 함수정의
		function fn_commentCount(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/bbsComm/getCount',
				data: 'bbsNo=${bbs.bbsNo}',
				dataType: 'json',
				success: function(resData){
					$('#bbs_comm_count').text(resData.bbsCommCount);
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
				if($('#bbsComm').val() == ''){
					alert('댓글 내용을 입력하세요');
					return;
				}
				$.ajax({
					type: 'post',
					url: '${contextPath}/bbsComm/add',
					data: $('#frm_add_comment').serialize(),
					dataType: 'json',
					success: function(resData){
						if(resData.isAdd){
							alert('댓글이 등록되었습니다.');
							$('#commContent').val('');
							fn_commentList();
							fn_commentCount();
						}
					}
				});
			});
		}
	
		function fn_commentList(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/bbsComm/list',
				data: 'bbsNo=${bbs.bbsNo}&page=' + $('#page').val(),
				dataType: 'json',
				success: function(resData){
					$('#bbs_comm_list').empty();
					$.each(resData.bbsCommList, function(i, comment){
						var div='';
						if(comment.depth == 0){
							div += '<div>';
						} else {
							div += '<div style="margin-left: 40px;">';
						}
						if(comment.state == 1){
							div += '<div>';
							div += comment.commContent;
							// 작성자 if 처리 
							div += '<input type="button" value="삭제" class="btn_comment_remove" data-bbs_comm_no="' + comment.bbsCommNo + '">';
							if(comment.depth == 0){
								div += '<input type="button" value="답글" class="btn_reply_area">';
							}
							div += '</div>';
						} else {
							if(comment.depth == 0){
								div += '<div>삭제된 댓글입니다.</div>';
							} else {
								div += '<div>삭제된 답글입니다.</div>';
							}
						}
						//div += '<div>';
						div += '<div style="margin-left: 40px;" class="reply_area blind">';		// 공백으로 구분했기 때문에 현재 class 는 2개임
						div += '<form class="frm_reply">';
						div += '<input type="hidden" name="bbsNo" value="' + comment.bbsNo + '">';
						div += '<input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
						div += '<input type="text" name="commContent" placeholder="답글을 작성하려면 로그인을 해주세요">';
						// 로그인한 사용자만 볼 수 있도록 if 처리
						div += '<input type="button" value="답글 작성 완료" class="btn_reply_add">';
						div += '</form>';
						div += '</div>';
						//div += '</div>';
						$('#bbs_comm_list').append(div);
						$('#bbs_comm_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
					});
					// paging
					$('#paging').empty();
					var pageUtil = resData.pageUtil;
					var paging ='';
					// 이전 블록
					if(pageUtil.beginPage != 1){
						paging += '<span class="enable_link" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
					}
					
					// 페이지 번호
					for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++){
						if(p == $('#page').val()){
							paging += '<strong>' + p + '</strong>';
						} else {
							paging += '<span class="enable_link" data-page="'+ p +'">' + p + '</span>';
						}
					}
					// 다음 블록
					if(pageUtil.endPage != pageUtil.totalPage){
						paging += '<span class="enable_link" data-page="' + (pageUtil.endPage + 1) +'">▶</span>';
					}
					$('#paging').append(paging);
				}
			});
		}
		
		
		
		
		function fn_changePage(){
			$(document).on('click', '.enable_link', function(){
				$('#page').val($(this).data('page'));
				fn_commentList();
			});
		}
		
		function fn_removeComment(){
			$(document).on('click', '.btn_comment_remove', function(){
				if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')){
					$.ajax({
						type: 'post',
						url: '${contextPath}/bbsComm/remove',
						data: 'bbsCommNo=' + $(this).data('bbs_comm_no'),
						dataType: 'json',
						success: function(resData){			// resData = {"isRemove" : true}
							if(resData.isRemove){
								alert('댓글이 삭제되었습니다.');
								fn_commentList();
								fn_commentCount();
							}
						}
					});
				}
			});
		}		
		
		
		function fn_switchReplyArea(){
			$(document).on('click', '.btn_reply_area', function(){
				$(this).parent().next().toggleClass('blind');
			});
		}
		
		
		function fn_addReply(){
			$(document).on('click', '.btn_reply_add', function(){
				if($(this).prev().val() == ''){
					alert('답글 내용을 입력하세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '${contextPath}/bbsComm/reply/add',
					data: $(this).closest('.frm_reply').serialize(),    // $('.frm_reply').serialize() form이 많아서 안됨
					dataType: 'json',
					success: function(resData){			// resData = {"isAdd", true}
						if(resData.isAdd){
							alert('답글이 등록되었습니다.');
							fn_commentList();
							fn_commentCount();
						}
					}
				});
			});
		}
		
	
	</script>




</div>


</body>
</html>