<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/profile.css">
<link rel="stylesheet" href="css/side.css">
<title>WHYWHY</title>
</head>
<body style="background-color: rgba(224,224,224,0.2);">
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 안되어 있습니다.')");
			script.println("location.href = 'main.jsp'");		
			script.println("</script>");
		}
		
		UserDAO dao = new UserDAO();
		User userView = dao.profileView(user, userID);
	%>
	<div class="container" style="height: 100%; padding-top: 50px">
		<div class="col-xs-12 col-md-4">
			<div class="side">
				<aside>
					<p class="logo">
						<a href="main.jsp">와이와이</a>
					</p>
					<details class="details top">
						<summary>
							<a href="bbs.jsp?categoryName=agroup" style="color: white;">▶ 동아리</a>
						</summary>
					</details>
					<details>
						<summary>
							<a href="bbs.jsp?categoryName=bgroup" style="color: white;">▶ 소모임</a>
						</summary>
					</details>
					<details>
						<summary>
							<a href="bbs.jsp?categoryName=post" style="color: white;">▶ 홍보게시판</a>
						</summary>
					</details>
					<details>
						<summary>▶ 마이페이지</summary>
						<ul type="none">
							<li><a href="subParty.jsp" style="color: white">가입 모임 목록</a></li>
							<li><a href="subPartyChat.jsp" style="color: white">가입 채팅 목록</a></li>
							<li><a href="profile.jsp" style="color: white">회원 정보 수정</a></li>
						</ul>
					</details>
				</aside>
			</div>
		</div>
		<div class="col-xs-12 col-md-4" style="height: 100%;">
			<div style="height: 15%;"></div>
			<div class="wrapper">
				<div><h1 style="padding-left: 50px; font-weight: bold;">마 이 프 로 필</h1></div>
				<div class="div-padding">
					<label for="userID" class="label-size">아이디 : </label>
					<span class="span-size"><%=userView.getUserID() %></span>
				</div>
				<div class="div-padding">
					<label for="userName" class="label-size">회원이름 : </label>
					<span class="span-size"><%=userView.getUserName() %></span>
				</div>
				<div class="div-padding">
					<label for="userBirth" class="label-size">생년월일 : </label>
					<span class="span-size"><%=userView.getUserBirthyy() %>년 </span>
					<span class="span-size"><%=userView.getUserBirthmm() %>월 </span>
					<span class="span-size"><%=userView.getUserBirthdd() %>일</span>
				</div>
				<div class="div-padding">
					<label for="userPhone" class="label-size">전화번호 : </label>
					<span class="span-size"><%=userView.getUserPhone() %></span>
				</div>
				<div class="div-padding">
					<button class="button-effect" onclick="location.href='profileChange.jsp'" style="background-color: rgb(189, 189, 189);">수정</button>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-md-4">
				<div class="member">
					<div class="btn-group" role="group">
	            		<button type="button" class="btn btn-outline-primary"><a href="#">프로필</a></button>
	            		<button type="button" class="btn btn-outline-primary"><a href="logoutAction.jsp">로그아웃</a></button>
	       			</div>
	    		</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>