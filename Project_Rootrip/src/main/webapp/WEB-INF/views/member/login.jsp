<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/login</title>
</head>
<body>
	<form action="login" method="post">
		<table>
			<tr>
				<td>ID</td>
				<td><input id="u_mail" name="u_mail" placeholder="이메일"></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input id="u_pw" name="u_pw" placeholder="비밀번호" type="password"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><button id="loginBtn">login</button></td>
			</tr>
		</table>
	</form>
	
</body>
</html>