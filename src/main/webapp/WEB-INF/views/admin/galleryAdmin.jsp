<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="admin_layout/header.jsp">
	<jsp:param value="이미지게시판 관리 페이지" name="title" />
</jsp:include>

<div>
	<h1>갤러리 목록(전체 ${totalRecord}개)</h1>

	<input type="button" id="moveWrite" value="게시글 작성하기" onclick="location.href='${contextPath}/gallery/write'">
	
	<div>
		<table border="1">
			<thead>
				<tr>
					<td>순번</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
					<td>좋아요</td>
					<td>삭제</td>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${galleryList}" var="gallery" varStatus="vs">
					<tr>
						<td>${beginNo - vs.index}</td>
						<td><a id="moveDetail" href="${contextPath}/gallery/increase/hit?galleryNo=${gallery.galleryNo}">${gallery.galleryTitle}</a></td>
						<td>${gallery.id}</td>						
						<td>${gallery.createDate}</td>
						<td>${gallery.hit}</td>
						<td>${liked.likedCnt}</td>
						<td>
						<form id="frm_btn" method="post">
							<input type="hidden" name="galleryNo" value="${gallery.galleryNo}">				
							<input type="button" value="삭제" id="btn_remove_gallery">
						</form>
						
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
	<script>
		
			$('#btn_remove_gallery').click(function(){
				if(confirm('블로그를 삭제하면 블로그에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
					$('#frm_btn').attr('action', '${contextPath}/gallery/remove');
					$('#frm_btn').submit();
				}
			});
		</script> 
		
</body>
</html>