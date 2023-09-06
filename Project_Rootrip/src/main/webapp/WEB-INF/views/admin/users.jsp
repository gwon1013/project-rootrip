<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin/Users.jsp</title>
<script type="text/javascript" src="resources/js/admin.js"></script>
</head>
<body>
	<div><h1 onclick="goManageUsers(1)">회원 관리</h1></div>
	<div id='location_manage_layout'>
		<div><span>이메일</span><span>별명</span><span>유형</span></div>
		<c:forEach items="${users }" var="user">
			<div>
				<span>${user.u_mail }</span><span>${user.u_nickname }</span>
				<span>
					<c:choose>
						<c:when test="${user.u_type == '0'}">일반 회원</c:when>
						<c:when test="${user.u_type == '1'}">관리자</c:when>
						<c:when test="${user.u_type == '2'}">업체 회원</c:when>
					</c:choose>
				</span>
				<c:if test="${user.u_type != '1'}">
					<span><button onclick="kickUser('${user.u_mail}')">강퇴</button></span>
				</c:if>
			</div>
		</c:forEach>
	</div>
	<div>
		<c:forEach begin="1" end="${all }" var="page">
			<c:if test="${param.mail != null}">
				<span  onclick="goManageUsersWithMail('${param.mail}', ${page})">${page }</span>
			</c:if>
			<c:if test="${param.nickname != null}">
				<span  onclick="goManageUsersWithNickname('${param.nickname}', ${page})">${page}</span>
			</c:if>
			<c:if test="${param.nickname == null && param.mail == null}">
				<span  onclick="goManageUsers(${page})">${page}</span>
			</c:if>
		</c:forEach>
	</div>
	<div>
		<select id="user_category">
			<option>이메일</option>
			<option>닉네임</option>
		</select>
		<c:if test="${param.mail != null }">
			<input type="text" id="user_input" value='${param.mail }'>
		</c:if>
		<c:if test="${param.nickname != null }">
			<input type="text" id="user_input" value='${param.nickname }'>
		</c:if>
		<c:if test="${param.nickname == null && param.mail == null}">
			<input type="text" id="user_input">
		</c:if>
		<button id="search_btn" onclick="searchUser();">검색</button>
	</div>
</body>
</html>