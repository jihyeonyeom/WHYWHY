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
<body style="background-color: rgba(224,224,224,0.2);">
	<div class="container" style="padding-top: 50px">
		<div class="col-xs-12 col-md-4"></div>
		<div class="col-xs-12 col-md-4">
			<div class="wrapper">
				<form method="post" action="joinAction.jsp">
					<div><a href="main.jsp" style="text-decoration: none; "><h1>와이와이</h1></a></div>
					<div class="form-group" style="padding-top: 20px">
						<label for="userID">아이디</label>
						<input type="text" class="form-control" placeholder="내용을 입력해주세요." name="userID" maxlength="15">
					</div>
					<div class="form-group">
						<label for="userPassword">비밀번호</label>
						<input type="password" id = "userPassword" class="form-control" placeholder="내용을 입력해주세요." name="userPassword" maxlength="15">
					</div>
					<div class="form-group">
						<div style="float: left;"><label for="checkPassword">비밀번호 재확인</label></div>
						<div style="float: right"><label><span id="check"></span></label></div>
						<input type="password" id = "checkPassword" class="form-control" placeholder="내용을 입력해주세요." name="checkPassword" maxlength="20" onkeyup="check()">
					</div>
					<div class="form-group">
						<label for="userName">이름</label>
						<input type="text" class="form-control" placeholder="내용을 입력해주세요." name="userName" maxlength="15">
					</div>
					<div class="form-group">
						<label for="userBirth">생년월일</label>
						<div class="form-inline">
							<input type="text" class="form-control birthyy" placeholder="년(4자)" name="userBirthyy" maxlength="4">
							<select class="form-control birthmm" name="userBirthmm">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							</select>
							<input type="text" class="form-control birthdd" placeholder="일" name="userBirthdd" maxlength="2">
						</div>
					</div>
					<div class="form-group">
						<label for="userPhone">전화번호</label>
						<input type="tel" class="form-control" placeholder="내용을 입력해주세요." name="userPhone" maxlength="12">
					</div>
					<div style="padding-top: 10px">
						<input type="submit" id="submit" class="form-control submit" style="background-color: rgb(189, 189, 189); color:black;" value="회 원 가 입">
					</div>
				</form>
			</div>
		</div>
		<div class="col-xs-12 col-md-4"></div>
	</div>
	<script type="text/javascript">
		function check(){
			var pwd1 = userPassword.value;
			var pwd2 = checkPassword.value;
			if(pwd1!=pwd2){
				document.getElementById('check').style.color = "red";
				document.getElementById('check').innerHTML = "동일한 암호를 입력하세요.";
			} else {
				document.getElementById('check').style.color = "blue";
				document.getElementById('check').innerHTML = "암호가 일치합니다.";
			}
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>