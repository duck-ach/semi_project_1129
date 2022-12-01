<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="업로드목록" name="title" />
</jsp:include>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/uploadcss/list.css">
</head>
<body>

	<div id="parentDiv">
		<div class="upload_header_title">
			<h2 id="upload_title">업로드용 게시판</h2>
			<p id="upload_info">다양한 파일을 공유하는 게시판입니다. 첨부파일을 자유롭게 업로드해 보세요!</p>
		</div>
		<div class="write_div">
			<a id="btn_write" class="btn" href="${contextPath}/upload/write">작성하기</a>
		</div>
		
		<hr>
		
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
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
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