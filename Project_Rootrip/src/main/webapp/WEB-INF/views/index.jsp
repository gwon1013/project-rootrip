<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<style>
	body {
            margin: 0;
            padding: 0;
            height: 100%;
            background: -moz-linear-gradient(top, #83C5E7 0%, #F7FBFD 100%);
   			background: -webkit-linear-gradient(top, #83C5E7 0%, #F7FBFD 100%);
    		background: linear-gradient(to bottom, #83C5E7 0%, #F7FBFD 100%);
    		background-attachment: fixed;
        }
       
    .content {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
	#loginImage {
		position: absolute;
		top: 23px;
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
<div class="content">
	<table id="rootripTable">
		<tr>
			<td align="left"><a id="Rootrip" href="home.go">Rootrip</a></td>
			<td align="right" id="loginTd">
				<div id="loginImage">
					<jsp:include page="${loginPage }"/>
				</div>
			</td>
		</tr>
	</table>
	<hr>
	<table id="indexConTable">
		<tr>
			<td align="center">
			<td><jsp:include page="${contentPage }"/></td>
		</tr>
	</table>
</div>
</body>
</html>