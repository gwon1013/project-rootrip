<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
</head>
<body>
	<h2>회원가입</h2>
	<form action="member.join" method="post" enctype="multipart/form-data" name="joinForm" onsubmit="return checkJoin();">
		<table>
		<tr>
				<td>E-mail</td>
				<td align="center"><input id="join_id" name="u_mail" placeholder="아이디" autofocus="autofocus" ></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td align="center"><input name="u_pw" placeholder="비밀번호" type="password"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td align="center"><input name="u_pw_chk" placeholder="비밀번호확인" type="password"></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td align="center"><input name="u_nickname" placeholder="닉네임"></td>
			</tr>
			<tr>
				<td>프로필 사진</td>
			</tr>
			<tr>
				<td><img id="j_image" class="profile_preview" src="resources/img/profile.png"></td>
				<td><input id="input_profile" type="file" accept="image/*" name="u_profile" onchange="changeImage(this.files, ${sessionScope.loginMember});"></td>
			</tr>
			<tr>
				<td colspan="2"><button>회원가입</button></td>
			</tr>
		</table>
	</form>
</body>


</html>