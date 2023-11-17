<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userBirthyy" />
<jsp:setProperty name="user" property="userBirthmm" />
<jsp:setProperty name="user" property="userBirthdd" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userPassword" />
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
		script.println("alert('로그인이 안되어 있습니다.')");
		script.println("location.href = 'main.jsp'");		
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.profileChange(user, user.getUserID(), user.getUserPassword());
	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserBirthyy() == null 
			|| user.getUserBirthmm() == null || user.getUserBirthdd() == null
			|| user.getUserName() == null || user.getUserPhone() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		if (result >= 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정이 완료되었습니다.')");
			script.println("location.href = 'profile.jsp'");
			script.println("</script>");
		} else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	%>
</body>
</html>