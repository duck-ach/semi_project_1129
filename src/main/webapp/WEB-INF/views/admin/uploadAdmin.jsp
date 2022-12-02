<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="admin_layout/header.jsp">
	<jsp:param value="업로드 관리 페이지" name="title" />
</jsp:include>


<style type="text/css">
	td{text-align:center;}
	td input{
		display: block;
	    width: 20px;
	    height: 20px;	  
	    margin: 2px auto;
	}
	/*
	input[type="checkBox"]{
		padding:5px;
	}
	*/
</style>

<script>

$(function(){

	// 게시글 수정화면으로 이동
	$('#btn_upload_edit').click(function(event){
		$('#frm_upload').attr('action', '${contextPath}/upload/edit');
		$('#frm_upload').submit();
	});
	
	// 게시글 삭제
	$('#btn_upload_remove').click(function(event){
		alert('hi');
		if(confirm('첨부된 모든 파일이 함께 삭제되고, 포인트가 10 차감됩니다.\n삭제하시겠습니까?')){
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

	<div id="parentDiv">
		<div class="upload_header_title">
			<h2 id="upload_title">업로드용 게시판</h2>
			<p id="upload_info">다양한 파일을 공유하는 게시판입니다. 첨부파일을 자유롭게 업로드해 보세요!<br/>
							게시글 작성 시 10포인트를 지급하고, 다운로드 시 첨부파일 하나당 5포인트가 차감됩니다.</p>
		</div>
		<div class="write_div">
			<a id="btn_write" class="btn" href="${contextPath}/upload/write">작성하기</a>
		</div>
		
		<hr>
		
		<div>
			
			<table>
				<colgroup>
					<col style="width:7%">
					<col style="width:35%">
					<col style="width:12%">
					<col style="width:8%">
					<col style="width:8%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${uploadList}" var="upload">
						<tr class="mouse_hover_tit_a">
							<td class="a_hover_tit td_center">${upload.uploadNo}</td>
							<td class="a_hover_tit"><a href="${contextPath}/upload/increase/hit?uploadNo=${upload.uploadNo}">${upload.uploadTitle}</a></td>
							<td class="a_hover_tit td_center">${upload.id}</td>
							<td class="a_hover_tit td_center"><fmt:formatDate value="${upload.createDate}" pattern="yy. M. d HH:mm" /></td>
							<td class="a_hover_tit td_center">${upload.hit}</td>
							<td>
							<form id="frm_upload" method="post">
								<input type="hidden" name="uploadNo" value="${upload.uploadNo}">
								<c:if test="${loginUser.id == 'admin' || loginUser.id == upload.id}">												
									<input type="button" value="게시글삭제" id="btn_upload_remove" class="btn" style="width:150px;"> 			
								</c:if>										
							</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
				<tr>
					<td colspan="10" style="text-align: center;" class="pageNum">
					    ${paging}
					</td>
				</tr>
			</tfoot>
			</table>
		</div>
		
	</div>

</body>
</html>