<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
<style>
	#Jointable img{
		width: 70px;
	}
	.JoinBox {
		background-color: white;
        border: 2px solid gray;
        width: 630px;
        margin: 20px auto;
        padding: 20px;	
        text-align: center;
        border-radius: 5px;
        height: 500px;
	}
</style>
</head>
<body>
	<h2>회원가입</h2>
	<form action="member.join" method="post" enctype="multipart/form-data" name="joinForm" onsubmit="return checkJoin();">
		<table id="Jointable" class="JoinBox">
			<tr>
				<td>E-mail</td>
				<td align="center"><input id="join_id" name="u_id" placeholder="아이디" autofocus="autofocus" autocomplete="off">@
					<input type="text" id="join_domain_input" name="u_domain_manual" readonly="readonly" autocomplete="off">
					<select id="join_domain" name="u_domain" onchange="selectDomain();">
						<option>gmail.com</option>
						<option>naver.com</option>
						<option>kakao.com</option>
						<option>nate.com</option> 
						<option>hanmail.net</option>
						<option>직접입력</option>
					</select>
				</td>
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