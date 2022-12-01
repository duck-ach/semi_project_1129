<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="갤러리 목록" name="title"/>
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
	$('#moveDetail').click(function(){
		if(${loginUser == null}){
			alert('로그인한 뒤 조회가능합니다.');
			event.preventDefault();
			history.back();
			location.href='${contextPath}/user/login/form';
			return;
		}
	})
</script>

</body>
</html>