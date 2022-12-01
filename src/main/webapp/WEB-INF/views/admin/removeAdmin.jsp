<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="admin_layout/header.jsp"> 
	<jsp:param value="탈퇴 유저 페이지" name="title" />
</jsp:include>


<style type="text/css">
	td{text-align:center;}
	td input{
		display: block;
	    width: 20px;
	    height: 20px;	  
	    margin: 2px auto;
	}
</style>

<script>

	function fn_getlist() {
		
		$.ajax({
			type: 'get',
			url : '${contextPath}/searchRemoveAllUsers',
			dataType: 'json',
			success: function(resData) {
				$('#list').empty();				
			//	alert("전체"+trs+" 개의 목록을 가져왔습니다.");
				$.each(resData, function(i, users){
					$('<tr>')
					.append($('<td class="userId" name="id">').text(users.id))				
					.append($('<td class="td_userNo">').text(users.userNo))				
					.append($('<td class="userJoinDate">').text(users.joinDate))				
					.append($('<td class="userJoinDate">').text(users.retireDate))			
					.appendTo('#list');					
				});
				
			}
		});
		
	}
	
	$(document).ready(function(){
		
		fn_getlist();
		
		/** 시작후 전체 리스트 개수 세어오는 구간 */
		alert('hi');
		setTimeout(function() {
			var title_count = $('#list').children('tr').length;
			$('.title_count').text(title_count);
			}, 500);		
	}); // $(document).ready(function(){
	
	
	
	
</script>
</head>
<body>

	<div class="wrap">
	<h1>전체 목록 <span class="title_count" ></span> 개</h1>
	
		<form id="frm_search" method="post">
			<select id="column" name="column">
				<option value="NAME">이름</option>
				<option value="USER_NO">회원번호</option>
				<!-- 
				<option value="DESCRIPTION">내용</option>
				 -->
			</select>
			<input type="text" id="searchText" name="searchText">
			<input type="button" id="btn_search" value="검색">
			<input type="button" id="btn_init" value="초기화">
			
			<!--  
			<input type="hidden"  class="remov_submit_check"  name='userNo'>
			-->
			<br><hr><br>
			
			<table border="1">
				<thead>
					<tr>
						
						<td>회원 아이디</td>
						<td>회원 번호</td>					
						
						<td>회원 가입일</td>						
						
						<td>회원 탈퇴일</td>	
					<!--  
						<td>작성 글 수</td>
					-->
					<!--  
						<td><button class="del_user_click">탈퇴</button>  </td>
					-->
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
				
			</table>
			
		</form>
		
	</div>

</body>
</html>