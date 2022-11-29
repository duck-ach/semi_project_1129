<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${gallery.galleryNo}번 게시글" name="title"/> 
</jsp:include>
	
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
				$('#frm_btn').attr('action', '${contextPath}/gallery/edit')
				$('#frm_btn').submit();
			});
			$('#btn_remove_gallery').click(function(){
				if(confirm('게시물을 삭제하면 해당 게시물에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')) {
					$('#frm_btn').attr('action', '${contextPath}/gallery/remove');
					$('#frm_btn').submit();
				}
			});
		</script>	
	</div>
	
</div>

</body>
</html>