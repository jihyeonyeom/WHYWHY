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
<link rel="stylesheet" href="css/write.css">
<title>WHYWHY</title>
</head>
<body style="background-color: rgba(224, 224, 224, 0.2);">
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int partyNum = 0;
	if(request.getParameter("partyNum") != null) {
		partyNum = Integer.parseInt(request.getParameter("partyNum"));
	}
	if(partyNum == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 글입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(partyNum);
	BbsDAO bbsDAO = new BbsDAO();
	int partyCheck = 0;
	partyCheck = bbsDAO.checkMyParty(userID, partyNum);
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
		<a href="main.jsp">WHYWHY</a>
	</p>
	<div class="container" style="margin-top: 100px;">
		<div class="row">
			<table class="table" style="border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="5" style="text-align: center; font-size: 20px;">그룹원 목록</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;">글 제목 : </td>
					<td colspan="4" style="text-align: left;"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
				</tr>
				<%
					ArrayList<Bbs> list = bbsDAO.getMember(partyNum);
					for (int i = 0; i < list.size(); i++){
				%>
				<tr>
					<td>아이디 : </td>
					<td style="text-align: left;"><%= list.get(i).getUserID() %></td>
					<td>등급 : </td>
					<td style="text-align: left;"><%= list.get(i).getPartyLeader() %></td>
				<%
					if(!list.get(i).getPartyLeader().equals("파티장")){
				%>
					<td><a onclick="return confirm('추방하시겠습니까?')" href="partyDeportAction.jsp?partyNum=<%= partyNum%>&getUserID=<%= list.get(i).getUserID()%>" style="color: blue;">그룹추방</a></td>
				<%
					} else {
				%>
					<td></td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
			</table>
		</div>
	</div>
	<div class="container" style="margin-top: 80px;">
		<div class="row">
			<table class="table" style="border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="3" style="text-align: center; font-size: 20px;">그룹 가입신청 목록</th>
				</tr>
			</thead>
			<tbody>
			<%
				ArrayList<Bbs> waitList = bbsDAO.getWaitMember(partyNum);
				for(int i = 0; i < waitList.size(); i++){
			%>
				<tr>
					<td>아이디 : </td>
					<td><%= waitList.get(i).getUserID() %></td>
					<td style="text-align: right;"><a onclick="return confirm('수락하시겠습니까?')" href="partyJoinAction.jsp?partyNum=<%= partyNum%>&getUserID=<%= waitList.get(i).getUserID()%>" style="color: blue; margin-right: 30px;">가입수락</a>
						<a onclick="return confirm('거절하시겠습니까?')" href="partyRefuseAction.jsp?partyNum=<%= partyNum%>&getUserID=<%= waitList.get(i).getUserID()%>" style="color: blue; margin-right: 50px;">가입거절</a></td>
				</tr>
			<%
				}
			%>
			</tbody>
			</table>
			<a href="view.jsp?partyNum=<%= partyNum%>" class="btn btn-primary" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px; color: white">뒤로가기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>