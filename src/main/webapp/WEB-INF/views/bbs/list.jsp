<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="게시글 리스트" name="list" />
</jsp:include>

	
	<h3>자유 게시판</h3>
	
	<div>
		<a href="${contextPath}/bbs/write">작성</a>
	</div>
	
	<div>
		<table border="1">
			<thead>
				<tr>	
					<td>번호</td>
					<td>제목</td>
					<td>날짜</td>
					<td>조회</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bbsList}" var="bbs" varStatus="vs">
					<tr>
						<td>${beginNo - vs.index}</td>
						<td><a href="${contextPath}/bbs/increase/hit?bbsNo=${bbs.bbsNo}">${bbs.bbsTitle}</a></td>
						<td>${bbs.bbsCreateDate}</td>
						<td>${bbs.bbsHit}</td>
					</tr>
				</c:forEach>
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="4">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
</body>
</html>