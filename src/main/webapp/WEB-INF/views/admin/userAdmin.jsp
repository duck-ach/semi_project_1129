<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="admin_layout/header.jsp">
	<jsp:param value="유저 관리 페이지" name="title" />
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


	$(window).on('load', function(){
		fn_getlist();
		
		
	});
	
	

	 $("body").on("click", ".checkUserNo", function() {
		 /* 탈퇴 휴면 중복 체크 방지  */		  
		 
		 var thisPrevCheck = $(this).next('.checkSleepUserNo').children();
		 if($(thisPrevCheck).is(":checked") == true){
			 alert('탈퇴와 휴면을 동시에 진행할 순 없습니다.');
			 $(thisPrevCheck).prop("checked", false); 
			 $(this).children().prop("checked", false);
		 }
		 
		 
		 var td_check = $(this).children();
		 var td_userNo = $(this).parent().children('.td_userNo').text();
		 var td_userId = $(this).parent().children('.userId').text();
		 var td_userJoinData = $(this).parent().children('.userJoinDate').text();
		 
		 if($(td_check).is(":checked") == true){			 
			 $(this).children().attr('value',td_userNo);
			 $(this).parent().children('.userIdIn').attr('name','id').attr('value',td_userId);
			 $(this).parent().children('.userJoinDateIn').attr('name','joinDate').attr('value',td_userJoinData);
			
			 if(  $(this).children().val() == 1 )
			 {
			
				 alert('[admin] 계정을 삭제하면 주인님과 저는 만날 수 없어요... \n\n ‧º·(˚ ˃̣̣̥⌓˂̣̣̥ )‧º·˚');		
				 $(this).children().attr('value','');
				 event.preventDefault();  // 서브밋을 막음
					return;  // 코드 진행을 막음
			 }
		 
		 }else{
				$(this).children().attr('value','');
				$(this).parent().children('.userIdIn').attr('name','').attr('value','');
				 $(this).parent().children('.userJoinDateIn').attr('name','').attr('value','');
			}
		
		 
		 
		
		//	$('.remov_submit_check').clone().attr('value',td_val).attr('name','userNo').removeClass().appendTo($('#frm_search'));
		
	 });
	 
	 
	 $("body").on("click", ".checkSleepUserNo", function() {
		 /* 탈퇴 휴면 중복 체크 방지  */		 
		 var thisPrevChecks = $(this).prev('.checkUserNo').children();
		 if($(thisPrevChecks).is(":checked") == true  ){
			 alert('탈퇴와 휴면을 동시에 진행할 순 없습니다.');
			 $(thisPrevChecks).prop("checked", false); 
			 $(this).children().prop("checked",false);
		 }
		 
		 
		 /* 휴면 테이블로 넘기기   */
		 var td_check = $(this).children();
		 var td_userNo = $(this).parent().children('.td_userNo').text();
		 var td_userId = $(this).parent().children('.userId').text();
		 var td_userJoinData = $(this).parent().children('.userJoinDate').text();
		 
		 if($(td_check).is(":checked") == true){			 
			 $(this).children().attr('value',td_userNo);
			 $(this).parent().children('.userIdIn').attr('name','id').attr('value',td_userId);
			 $(this).parent().children('.userJoinDateIn').attr('name','joinDate').attr('value',td_userJoinData);
			
			 if(  $(this).children().val() == 1 )
			 {
			
				 alert('[admin] 계정을 삭제하면 주인님과 저는 만날 수 없어요... \n\n ‧º·(˚ ˃̣̣̥⌓˂̣̣̥ )‧º·˚');		
				 $(this).children().attr('value','');
				 event.preventDefault();  // 서브밋을 막음
					return;  // 코드 진행을 막음
			 }
		 
		 }else{
				$(this).children().attr('value','');
				$(this).parent().children('.userIdIn').attr('name','').attr('value','');
				 $(this).parent().children('.userJoinDateIn').attr('name','').attr('value','');
			}
		
		 
		 
	 });
	
	function fn_getlist() {
		
		$.ajax({
			type: 'get',
			url : '${contextPath}/searchAllUsers',
			dataType: 'json',
			success: function(resData) {
				$('#list').empty();				
			//	alert("전체"+trs+" 개의 목록을 가져왔습니다.");
				$.each(resData, function(i, users){
					$('<tr>')
					.append($('<td class="userId" name="id">').text(users.id))
					.append($('<input type="hidden" name="" value=""  class="userIdIn">'))
					.append($('<td class="td_userNo">').text(users.userNo))
					.append($('<td>').text(users.name))					
					.append($('<td>').text(users.gender))					
					.append($('<td>').text(users.email))
					.append($('<td>').text(users.mobile))
					.append($('<td class="userJoinDate">').text(users.joinDate))
					.append($('<input type="hidden" value=""  class="userJoinDateIn">'))
					.append($('<td>').text(users.userLevel))
					.append($('<td>').text(users.point))
				//	.append($('<td>').text(${cntUserBoard}))
					
					
					.append($('<td class="checkUserNo">').html("<input type='checkBox' name='userNo' >"))
					.append($('<td class="checkSleepUserNo">').html("<input type='checkBox' name='userNo' >"))	
					.appendTo('#list');					
				});
				
			}
		});
		
	}
	
	$(document).ready(function(){
		/** 시작후 전체 리스트 개수 세어오는 구간 */
		setTimeout(function() {
			var title_count = $('#list').children('tr').length;
			$('.title_count').text(title_count);
			}, 500);

			
		
		
		
		
		
		$('#btn_search').click(function(){
			$.ajax({
				type : 'get',
				url : '${contextPath}/searchUser',
				data : 'column=' + $('#column').val() + '&searchText=' + $('#searchText').val(),
				dataType : 'json',
				success : function(resData) {
					$('#list').empty();
					$.each(resData, function(i, users){
						$('<tr>')
						
						.append($('<td>').text(users.id))
						.append($('<td>').text(users.userNo))
						.append($('<td>').text(users.name))
						.append($('<td>').text(users.gender))
						.append($('<td>').text(users.email))
						.append($('<td>').text(users.mobile))
						.append($('<td>').text(users.joinDate))
						.append($('<td>').text(users.point))
						.append($("<input type='checkBox' name='userNo' value="+"${users.userNo}>"))
						
						.appendTo('#list');
					});
				}
			});
		});
		
		
		$('.del_user_click').click(function(){
			if(confirm('회원정보를 삭제할까요?') == false){
				event.preventDefault();  // 서브밋을 막음
				return;  // 코드 진행을 막음
			}else{
				 $("#frm_search").attr("action","${contextPath}/admin/remove").submit();				
				
			}
			
		}); 
		
		$('.sleep_user_click').click(function(){
			if(confirm('회원을 휴면계정으로 처리할까요?') == false){
				event.preventDefault();  // 서브밋을 막음
				return;  // 코드 진행을 막음
			}else{
				 $("#frm_search").attr("action","${contextPath}/admin/sleep").submit();				
				
			}
			
		}); 
		
		
		
		
		$('#btn_init').click(function(){
			fn_getlist();
		});

		
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
						<td>회원 이름</td>
						<td>회원 성별</td>
						<td>회원 이메일</td>
						<td>회원 핸드폰번호</td>
						<!--  
						<td>회원 생년월일</td>
						<td>회원 주소</td>
						-->
						<td>회원 가입일</td>						
						<td>회원 포인트</td>	
					<!--  
						<td>작성 글 수</td>
					-->
						<td><button class="del_user_click">탈퇴처리</button>  </td>
						<td><button class="sleep_user_click">휴면처리</button>  </td>
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
				
			</table>
			
		</form>
		
	</div>

</body>
</html>