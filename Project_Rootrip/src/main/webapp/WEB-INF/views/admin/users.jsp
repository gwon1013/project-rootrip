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
<style>
	.excel-like-table {
   	 	display: table;
   	 	border-collapse: collapse;
   	 	border: 3px ridge #000;
   	 	width: 100%;
	}

	.excel-row {
    	display: table-row;
	}

	.excel-row span {
    	display: table-cell;
    	border: 3px ridge #000;
    	padding: 5px;
    	text-align: center;
    	border-collapse: collapse;
	}

 
</style>
</head>
<body>
	<div><h1 onclick="goManageUsers(1)">회원 관리</h1></div>
	<div style="display: flex;">
			<div>이메일</div><div style="margin-left: 220px;">별명</div><div style="margin-left: 50px;">유형</div>
	</div>
	<div id='location_manage_layout' class="excel-like-table">
		<c:forEach items="${users }" var="user">
			<div class="excel-row">
				<span style="width: 250px;">${user.u_mail }</span><span>${user.u_nickname }</span>
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
	<br>
	<div style="display: flex;">
		<c:forEach begin="1" end="${all }" var="page">
			<c:if test="${param.mail != null}">
				<div  onclick="goManageUsersWithMail('${param.mail}', ${page})">${page }</div>
			</c:if>
			<c:if test="${param.nickname != null}">
				<div  onclick="goManageUsersWithNickname('${param.nickname}', ${page})">${page}</div>
			</c:if>
			<c:if test="${param.nickname == null && param.mail == null}">
				<div  onclick="goManageUsers(${page})" style="padding: 4px">${page}</div>
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