<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<style>
	body {
		background-color: white;
	}
	#loginImage {
		position: absolute;
		top: 40px;
		right: 40px;
	}
</style>
<link rel="stylesheet" href="resources/css/startPage.css" type="text/css" />
<script type="text/javascript" src="resources/js/jQuery.js"></script>
<script type="text/javascript" src="resources/js/Check.js"></script>
<script type="text/javascript" src="resources/js/go.js"></script>
<script type="text/javascript" src="resources/js/RootripValidChecker.js"></script>
</head>
<body>
	<table id="rootripTable">
		<tr>
			<td align="left"><a id="Rootrip" href="home.go">Rootrip</a></td>
			<td align="right" id="loginTd">
				<div id="loginImage">
					<jsp:include page="${loginPage }"/>
				</div>
			</td>
		</tr>
	</table><hr>
	<table id="indexConTable">
		<tr>
			<td align="center">
			<td><jsp:include page="${contentPage }"/></td>
		</tr>
	</table>
	<table>
		<tr>
			<td><a href="info">회원정보</a></td>
		</tr>
		<tr>
			<td><a href="logout">로그아웃</a></td>
		</tr>
	</table>
</body>
</html>