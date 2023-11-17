<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="cmtContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WHYWHY</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int partyNum = 0;
	if(request.getParameter("partyNum") != null) {
		partyNum = Integer.parseInt(request.getParameter("partyNum"));
	}
	int cmtNum = 0;
	if(request.getParameter("cmtNum") != null) {
		cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
	}
	int cmtParent = 0;
	if(request.getParameter("cmtParent") != null) {
		cmtParent = Integer.parseInt(request.getParameter("cmtParent"));
	}
	if(partyNum == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 파티입니다.')");
		script.println("location.href = 'main.jsp'");		
		script.println("</script>");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");		
		script.println("</script>");
	} else {
		if (comment.getCmtContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용을 입력하세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			CommentDAO cmtDAO = new CommentDAO();
			int result = cmtDAO.write(comment.getCmtContent(), userID, cmtParent, partyNum);
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = document.referrer");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>