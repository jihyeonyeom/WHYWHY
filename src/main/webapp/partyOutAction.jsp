<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");		
		script.println("</script>");
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
	BbsDAO bbsDAO = new BbsDAO();
	Bbs bbs = new BbsDAO().getBbs(partyNum);
	int result = -1;
	int result2 = -1;
	if(bbsDAO.partyOut(userID, partyNum) != -1 && bbsDAO.partyOut_two(partyNum, bbs.getNowNum()) != -1){
		result = bbsDAO.partyOut(userID, partyNum);
		result2 = bbsDAO.partyOut_two(partyNum, bbs.getNowNum());
	}
	if (result == -1 || result2 == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('그룹 탈퇴에 실패하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'bbs.jsp?categoryName=party'");
		script.println("</script>");
	}
	%>
</body>
</html>