<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File" %>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
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
	if(userID == null){
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
		groupName = "동아리 게시글";
	}
	else if(categoryName.equals("bgroup")) {
		groupName = "소모임 게시글";
	}
	else if(categoryName.equals("post")) {
		groupName = "홍보 게시글";
	}
	int partyNum = 0;
	if(request.getParameter("partyNum") != null) {
		partyNum = Integer.parseInt(request.getParameter("partyNum"));
	}
	if(partyNum == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시물이 존재하지 않습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(partyNum);
	if(!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
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
	<p class="logo">
		<a href="main.jsp">WHYWHY</a>
	</p>
	<div class="container" style="margin-top: 50px;">
		<div class="row">
			<form method="post" action="updateAction.jsp?partyNum=<%= partyNum%>" enctype="multipart/form-data">
				<table class="table">
					<thead>
						<tr>
							<th colspan="2" style="text-align: center; font-size: 50px;"><%= groupName%> 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>글 제목<input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td>글 내용<textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 400px;"><%= bbs.getBbsContent()%></textarea></td>
						</tr>
						<tr>
							<td>파일 수정을 원할 경우만 파일 선택<input type="file" name="file"></td>
						</tr>
					</tbody>
				</table>
				<div class="col-xs-1" style="padding-left: 8px; padding-right: 8px;"><input class="form-control" type="number" min="1" max="20" name="maxNum" value="<%= bbs.getMaxNum()%>"></div>
				<input type="submit" class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px; margin-left: 8px;" value="글 수정">
				<a href="javascript:window.history.back();" class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px; color: white">뒤로가기</a>
			</form>		
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>