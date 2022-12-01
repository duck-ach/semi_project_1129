<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="게시글 리스트" name="list" />
</jsp:include>
<<style>
	.table_class {
		text-align: center;
		width: 80%;
    	margin: auto;
	}
	.div_bbs_deamoon {
		font-size: 32px;
	    font-weight: bold;
	    margin: auto;
	    width: 80%;
	    text-align: left;
	    margin-bottom: 35px;
	}
	.div_paging{
		width: 30%;
	    display: flex;
	    flex-wrap: nowrap;
	    justify-content: space-evenly;
	    margin: 0 auto;	
	    margin-top: 30px;
	}	
	
	.div_write_link{
		position: relative;	
		width: 80%;
		margin: 0 auto;
	}
	
	.a_write_link{
		text-align: right;
		border: 1px solid #000;
	    display: block;
	    width: 40px;
	    text-align: center;
	    margin-left: auto;
	    margin-bottom: 15px;
	    position: absolute;
	    right: 113px;
	    top: -29px;
	}
	

</style>

	
	<div class="div_bbs_deamoon">자유 게시판</div>
	<div></div>
	
	<div class="div_write_link">
		<a class="a_write_link" href="${contextPath}/bbs/write">작성</a>
	</div>
	
	<div>
		<table class="table_class">
			<thead>
				<tr>	
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bbsList}" var="bbs" varStatus="vs">
					<tr>
						<td>${beginNo - vs.index}</td>
						<td><a href="${contextPath}/bbs/increase/hit?bbsNo=${bbs.bbsNo}">${bbs.bbsTitle}</a></td>
						<td>${bbs.id}</td>
						<td>${bbs.bbsCreateDate}</td>
						<td>${bbs.bbsHit}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="div_paging">
		${paging}
	</div>
	
</body>
</html>