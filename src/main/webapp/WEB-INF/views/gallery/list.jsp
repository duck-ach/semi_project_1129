<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:if test="${loginUser.id == 'admin'}">
<jsp:include page="../admin/admin_layout/header.jsp">
   <jsp:param value="갤러리 관리 페이지" name="title" />
</jsp:include>
</c:if>
<style>
/* *{ */
/* background-color: white; */
/* } */
/* .h2{ */
/*   font-size: 30px; */
/*   color: #fff; */
/*   text-transform: uppercase; */
/*   font-weight: 300; */
/*   text-align: center; */
/*   margin-bottom: 15px; */
/* } */
/* table{ */
/*   background-color:rgba(255,255,255,0.3); */
/*   width:100%; */
/*   table-layout: fixed; */
/* } */
/* .tbl-header{ */
/*   background-color: #C1AEEE ; */
/*  } */
/* .tbl-content{ */
/*   height:300px; */
/*   overflow-x:auto; */
/*   margin-top: 0px; */
/*   border: 1px solid rgba(255,255,255,0.3); */
/* } */
/* thead{ */
/*   padding: 20px 15px; */
/*   text-align: left; */
/*   font-weight: 500; */
/*   font-size: 12px; */
/*   color: #fff; */
/*   text-transform: uppercase; */
/* } */
/* td{ */
/*   padding: 15px; */
/*   text-align: left; */
/*   vertical-align:middle; */
/*   font-weight: 300; */
/*   font-size: 12px; */
/*   color: #fff; */
/*   border-bottom: solid 1px rgba(255,255,255,0.1); */
/* } */

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
	<input type="button" class="button" id="moveWrite" value="게시글 작성하기" onclick="location.href='${contextPath}/gallery/write'">
	<h4>갤러리 목록(전체 ${totalRecord}개)</h4>
	<div>
		<table>
		<colgroup>
					<col style="width:7%">
					<col style="width:45%">
					<col style="width:12%">
					<col style="width:8%">
					<col style="width:8%">
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
						<td><a id="moveDetail" href="${contextPath}/gallery/increase/hit?galleryNo=${gallery.galleryNo}">${gallery.galleryTitle}</a></td>
						<td>${gallery.id}</td>						
						<td>${gallery.createDate}</td>
						<td>${gallery.hit}</td>
						<td>${likedCnt}</td>
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