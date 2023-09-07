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
<style>
	.location_div_box{
		display: table;
   	 	border-collapse: collapse;
   	 	border: 3px ridge #000;
   	 	width: 100%;
	}
	.location_div_span {
    	display: table-row;
	}

	.location_div_span span {
    	display: table-cell;
    	border: 3px ridge #000;
    	padding: 5px;
    	text-align: center;
    	border-collapse: collapse;
    	width: 60px;	
	}
</style>
</head>
<body>
	<div><h1 onclick="goManageLocation(1)">지역 관리</h1></div>
	<div style="display: flex;"><div>지역 번호</div><div style="margin-left: 120px;">지역 이름</div></div>
	<div id='location_manage_layout' class="location_div_box">
		<c:forEach items="${locations }" var="location">
			<div onclick="goEditLocation(${location.l_no })" class="location_div_span" >
				<span>${location.l_no }</span><span>${location.l_name }</span>
			</div>
		</c:forEach>
	</div><br>
	<div style="display: flex;">
		<c:forEach begin="1" end="${all }" var="page">
			<c:if test="${param.query == null }">
				<div onclick="goManageLocation(${page})" style="padding: 4px;" >${page }</div>
			</c:if>
			<c:if test="${param.query != null }">
				<div onclick="goManageLocationWithName('${param.query }', ${page})" style="display: flex;">${page }</div>
			</c:if>
		</c:forEach>
	</div>
	<div>
		<button onclick="addLocation()">추가</button>
	</div>
	<div><input type="text" id="location_name" value='${param.query }'><button id="search_btn" onclick="searchLocation();">검색</button></div>
</body>
</html>