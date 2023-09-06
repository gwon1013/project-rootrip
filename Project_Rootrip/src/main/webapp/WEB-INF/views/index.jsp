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
<script type="text/javascript" src="resources/js/logincheck.js"></script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
	  const u_mail = document.getElementById('u_mail');
	  const u_pw = document.getElementById('u_pw');
	  const loginBtn = document.getElementById('loginBtn');

	  loginBtn.addEventListener('click', function (event) {
	    event.preventDefault(); // 폼 제출 방지

	    const email = u_mail.value.trim();
	    const password = u_pw.value.trim();

	    if (!email) {
	      alert('이메일을 입력해주세요.');
	      u_mail.focus();
	      return;
	    }

	    if (!password) {
	      alert('비밀번호를 입력해주세요.');
	      u_pw.focus();
	      return;
	    }

	   
	     document.forms[0].submit();
	  });
	});

if("${errorPage}" != "") {
	alert("${errorPage}");
	
}

</script>
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
</body>
</html>