<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File" %>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
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
	
	String categoryName = null;
	categoryName = bbs.getCategoryName();
	String groupName = null;
	if(categoryName.equals("agroup")) {
		groupName = "동아리";
	}
	else if(categoryName.equals("bgroup")) {
		groupName = "소모임";
	}
	else if(categoryName.equals("post")) {
		groupName = "홍보";
	}
	
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	int cmtParent = 0;
	String userName = bbsDAO.getUserName(bbs.getUserID());
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
			<table class="table" style="border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="4" style="text-align: center; font-size: 20px;"><%= groupName + " 게시글"%></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;">글 제목 : </td>
					<td colspan="3" style="text-align: left;"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
				</tr>
				<tr>
					<td>작성자 : </td>
					<td colspan="3" style="text-align: left;"><%= userName %></td>
				</tr>
				<tr>
					<td>작성일자 : </td>
					<td style="text-align: left;"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시 " + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					<td>모집인원 : </td>
					<td style="text-align: left;"><%= bbs.getNowNum() + "/" + bbs.getMaxNum()%></td>
				</tr>
				<tr>
					<td>내용 : </td>
					<td colspan="3" style="height: 300px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>
				<%
					if((userID != null && userID.equals(bbs.getUserID())) || (userID != null && partyCheck == 1)) {
				%>
				<tr>
				<%
					String directory = application.getRealPath("/upload/");
					String files[] = new File(directory).list();
				%>
					<td>파일첨부 : </td>
					<td colspan="3" style="text-align: left;"><% for(String file : files){
						if(file.equals(bbs.getFileRealName())){
							out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
									java.net.URLEncoder.encode(file, "UTF-8") + "\">" + file + "</a><br>");}} %></td>
				</tr>
				<%
					}
				%>
			</tbody>
			</table>
			<a href="javascript:window.history.back();" class="btn btn-primary" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px; color: white">뒤로가기</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?partyNum=<%= partyNum%>" 
						class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 60px; color: white;">삭제</a>
					<a href="update.jsp?partyNum=<%= partyNum%>&categoryName=<%= categoryName%>" class="btn btn-primary pull-right" 
						style="background-color: rgb(189, 189, 189); border-color: black; width: 60px; color: white; margin-right: 8px;">수정</a>
					<a href="member.jsp?partyNum=<%= partyNum%>" class="btn btn-primary pull-right" 
						style="background-color: rgb(189, 189, 189); border-color: black; width: 75px; color: white; margin-right: 8px;">그룹원</a>
			<%
				} else {
					if(bbs.getNowNum() < bbs.getMaxNum()) {
						if(partyCheck != 1) {
			%>
				<a onclick="return confirm('가입신청 하시겠습니까?')" href="partyJoinCheck.jsp?partyNum=<%= partyNum%>" 
					class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 100px; color: white;">그룹 가입신청</a>
			<%
						}
					} if(partyCheck == 1){
			%>
						<a onclick="return confirm('탈퇴하시겠습니까?')" href="partyOutAction.jsp?partyNum=<%= partyNum%>" 
							class="btn btn-primary pull-right" style="background-color: rgb(189, 189, 189); border-color: black; width: 90px; color: white;">그룹탈퇴</a>
			<%	
					}
				}
			%>
			<div style="border-top-style: solid; border-width:2px; border-color: #A6A6A6; margin-top: 30px;"></div>
			<form method="post" action="commentWriteAction.jsp?partyNum=<%= partyNum%>&cmtParent=<%= cmtParent%>" style="margin-top: 30px;">
				<div class="form-inline">
					<textarea class="form-control" placeholder="500자까지 입력 가능." name="cmtContent" maxlength="500" style="width: 90%; height: 100px;"></textarea>
					<input type="submit" id="submit" class="form-control submit" value="댓글작성" style="width: 9%; height: 100px;">
				</div>
			</form>
		</div>
		<div class="row" style="margin-top: 10px">
			<table class="table" style="border: 1px solid #dddddd">
				<tbody>
				<%
					CommentDAO cmtDAO = new CommentDAO();
					ArrayList<Comment> list = cmtDAO.getList(partyNum);
					for (int i = 0; i < list.size() ; i++) {
					ArrayList<Comment> cmtList = cmtDAO.getCommentList(partyNum, list.get(i).getCmtNum());
				%>
					<tr>
						<td style="width: 20%;"><span style="font-weight: bold;"><%= list.get(i).getUserID()%>
						<%
							if(cmtList.size() != 0) {
						%>
							<span style="color: red; font-size: 10px;">&nbsp(<%= cmtList.size()%>)</span>
						<%
							}
						%>
						</span><br>
						<span style="color: rgba(140, 140, 140, 0.5); font-size: 10px;"><%= list.get(i).getCmtDate() %></span></td>
						<td align="left" style="width: 60%;"><%= list.get(i).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						<td style="vertical-align: middle;">
							<span class="toggle-tr openComment" style="color: blue; margin-left: 3%; cursor: pointer;">답글보기</span>
							<span class="toggle-tr closeComment" style="color: blue; margin-left: 3%; display: none; cursor: pointer;">답글닫기</span>
						<%
							if(userID != null && userID.equals(list.get(i).getUserID())) {
						%>
							<a onclick="return confirm('정말로 삭제하겠습니까?')" href="commentDeleteAction.jsp?cmtNum=<%= list.get(i).getCmtNum()%>&cmtParent=<%= list.get(i).getCmtNum()%>" style="color: blue; margin-left: 3%;">삭제</a>
						<%
							}
						%>
						</td>
					</tr>
					<tr style="display: none;">
						<td colspan="3">
							<table class="table" style="border: 1px solid #dddddd; margin-bottom: 0px;">
								<tbody>
									<tr>
										<td colspan="3">
											<form method="post" action="commentWriteAction.jsp?partyNum=<%= partyNum%>&cmtParent=<%= list.get(i).getCmtNum()%>" style="margin-top: 0px;">
												<div class="form-inline">
													<textarea class="form-control" placeholder="500자까지 입력 가능." name="cmtContent" maxlength="500" style="width: 80%; height: 57px;"></textarea>
													<input type="submit" id="submit" class="form-control submit" value="답변작성" style="width: 9%; height: 57px;">
												</div>
											</form>
										</td>
									</tr>
									<%
										for(int j = 0; j < cmtList.size(); j++) {
									%>
										<tr>
											<td style="width: 20%;"><span style="font-weight: bold;"><%= cmtList.get(j).getUserID()%></span><br>
											<span style="color: rgba(140, 140, 140, 0.5); font-size: 10px;"><%= cmtList.get(j).getCmtDate()%></span></td>
											<td align="left" style="width: 60%;"><%= cmtList.get(j).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
											<td style="vertical-align: middle;">
											<%
												if(userID != null && userID.equals(cmtList.get(j).getUserID())){
											%>
												<a onclick="return confirm('정말로 삭제하겠습니까?')" href="commentDeleteAction.jsp?cmtNum=<%= cmtList.get(j).getCmtNum()%>&cmtParent=-1" style="color: blue;">삭제</a>
											<%
												}
											%>
											</td>
										</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		$(".toggle-tr").on("click", function(){
			var obj = $(this);
			if(obj.hasClass("openComment")){
				obj.hide();
				obj.next().show();
				obj.parent().parent().next().show();
			}else{
				obj.hide();
				obj.prev().show();
				obj.parent().parent().next().hide();
			}
		});
	</script>
</body>
</html>