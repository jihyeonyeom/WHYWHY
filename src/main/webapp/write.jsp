<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/write.css">
<title>WHYWHY</title>
</head>
<body style="background-color: rgba(224, 224, 224, 0.2);">
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	String categoryName = null;
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	String groupName = null;
	if(categoryName.equals("agroup")) {
		groupName = "동아리 게시판";
	}
	else if(categoryName.equals("bgroup")) {
		groupName = "소모임 게시판";
	}
	else if(categoryName.equals("post")) {
		groupName = "홍보 게시판";
	}
	%>
	<%
	if (userID == null) {
	%>
	<div class="member">
		<div class="btn-group" role="group"
			aria-label="Basic outlined example">
			<button type="button" class="btn btn-outline-primary">
				<a href="join.jsp">회원가입</a>
			</button>
			<button type="button" class="btn btn-outline-primary">
				<a href="login.jsp">로그인</a>
			</button>
		</div>
	</div>
	<%
	} else {
	%>
	<div class="member">
		<div class="btn-group" role="group"
			aria-label="Basic outlined example">
			<button type="button" class="btn btn-outline-primary">
				<a href="profile.jsp">프로필</a>
			</button>
			<button type="button" class="btn btn-outline-primary">
				<a href="logoutAction.jsp">로그아웃</a>
			</button>
		</div>
	</div>
	<%
	}
	%>
	<p class="logo">
		<a href="main.jsp">와이와이</a>
	</p>
	<div class="container" style="margin-top: 100px;">
		<div class="row">
			<form method="post" action="writeAction.jsp?categoryName=<%= categoryName%>" enctype="multipart/form-data">
				<table class="table">
					<thead>
						<tr>
							<th colspan="2" style="text-align: center; font-size: 50px;"><%= groupName%> 글쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 400px;"></textarea></td>
						</tr>
						<tr>
							<td><input type="file" name="file"></td>
						</tr>
					</tbody>
				</table>
				<div class="col-xs-1" style="padding-left: 8px; padding-right: 8px;"><input class="form-control" type="number" min="1" max="20" name="maxNum" value="1"></div>
				<input type="submit" class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px;" value="글쓰기">
				<input onclick="history.back()" class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px; margin-right: 8px;" value="뒤로가기">
			</form>		
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>