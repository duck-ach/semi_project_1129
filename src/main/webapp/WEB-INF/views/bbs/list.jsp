<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="게시글 리스트" name="list" />
</jsp:include>
<style>
	.table_class {
		text-align: center;
		width: 70%;
    	margin: auto;
    	border-collapse: collapse;
	}
	.div_bbs_deamoon {
		font-size: 32px;
	    font-weight: bold;
	    margin: auto;
	    width: 70%;
	    text-align: left;
	    margin-bottom: 15px;
	    margin-top: 40px;
	    color: #D5C2EE;
	}
	.div_paging{
		width: 30%;
	    display: flex;
	    flex-wrap: nowrap;
	    justify-content: space-evenly;
	    margin: 0 auto;	
	    margin-top: 30px;
	}	
	
	/* .div_write_link{
		position: relative;	
		width: 80%;
		margin: 0 auto;
	}
	
	.a_write_link{
		text-align: right;
	    display: block;
	    text-align: center;
	    margin-left: auto;
	    margin-bottom: 15px;
	    position: absolute;
	    right: 113px;
	    top: -29px;
	    color: #fff;
	    background-color: #D5C2EE;
	    border-radius: 3px;
	    font-size: 20px;
	} */
	
	.tr-class {
		height: 30px;	
	}
	
	.tr-class:hover {
		background-color: #D5C2EE;
		color: #FFF;
		/* opacity: 0.2; */
	}
	
	.tr-class:hover  a{
		background-color: #D5C2EE;
		color: #FFF;
	}
	
	.title-a-class:hover {
		color: #FFF;
	}
	.btn {
	    width: 100px;
	    display: inline-block;
	    height: 40px;
	    border-radius: 3px;
	    box-sizing: border-box;
	    line-height: 30px;
	    text-align: center;
	    background: #FFF;
	    border: 3px solid #D5C2EE;
	    color: #D5C2EE;
	    font-size: 19px;
	    margin: 1px;
	    margin-left: 10px;
	}

	.btn:hover {
	   width : 100px;
	   display : inline-block;
	   height: 40px;
	   border-radius: 3px;
	   box-sizing: border-box;
	   line-height: 30px;
	   text-align: center;
	   background-color: #D5C2EE;
	   border: 1px solid #D5C2EE;
	   color: #fff;
	   font-size: 19px;
	   margin: 1px;
	   margin-left: 10px;
	}	
	
	.div_btn_write {
		text-align: right;
	    width: 89%;
	    margin-bottom: 20px;
	}
	
	.div_poo {
		width: 70%;
	    color: #B7A4EE;
	    text-align: #B7A4EE;
	    text-align: left;
	    margin: auto;
	    font-size: 12px;
	    border-left: 1px solid;
	    padding-left: 10px;
	}

</style>
<script>
	$(document).ready(function(){
		$('#btn_write').click(function(){
			location.href = '${contextPath}/bbs/write';
		});	
	});
</script>
	
	<div class="div_bbs_deamoon">자유 게시판</div>
	<div class="div_poo">내가 싸고싶은 똥을 텍스트로 싸질러요! <br> 똥은 똥꼬로만 싸는게 아니에요~! 손가락으로도 쌀 수 있어요!</div>
	
	<div class="div_btn_write">
		<input class="btn" type="button" value="작성하기" id="btn_write"> 
	</div>
	
	<div>
		<table class="table_class">
			<thead>
				<tr style="height: 40px; font-size: 18px; font-weight: bold; color: #D5C2EE;">	
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bbsList}" var="bbs" varStatus="vs">
					<tr class="tr-class">
						<td>${beginNo - vs.index}</td>
						<td><a class="title-a-class" href="${contextPath}/bbs/increase/hit?bbsNo=${bbs.bbsNo}">${bbs.bbsTitle}</a></td>
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