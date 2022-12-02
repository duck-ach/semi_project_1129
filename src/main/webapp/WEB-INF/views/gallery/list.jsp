<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:if test="${loginUser.id == 'admin'}">
	<jsp:include page="../admin/admin_layout/header.jsp">
		<jsp:param value="갤러리 관리 페이지" name="title" />
	</jsp:include>
</c:if>
<style>
body {
	background: #fff;
}
header{

	
}

.tbl {
	border-collapse: collapse;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}

.tbl thead {
	padding: 10px;
	background-color:rgba(213, 194, 238, 0.38);
	border-bottom: 3px solid #D5C2EE;
}

.tbl td {
	color: #669;
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.tbl tr:hover td {
	color: #004;
}
.button{
border: 0;
width: 120px;
padding: 7px;
margin-top: 10px;
margin-left:90%;
background-color: #D5C2EE;
border-radius: 2px;
}
.button:hover{
background-color:  rgba(213, 194, 238, 0.69);
border-radius: 2px;
}
</style>


<c:if test="${loginUser.id != 'admin'}">
	<jsp:include page="../layout/header.jsp">
		<jsp:param value="${bbs.bbsNo}번 게시글 상세내용" name="title" />
	</jsp:include>
</c:if>

<div>
	<div class="header">
		<h2>갤러리 게시판</h2>
	</div>
	<h4>갤러리 목록(전체 ${totalRecord}개)</h4>
	<div>
		<table class="tbl">
			<colgroup>
				<col style="width: 7%">
				<col style="width: 45%">
				<col style="width: 12%">
				<col style="width: 8%">
				<col style="width: 8%">
			</colgroup>
			<thead>
				<tr>
					<td>순번</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>

				</tr>
			</thead>

			<tbody>
				<c:forEach items="${galleryList}" var="gallery" varStatus="vs">
					<tr>
						<td>${beginNo - vs.index}</td>
						<td><a id="moveDetail"
							href="${contextPath}/gallery/increase/hit?galleryNo=${gallery.galleryNo}">${gallery.galleryTitle}</a></td>
						<td>${gallery.id}</td>
						<td>${gallery.createDate}</td>
						<td>${gallery.hit}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">${paging}</td>
				</tr>
			</tfoot>
		</table>
				<input type="button" class="button" id="moveWrite" value="게시글 작성하기"
					onclick="location.href='${contextPath}/gallery/write'">
	</div>
</div>
<script>
// 	$('#moveDetail').click(function(){
// 		if(${loginUser == null}){
// 			alert('로그인한 뒤 조회가능합니다.');
// 			event.preventDefault();
// 			history.back();
// 			location.href='${contextPath}/user/login/form';
// 			return;
// 		}
// 	})
</script>

</body>
</html>