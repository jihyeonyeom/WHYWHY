<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/join.css">
<title>WHYWHY</title>
</head>
<body style="background-color: rgba(224,224,224,0.2)">
	<div class="container" style="padding-top: 50px">
		<div class="col-xs-12 col-md-4"></div>
		<div class="col-xs-12 col-md-4">
			<div class="wrapper-login">
				<form method="post" action="loginAction.jsp">
					<div><a href="main.jsp" style="text-decoration: none; "><h1>와이와이</h1></a></div>
					<div class="form-group" style="padding-top: 30px">
						<input type="text" class="form-control" style="height: 47px" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group" style="padding-top: 10px">
						<input type="password" class="form-control" style="height: 47px" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div style="padding-top: 10px">
						<input type="submit" class="form-control submit" style="background-color: rgb(189, 189, 189); border: none; font-weight: bold; height: 40px; color:black;" value="로 그 인">
					</div>
					<div style="padding-top: 10px"><h4>와이와이 계정이 없으신가요? &nbsp&nbsp<a href="join.jsp">가입하기</a></h4></div>
				</form>
			</div>
		</div>
		<div class="col-xs-12 col-md-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>