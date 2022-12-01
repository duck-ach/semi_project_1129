<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../layout/header.jsp">
	<jsp:param value="${gallery.galleryNo}번 게시글" name="title"/> 
</jsp:include>
<script src="${contextPath}/resources/galleryjs/moment-with-locales.js"></script>
<style>
	.blind {
		display: none;
	}
</style>
	
<div>
	<h1>${gallery.galleryTitle}</h1>
	
	<div>
		<span>▷ 작성자 | ${gallery.id}</span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 작성일 <fmt:formatDate value="${gallery.createDate}" pattern="yyyy.M.d HH:mm"/></span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 수정일 <fmt:formatDate value="${gallery.modifyDate}" pattern="yyyy.M.d HH:mm"/></span>
		&nbsp;&nbsp;&nbsp;
		
	</div>
	
<!-- 	<div> -->
<%-- 		<span>조회수 <fmt:formatNumber value="${gallery.hit}" pattern="#,##0"/></span> --%>
<!-- 	</div> -->
	
	<hr>
	
	<div>
		${gallery.galleryContent}
	</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="galleryNo" value="${gallery.galleryNo}">
			<input type="button" value="수정" id="btn_edit_gallery">
			<input type="button" value="삭제" id="btn_remove_gallery">
		</form>
		
		
		<script>
			$('#btn_edit_gallery').click(function(){
				$('#frm_btn').attr('action', '${contextPath}/gallery/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_gallery').click(function(){
				if(confirm('블로그를 삭제하면 블로그에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
					$('#frm_btn').attr('action', '${contextPath}/gallery/remove');
					$('#frm_btn').submit();
				}
			});
		</script> 
		
	</div>
   
   <hr>
   
   <!-- 댓글영역 -->
	<span id="btn_comment_list">
		댓글
		<span id="comment_count"></span>개
	</span>
	
	<hr>
	
	<div id="comment_area" class="blind">
		<div id="comment_list"></div>
		<div id="paging"></div>
	</div>
   
   <!-- name="content", name="galleryNo" 을 form 안에 넣은 이유 ? serialize()로 보내기 위해서 -->
   <!-- serialize()하면 form안에 있는 모든 name을 넘겨준다 -->
	<c:if test="${loginUser.id != null}">
	<div>
		<form id="frm_add_comment">
			<div class="add_comment">
				<div class="add_comment_input">
					<span>${loginUser.id}</span>
					<input type="text" name="commContent" id="content">
				</div>
				<div class="add_comment_btn">
					<input type="button" value="작성완료" id="btn_add_comment">
				</div>
			</div>
			<input type="hidden" name="galleryNo" value="${gallery.galleryNo}">
		</form>
	</div>
	</c:if>		
	<c:if test="${loginUser.id == null}">
		<div>
			<div class="unlogin_comment">
					<span></span>
					<input type="text" name="commContent" id="content" placeholder="댓글을 작성하려면 로그인 해 주세요" readonly="readonly">
				</div>
		</div>
	</c:if>
	
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
   <script>
   
	// 함수 호출
	fn_commentCount();
	fn_switchCommentList();
	fn_addComment();
	fn_commentList();
	fn_changePage();
	fn_removeComment();
	fn_switchReplyArea();
	fn_addReply();
      
      // 함수 정의
      function fn_commentCount(){
         $.ajax({
            type: 'get',
            url: '${contextPath}/galleryComm/getCount',
            data: 'galleryNo=${gallery.galleryNo}',   // 글번호 달아줌
            dataType: 'json',
            success: function(resData){  // resData = {"commentCount": 개수}
               $('#comment_count').text(resData.commentCnt);
            }
         });
      }
      
      function fn_switchCommentList() {
         $('#btn_comment_list').click(function() {
            $('#comment_area').toggleClass('blind');   // 토글을 줬다가 뺐다가
         });
      }
      
		function fn_addComment(){
			$('#btn_add_comment').click(function(){
				if($('#comment').val() == ''){
					alert('댓글 내용을 입력하세요');
               return; // ajax 실행 막음
            }
			$.ajax({
				type: 'post',
				url: '${contextPath}/galleryComm/add',
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
            url: '${contextPath}/galleryComm/list',
            data: 'galleryNo=${gallery.galleryNo}&page=' + $('#page').val(),   // 현재 page도 넘겨줘야 함
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
               $('#comment_list').empty();   // 목록 초기화 필수
               $.each(resData.commentList, function(i, comment){
                  // 댓글 depth: 0 이면 들어갈 필요 없고, 대댓 depth: 1 이면 한칸 들어가야 함, 1단이면 그룹오더 필요x
					var div = '';
					if(comment.commDepth == 0){
						div += '<div>';
					} else {
						div += '<div style="margin-left: 40px;">';
					}
                  if(comment.commState == 1) {   // state:1 정상, state:-1은 삭제라서 보여주면 x
                     div += '<div>'
                     div += comment.id + '<br>';
                     div += comment.commContent;   // 정상일 때 내용 보여줌
                     // 작성자만 삭제할 수 있도록 if 처리 필요
						div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.galleryCommNo + '">';
						if(comment.commDepth == 0) {
							div += '<input type="button" value="답글" class="btn_reply_area">';
						}
						div += '</div>';
					} else {
						if(comment.commDepth == 0) {
							div += '<div>삭제된 댓글입니다.</div>';
						} else {
							div += '<div>삭제된 답글입니다.</div>';
						}
					}
                  // 날짜 형식 지정하는 자바스크립트 (moment-with-locales.js)
					div += '<div>';
					moment.locale('ko-KR');
					div += '<span style="font-size: 12px; color: silver;">' + moment(comment.commDate).format('YYYY. MM. DD hh:mm') + '</span>';
					div += '</div>';
					div += '<div style="margin-left: 40px;" class="reply_area blind">';
					div += '<form class="frm_reply">';
					div += '<input type="hidden" name="galleryNo" value="' + comment.galleryNo + '">';
					div += '<input type="hidden" name="commGroupNo" value="' + comment.commGroupNo + '">';
					div += '<input type="text" name="commContent" placeholder="답글을 작성하려면 로그인을 해주세요">';
					// 로그인한 사용자만 볼 수 있도록 if 처리
					div += '<input type="button" value="답글작성완료" class="btn_reply_add">';
					div += '</form>';
					div += '</div>';
					div += '</div>';
					$('#comment_list').append(div);
					$('#comment_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
				});
               // 페이징
               $('#paging').empty(); // 초기화
				var pageUtil = resData.galleryPageUtil;
				var paging = '';
               
               // 이전 블록
					if(pageUtil.beginPage != 1) {
						paging += '<span class="enable_link" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
                  // 태그를 클릭하면 몇 페이지로 가는 링크인지 넣자
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
				$('#paging').append(paging); // 페이지 뿌림
            }
         }); 
      } // fn_commentList()
      
		function fn_changePage(){
         // $(만들어져있었던 부모).on('click', '.enable_link', (function() {  //  $('.enable_link').click(function() 만든 아이는 직접 볼 수 없다. 만들어져 있는 애만 직접 볼 수 있다.
         $(document).on('click', '.enable_link', function() {
            $('#page').val( $(this).data('page') );   // page value값이 fn_commentList() 할 때마다 넘어감 => $('#page').val 값을 바꿔서 다시 요청
            fn_commentList();   // 목록을 다시 가져와라
         });
      }
         
      function fn_removeComment() {
         $(document).on('click', '.btn_comment_remove', function(){
               if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')) {
                  $.ajax({
                     type: 'post',
                     url: '${contextPath}/galleryComm/remove',
                     data: 'galleryCommNo=' + $(this).data('comment_no'), // 코멘트 번호에 삭제버튼 넣어놨음
                     dataType: 'json',
                     success: function(resData) {   // resData = {"isRemove" : true}
                        if(resData.isRemove) {
                           alert('댓글이 삭제되었습니다.');
                           fn_commentList();   // 댓글 목록 가져와서 뿌리는 함수
                           fn_commentCount();  // 댓글 목록 개수 갱신하는 함수
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
					url: '${contextPath}/galleryComm/reply/add',
					data: $(this).closest('.frm_reply').serialize(),  // 이건 안 됩니다 $('.frm_reply').serialize(),
					dataType: 'json',
					success: function(resData){  // resData = {"isAdd", true}
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