<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin/Location.jsp</title>
<script type="text/javascript" src="resources/js/admin.js"></script>
</head>
<body>
	<div><h1 onclick="goManageLocation(1)">지역 관리</h1></div>
	<div id='location_manage_layout'>
		<div><span>지역 번호</span><span>지역 이름</span></div>
		<c:forEach items="${locations }" var="location">
			<div onclick="goEditLocation(${location.l_no })">
				<span>${location.l_no }</span><span>${location.l_name }</span>
			</div>
		</c:forEach>
	</div>
	<div>
		<c:forEach begin="1" end="${all }" var="page">
			<c:if test="${param.query == null }">
				<span  onclick="goManageLocation(${page})">${page }</span>
			</c:if>
			<c:if test="${param.query != null }">
				<span  onclick="goManageLocationWithName('${param.query }', ${page})">${page }</span>
			</c:if>
		</c:forEach>
	</div>
	<div>
		<button onclick="addLocation()">추가</button>
	</div>
	<div><input type="text" id="location_name" value='${param.query }'><button id="search_btn" onclick="searchLocation();">검색</button></div>
</body>
</html>