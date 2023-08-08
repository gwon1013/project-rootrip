<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<script type="text/javascript" src="resources/js/jQuery.js"></script>
<script type="text/javascript" src="resources/js/Check.js"></script>
<script type="text/javascript" src="resources/js/RootripValidChecker.js"></script>
</head>
<body>
	<table>
		<tr>
			<td align="left"><a href="home.go">Rootrip</a></td>
			<td align="right"><jsp:include page="${loginPage }"/></td>
		</tr>
	</table>
	<table>
		<tr>
			<td align="center">
			<td><jsp:include page="${contentPage }"/></td>
		</tr>

	</table>

	<table>
		<tr>
			<td><a href="#">회원정보</a></td>
		</tr>
		<tr>
			<td><a href="#">로그아웃</a></td>
		</tr>
	</table>
</body>
</html>