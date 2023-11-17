<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>WHYWHY</title>
</head>
<body>
   <%
      String userID = null;
      if   (session.getAttribute("userID")  != null) {
         userID = (String) session.getAttribute("userID");
         
      }
   %>
   <nav class="navbar navbar-default">
      <div class="navbar-header">
         <button type="button" class="navbar-toggle collapsed"
            data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-expended="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp" style="font-family: 'Jua', sans-serif;">와이와이</a>
      </div>
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
         <ul class="nav navbar-nav">
            <li class="active"><a href="main.jsp" style="font-family: 'Jua', sans-serif;">메인</a><li>
            <li><a href="bbs.jsp?categoryName=agroup" style="font-family: 'Jua', sans-serif;">동아리 게시판</a><li>
            <li><a href="bbs.jsp?categoryName=bgroup" style="font-family: 'Jua', sans-serif;">소모임 게시판</a><li>
            <li><a href="bbs.jsp?categoryName=post" style="font-family: 'Jua', sans-serif;">홍보 게시판</a><li>
         </ul>
         <%
            if(userID == null) {
         %>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="ture"
                  aria-expended="flase" style="font-family: 'Jua', sans-serif;">접속하기<span class="caret"></span></a>
               <ul class="dropdown-menu">
                  <li><a href="login.jsp" style="font-family: 'Jua', sans-serif;">로그인</a></li>
                  <li><a href="join.jsp" style="font-family: 'Jua', sans-serif;">회원가입</a></li>
               </ul>
            </li>
         </ul>
         <%
            } else {
         %>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="ture"
                  aria-expended="flase" style="font-family: 'Jua', sans-serif;">회원관리<span class="caret"></span></a>
               <ul class="dropdown-menu">
               		<li><a href="profile.jsp" style="font-family: 'Jua', sans-serif;">회원정보</a></li>
               		<li><a href="subPartyChat.jsp" style="font-family: 'Jua', sans-serif;">가입 채팅 목록</a></li>
              	 	<li><a href="logoutAction.jsp" style="font-family: 'Jua', sans-serif;">로그아웃</a></li>
               </ul>
            </li>
         </ul>
         <%   
            }
         %>      

      </div>
   </nav>
   <div class="container">
      <img src="images/yy.jpg" alt="Example Image">
      <div class="jumbotron">
         <div class="container">
            <h1 style="font-family: Arial, sans-serif;">원하던 대학교의 생활!</h1>
            <h1 style="font-family: Arial, sans-serif;">다양환 모임을 실천하다.</h1>
            <p style="font-family: Arial, sans-serif;">다양한 동아리 활동교류로 대학생활의 로망을!</p>
            <p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
         </div>
      </div>
   </div>
   <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>