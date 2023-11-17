<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.util.ArrayList"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/side.css">
<link rel="stylesheet" href="css/subPage.css">
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
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
	<div id="total">
		<div id="nav"></div>
		<div id="total-right">
			<div id="section-blank"><h1 style="margin-left: 130px; margin-top: 50px;">모임 채팅 목록</h1></div>
			<div id="footer">
				<div class="container">
					<div class="row">
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;">카테고리</th>
									<th style="background-color: #eeeeee; text-align: center;">채팅방 번호</th>
									<th style="background-color: #eeeeee; text-align: center;">제목</th>
									<th style="background-color: #eeeeee; text-align: center;">방장</th>
									<th style="background-color: #eeeeee; text-align: center;">인원</th>
								</tr>
							</thead>
							<tbody>
								<%
									BbsDAO bbsDAO = new BbsDAO();
									ArrayList<Bbs> list = bbsDAO.getPartyList(userID);
									int number = 0;
									if(pageNumber * 10 > list.size()) {
										number = list.size();
									} else {
										number = pageNumber * 10;
									}
									for (int i = 0 + (pageNumber - 1) * 10; i < number; i++) {
										String name = null;
										if(list.get(i).getCategoryName().equals("agroup")) {
											name = "동아리";
										}
										else if(list.get(i).getCategoryName().equals("bgroup")) {
											name = "소모임";
										}
										else if(list.get(i).getCategoryName().equals("post")) {
											name = "홍보";
										}
										String userName = bbsDAO.getUserName(list.get(i).getUserID());
								%>
								<tr onClick="location.href='chat.jsp?toID=<%= list.get(i).getPartyNum()%>';" style="cursor: pointer; height: 60px">
									<td style="vertical-align: middle;"><%= name %></td>
									<td style="vertical-align: middle;"><%= list.get(i).getPartyNum() %></td>
									<td style="vertical-align: middle;"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
									<td style="vertical-align: middle;"><%= userName %></td>
									<td style="vertical-align: middle;"><%= list.get(i).getNowNum() + "/" + list.get(i).getMaxNum()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
				<div style="width: 1100px; padding-left: 30px;">
				<%
					 if(pageNumber != 1) {
				%>
					<a href="subParty.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success btn-arrow-left" 
					style="background-color: rgb(189, 189, 189); color: white; font-size: 20px; width: 100px;">이전</a>
				<%
					} if(list.size() - pageNumber * 10 > 0) {
				%>
					<a href="subParty.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success btn-arrow-left" 
					style="background-color: rgb(189, 189, 189); color: white; font-size: 20px; width: 100px;">다음</a>
				<%
					}
				%>
				</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>