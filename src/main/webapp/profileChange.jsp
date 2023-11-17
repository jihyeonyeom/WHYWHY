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
<link rel="stylesheet" href="css/join.css">
<link rel="stylesheet" href="css/side.css">
<title>WHYWHY</title>
</head>
<body style="background-color: rgba(224,224,224,0.2)">
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
	<div class="container" style="padding-top: 50px">
		<div class="col-xs-12 col-md-4">
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
		</div>
		<div class="col-xs-12 col-md-4">
			<div class="wrapper">
				<form method="post" action="profileAction.jsp">
					<div><h1>회원정보수정</h1></div>
					<div class="form-group" style="padding-top: 20px">
						<label for="userID">아이디</label>
						<input type="text" class="form-control" value="<%=userView.getUserID() %>" name="userID" readonly>
					</div>
					<div class="form-group">
						<label for="userName">이름</label>
						<input type="text" class="form-control" value="<%=userView.getUserName() %>" name="userName" maxlength="20">
					</div>
					<div class="form-group">
						<label for="userBirth">생년월일</label>
						<div class="form-inline">
							<input type="text" class="form-control birthyy" value="<%=userView.getUserBirthyy() %>" name="userBirthyy" maxlength="4">
							<select class="form-control birthmm" name="userBirthmm">
							<option value="<%=userView.getUserBirthmm() %>" hidden><%=userView.getUserBirthmm() %></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							</select>
							<input type="text" class="form-control birthdd" value="<%=userView.getUserBirthdd() %>" name="userBirthdd" maxlength="2">
						</div>
					</div>
					<div class="form-group">
						<label for="userPhone">전화번호</label>
						<input type="tel" class="form-control" value="<%=userView.getUserPhone() %>" name="userPhone" maxlength="12">
					</div>
					<div class="form-group">
						<label for="userPassword">비밀번호확인</label>
						<input type="password" class="form-control" placeholder="내용을 입력해주세요." name="userPassword" maxlength="20">
					</div>
					<div style="padding-top: 10px">
						<input type="submit" id="submit" class="form-control submit" style="background-color: rgb(189, 189, 189);" value="수정하기">
					</div>
				</form>
			</div>
		</div>
		<div class="col-xs-12 col-md-4">
				<div class="member">
					<div class="btn-group" role="group">
	            		<button type="button" class="btn btn-outline-primary"><a href="profile.jsp">프로필</a></button>
	            		<button type="button" class="btn btn-outline-primary"><a href="logoutAction.jsp">로그아웃</a></button>
	       			</div>
	    		</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>