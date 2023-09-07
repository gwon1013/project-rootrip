<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/login</title>
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