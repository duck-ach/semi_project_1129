<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="admin_layout/header.jsp">
	<jsp:param value="자유게시판 관리 페이지" name="title" />
</jsp:include>

<style>
	.blind {
		display: none;
	}
	.div_title {
		font-size: 32px;
		font-weight: 1000;
		margin-top: 50px;
		margin-left: 10px;
		color: #D5C2EE;
		
	}
	.div_iddate{
		text-align: right;
    	color: #C8C8C8;
    	font-size: 12px;
    	margin-top: 20px;
    	margin-right: 20px;
	}
	.commentId {
		font-weight: bold;
	}
	.div_bbs_comm_list {
		margin-bottom: 5px;
	}
	.div_bbs_content {
		height: 300px;
	    overflow-x: auto;
	}
	.div_paging{
		width: 30%;
	    display: flex;
	    flex-wrap: nowrap;
	    justify-content: space-evenly;
	    margin: 0 auto;	
	    margin-bottom: 30px;
	}
	
	.btn {
	   width : 70px;
	   display : inline-block;
	   height: 30px;
	   border-radius: 3px;
	   box-sizing: border-box;
	   line-height: 30px;
	   text-align: center;
	   background: #FFF;
	   border: 1px solid #D5C2EE;
	   color: #D5C2EE;
	   font-size: 14px;
	   margin: 1px;
	   margin-left: 10px;
	}

	.btn:hover {
	   width : 70px;
	   display : inline-block;
	   height: 30px;
	   border-radius: 3px;
	   box-sizing: border-box;
	   line-height: 30px;
	   text-align: center;
	   background-color: #D5C2EE;
	   border: 1px solid #D5C2EE;
	   color: #fff;
	   font-size: 14px;
	   margin: 1px;
	   margin-left: 10px;
	}
		
	.add_comment {
		margin: 0 auto;
		margin-bottom: 15px;
		width: 1100px;
	}
	
	.div-buttons {
		margin-right: 0;
		margin-bottom: 50px;
	}
	
	
</style>

	<h3>자유 게시판</h3>
	
	<div>
		<a href="${contextPath}/bbs/write">작성</a>
	</div>
	
	<div>
		<table>
			<thead>
				<tr>	
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회</td>
					<td>삭제</td>
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
						<td>
						<form id="frm_btn" method="post">		
							<input type="hidden" name="bbsNo" value="${bbs.bbsNo}">					
							<input class="btn" type="button" value="삭제" id="btn_remove_bbs">							
						</form>
						</td>
						
						
						
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
	
	<script>		
		$('#btn_remove_bbs').click(function(){
			alert('hi');
			if(confirm('게시글을 삭제하면 게시글에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
				$('#frm_btn').attr('action','${contextPath}/bbs/remove');
				$('#frm_btn').submit();
			}
		});		
	</script>
	
</body>
</html>