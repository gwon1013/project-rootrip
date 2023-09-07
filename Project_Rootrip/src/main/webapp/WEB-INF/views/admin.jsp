<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/js/admin.js"></script>
<meta charset="UTF-8">
<title>Admin.jsp</title>
<style>
	.admin_btn{
		margin-top: 50px;
		border: 2px solid;
		padding: 50px;
		width: 100%;
		background: none;
		border-radius: 30px;
		font-size: 25px;
	}
	.admin_btn:hover {
		background-color: #D4F4FA;
		transition: 0.7s;	
	}

</style>
</head>
<body>
	<button onclick="goManageUsers(1)" class="admin_btn" id="btn1">회원 관리</button>
	<button onclick="goManageLocation(1)" class="admin_btn" id="btn2">지역 관리</button>
	<button onclick="goManageSpots(1)" class="admin_btn" id="btn3">장소 관리</button>
	
</body>
</html>