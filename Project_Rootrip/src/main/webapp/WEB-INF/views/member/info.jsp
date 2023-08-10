<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info.jsp</title>
</head>
<body>
	<h2>내 정보</h2>
	<form action="member.update" method="post" enctype="multipart/form-data" name="joinForm" onsubmit="return checkJoin();">
		<table>
		<tr>
				<td>E-mail</td>
				<td align="center"><input id="join_id" name="u_mail" placeholder="아이디" autofocus="autofocus" readonly="readonly" value="${sessionScope.loginMember.u_mail }"></td>
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
				<td align="center"><input name="u_nickname" placeholder="닉네임" value=${sessionScope.loginMember.u_nickname }></td>
			</tr>
			<tr>
			</tr>
			<tr>
				<td>프로필 사진</td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${sessionScope.loginMember.u_profile != null }">
							<img class="profile" src="resources/img/${sessionScope.loginMember.u_profile}">
						</c:when>
						<c:when test="${sessionScope.loginMember.u_profile == null }">
							<img class="profile" src="resources/img/profile.png">
						</c:when>
					</c:choose>
				</td>
				<td><input id="i_profile" type="file" name="u_profile"></td>
			</tr>
			<tr>
				<td><button>정보 수정</button><input type="button" value="탈퇴하기" onclick="goDrop();"></td>
			</tr>
		</table>
	</form>
</body>
</html>