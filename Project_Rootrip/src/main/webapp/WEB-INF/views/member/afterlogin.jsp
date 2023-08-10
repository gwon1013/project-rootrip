<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>afterlogin.jsp</title>
</head>
<body>
	<table>
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
	<td><a href="info">회원정보</a></td>
	</tr>
	</table>
</body>
</html>