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
	String getUserID = null;
	if(request.getParameter("getUserID") != null) {
		getUserID = request.getParameter("getUserID");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('추방 대상이 존재하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	BbsDAO bbsDAO = new BbsDAO();
	Bbs bbs = new BbsDAO().getBbs(partyNum);
	int result = -1;
	int result2 = -1;
	if(bbsDAO.partyDeport(getUserID, partyNum) != -1 && bbsDAO.partyDeport_two(partyNum, bbs.getNowNum()) != -1){
		result = bbsDAO.partyOut(getUserID, partyNum);
		result2 = bbsDAO.partyOut_two(partyNum, bbs.getNowNum());
	}
	if (result == -1 || result2 == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('그룹 추방에 실패하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = document.referrer");
		script.println("</script>");
	}
	%>
</body>
</html>