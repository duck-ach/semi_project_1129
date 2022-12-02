<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../layout/header.jsp">
   <jsp:param value="블로그목록" name="title" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
   
   $(function(){
      
      fn_login();
      fn_displayRememberId();
      
   });
   
   function fn_login(){
      
      $('#frm_login').submit(function(event){
         
         if($('#id').val() == '' || $('pw').val() == ''){
            alert('아이디와 패스워드를 모두 입력하세요.');
            event.preventDefault();
            return;
         }
         
         if($('#rememberId').is(':checked')){
            $.cookie('rememberId', $('#id').val());
         } else {
            $.cookie('rememberId', '');
         }
         
      });
      
   }
   
   function fn_displayRememberId(){
      
      let rememberId = $.cookie('rememberId');
      if(rememberId == ''){
         $('#id').val('');
         $('#rememberId').prop('checked', false);
      } else {
         $('#id').val(rememberId);
         $('#rememberId').prop('checked', true);
      }
      
   }
   
   
</script>
<style>
   #userLoginForm {
      text-align: center;
      width: 310px;
       margin: 20px auto;
       border: 1px solid teal;
       padding: 20px 50px 100px 50px;
       border-radius: 20px;
   }
   .loginForm {
      width: 300px;
      padding: 14px 17px 13px;
       box-sizing: border-box;
       font-size: 14px;
   }
   .loginForm:hover {
      cursor: pointer;
   }
   #userLoginHeader {
      text-align: center;
   }
   #btn_signin {
       background-color: lightblue;
       border: 1px solid gray;
       width: 300px;
       height: 40px;
       border-radius: 10px;
       font-size: 20px;
       font-weight: 400;
   }
   #btn_signin:hover {
      background-color: #8ae2ff;
      cursor: pointer;
      font-weight: 700;
   }
   #id {
      border-radius: 10px 10px 0 0;
      border-bottom: 0px;
   }
   #pw {
      border-radius: 0 0 10px 10px;
   }
   #mypage_footer {
      text-align: center;
   }
   #mypage_footer_name {
      font-weight: bold;
   }
   #naverLogin_info {
      font-size: 13px;
   }
   #login_checkbox {
      padding: 10px 0 10px 0;
   }
   .checkbox_margin {
      margin: 0 10px 0 10px;
   }
   #sign_in {
      margin-right: 10px;
   }
   #find_idPw{
      margin-left: 10px;
   }
</style>
</head>
<body>
   
   <c:if test="${loginUser == null}">
   
      <div id="userLoginForm">
      
         <header id="userLoginHeader">
         
            <h1>WELCOME!</h1>
            
         </header>
         
         
         <section>
         
            <form id="frm_login" action="${contextPath}/user/login" method="post">
            
               <input type="hidden" name="url" value="${url}">
            
               <div>
               
                  <input type="text" name="id" id="id" class="loginForm" placeholder="아이디">
                  <div id="id_msg"></div>
                  
               </div>
               <div>
               
                  <input type="password" name="pw" id="pw" class="loginForm" placeholder="비밀번호">
                  <div id="pw_msg"></div>
                  
                  <br>
                  
                  <button id="btn_signin">LOG&nbsp;&nbsp;IN</button>
                  
               </div>
               
               <div id="login_checkbox">
                  <span class="checkbox_margin"><label for="rememberId">   
                     <input type="checkbox" id="rememberId">아이디 저장
                  </label></span>
                  <span class="checkbox_margin"><label for="keepLogin">
                     <input type="checkbox" name="keepLogin" id="keepLogin">로그인 유지
                  </label></span>
               </div>
            
            </form>
            
         </section>
         
         <footer>
            
            <div>
               <a id="sign_in" href="${contextPath}/user/agree">회원가입</a>
               <a id="find_idPw" href="${contextPath}/user/find">아이디/비밀번호 찾기</a>
            </div><br>
            
            <div>
            <span id="naverLogin_info">네이버 아이디로 간편하게 로그인하고 싶으신가요?</span>
            <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=bRRJOp5FZR_iFTOgpM3k&redirect_uri=http%3A%2F%2Flocalhost%3A9090%2Fsemi_pjt_2%2Fuser%2Fnaver%2Flogin&state=369583993916108389369394549118797326852"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
            </div>
            
         </footer>
         
      </div>
      
   </c:if>
   
   <c:if test="${loginUser != null}">
      
      <br>
      
      <div id="mypage_footer">
         <a href="${contextPath}/user/check/form" id="mypage_footer_name">${loginUser.name}</a> 님 반갑습니다.<br>
         보유 포인트 : ${loginUser.point} P<br><br>
         <a href="${contextPath}/user/check/form">마이페이지로 이동</a><br>
         <a href="${contextPath}/user/logout">로그아웃</a>
      </div>
      
   </c:if>

</body>
</html>