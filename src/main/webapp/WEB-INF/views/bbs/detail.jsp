<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<c:if test="${loginUser.id == 'admin'}">
<jsp:include page="../admin/admin_layout/header.jsp">
   <jsp:param value="갤러리 관리 페이지" name="title" />
</jsp:include>
</c:if>

<c:if test="${loginUser.id != 'admin'}">
<jsp:include page="../layout/header.jsp">
   <jsp:param value="${bbs.bbsTitle}" name="title" />
</jsp:include>
</c:if>

<script src="${contextPath}/resources/js/moment-with-locales.js"></script>

<style>
	.blind {
		display: none;
	}
	.div_title {
		font-size: 32px;
		font-weight: 1000;
		margin-top: 50px;
		margin-left: 10px;
		color: #D5C2EE;
		
	}
	.div_iddate{
		text-align: right;
    	color: #C8C8C8;
    	font-size: 12px;
    	margin-top: 20px;
    	margin-right: 20px;
	}
	.commentId {
		font-weight: bold;
	}
	.div_bbs_comm_list {
		margin-bottom: 5px;
	}
	.div_bbs_content {
		height: 300px;
	    overflow-x: auto;
	}
	.div_paging{
		width: 30%;
	    display: flex;
	    flex-wrap: nowrap;
	    justify-content: space-evenly;
	    margin: 0 auto;	
	    margin-bottom: 30px;
	}
	
	.btn {
	   width : 70px;
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
	   width : 70px;
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
		
	.add_comment {
		margin: 0 auto;
		margin-bottom: 15px;
		width: 1100px;
	}
	
	.div-buttons {
		margin-right: 0;
		margin-bottom: 50px;
	}
	
	
</style>

<div style="width: 70%; margin: 0 auto;">

	<div class="div_title">${bbs.bbsTitle}</div>
	<div class="div_iddate">
		▷ 작성자 ${bbs.id} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
		▷ 작성일 ${bbs.bbsCreateDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		▷ IP ${bbs.bbsIp} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
		▷ 조회수 ${bbs.bbsHit}
	</div>
	
	<hr  style="background: #D5C2EE; height: 1px; color: #D5C2EE;">	
	
	<div class="div_bbs_content">${bbs.bbsContent}</div>
	

	<hr style="color: #7B68EE;">
	
	<div style="margin-bottom: 10px;">
		<span id="btn_comment_list" style="font-size: 20px;">
			댓글 <span id="bbs_comm_count"></span>개
		</span>
	</div>
	
	
	<div id="comment_area">		<!-- class="blind" -->
		<div id="bbs_comm_list"></div>
		<div id="paging" class="div_paging"></div>
	</div>

	
	<div>
		<form id="frm_add_comment">
			<div class="add_comment">
				<span class="add_comment_input">
					<input type="text" name="commContent" id="commContent" style="width: 70%; height: 45px; border-color: #D5C2EE; border-radius: 3px;">
				</span>
				<c:if test="${loginUser.id != null}">
					<span class="add_comment_btn">
						<input class="btn" type="button" value="댓글 쓰기" id="btn_add_comment">
					</span>
				</c:if>
			</div>
			<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">
		</form>
	</div>
	<c:if test="${loginUser.id == null}">
		<div class="unlogin_comment">
			<span>댓글을 작성하시려면 로그인이 필요합니다.</span>
		</div>
	</c:if>
	
	<div class="div-buttons">
		<form id="frm_btn" method="post">
			<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">
			<c:if test="${loginUser.id == bbs.id}">
				<input class="btn" type="button" value="수정" id="btn_edit_bbs">
				<input class="btn" type="button" value="삭제" id="btn_remove_bbs">
			</c:if>
			<c:if test="${loginUser.id == 'admin'}">
				<input class="btn" type="button" value="수정" id="btn_edit_bbs">
				<input class="btn" type="button" value="삭제" id="btn_remove_bbs">
			</c:if>
			<input class="btn" type="button" value="목록" onclick="location.href='${contextPath}/bbs/list'">
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
	
	<input type="hidden" id="page" value="1">
	
	<script>
	
		// 함수호출
		fn_comment_submit_return();
		fn_commentCount();
		fn_switchCommentList();
		fn_addComment();
		fn_commentList();
		fn_changePage();
		fn_removeComment();
		fn_switchReplyArea();
		fn_addReply();
		
		// 함수정의
		
 		function fn_comment_submit_return() {
			$('.unlogin_comment').click(function(){
				location.href='${contextPath}/user/login/form';
				return;
			});
		};
		
		
		
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
				if($('#commContent').val() == ''){
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
							div += '<div style="margin-left: 20px;">';
						}
						if(comment.state == 1){
							div += '<div>';	
							if(comment.depth > 0){
								div += '→&nbsp';
							}
							div += '<span class="commentId">';	
							div += comment.id;
							div += '</span>';	
							div += '┃';
							div += comment.commContent;
							// 작성자 if 처리 
							if(${loginUser.id == 'admin'}){
								div += '<input type="button" value="삭제" class="btn_comment_remove btn" data-bbs_comm_no="' + comment.bbsCommNo + '">';								
							} else if('${loginUser.id}' == comment.id){
								div += '<input type="button" value="삭제" class="btn_comment_remove btn" data-bbs_comm_no="' + comment.bbsCommNo + '">';	
							} /* else if(${loginUser.id != null}){
								div += '<input type="button" value="삭제" class="btn_comment_remove btn" data-bbs_comm_no="' + comment.bbsCommNo + '">';	
							}  */
							if(comment.depth == 0){
								if(${loginUser != null}) {
									div += '<input type="button" value="답글" class="btn_reply_area btn">';	
								}
							}
							div += '</div>';
						} else {
							if(comment.depth == 0){
								div += '<div>삭제된 댓글입니다.</div>';
							} else {
								div += '<div>삭제된 답글입니다.</div>';
							}
						}

						div += '<div>';
						moment.locale('ko-KR');
						div += '<span style="font-size: 12px; color: silver;">' + moment(comment.createDate).format('YYYY. MM. DD hh:mm') + '</span>';
						div += '</div>';
						div += '<div style="margin-left: 40px;" class="reply_area blind">';		// 공백으로 구분했기 때문에 현재 class 는 2개임
						div += '<form class="frm_reply">';
					
						div += '<input type="hidden" name="bbsNo" value="' + comment.bbsNo + '">';
						div += '<input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
						div += '<input type="text" name="commContent" style="width: 500px; height: 25px; border-color: #D5C2EE;">';
						// 로그인한 사용자만 볼 수 있도록 if 처리
						div += '<input type="button" value="답글 쓰기" class="btn_reply_add btn">';
						div += '</form>';
						div += '</div>';

						$('#bbs_comm_list').append(div);
						$('#bbs_comm_list').append('<div class="div_bbs_comm_list"></div>');
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
				$(this).parent().next().next().toggleClass('blind');
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