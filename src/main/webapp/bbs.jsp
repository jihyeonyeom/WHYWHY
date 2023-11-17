<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="bbs.Bbs" %>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/side.css">
<title>WhyWhy</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String categoryName = null;
		if(request.getParameter("categoryName") != null) {
			categoryName = request.getParameter("categoryName");
		}
		if(categoryName == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 카테고리입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
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
		else if(categoryName.equals("party")) {
			groupName = "가입 모임 목록";
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
			<div id="section-blank"><h1 style="margin-left: 130px; margin-top: 80px; font-size: 50px"><%= groupName%></h1></div>
			<div id="footer">
				<div class="container">
					<div class="row">
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;">카테고리</th>
									<th style="background-color: #eeeeee; text-align: center;">번호</th>
									<th style="background-color: #eeeeee; text-align: center;">제목</th>
									<th style="background-color: #eeeeee; text-align: center;">작성자</th>
									<th style="background-color: #eeeeee; text-align: center;">작성일</th>
									<th style="background-color: #eeeeee; text-align: center;">모집인원</th>
								</tr>
							</thead>
							<tbody>
								<%
								BbsDAO bbsDAO = new BbsDAO();
								ArrayList<Bbs> list = bbsDAO.getList(pageNumber, categoryName);
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
								<tr onClick="location.href='view.jsp?partyNum=<%= list.get(i).getPartyNum()%>';" style="cursor: pointer; height: 60px">
									<td style="vertical-align: middle;"><%= name %></td>
									<td style="vertical-align: middle;"><%= list.get(i).getPartyNum() %></td>
									<td style="vertical-align: middle;"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
									<td style="vertical-align: middle;"><%= userName %></td>
									<td style="vertical-align: middle;"><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시 " + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
									<td style="vertical-align: middle;"><%= list.get(i).getNowNum() + "/" + list.get(i).getMaxNum()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
						<%
							if(pageNumber != 1) {
						%>
							<a href="bbs.jsp?categoryName=<%= categoryName%>&pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left" 
							style="font-size: 15px; color: white; background-color: rgb(189, 189, 189); width: 60px;">이전</a>
						<%
							} if(list.size() - pageNumber * 10 > 0) {
						%>
							<a href="bbs.jsp?categoryName=<%= categoryName%>&pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left" 
							style="font-size: 15px; color: white; background-color: rgb(189, 189, 189); width: 60px;">다음</a>
						<%
							}
						%>
						<a href="write.jsp?categoryName=<%= categoryName%>" class="btn btn-primary pull-right" style="font-size: 15px; background-color: rgb(189, 189, 189); color: white; width: 90px">글쓰기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>