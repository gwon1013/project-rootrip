<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>afterlogin.jsp</title>
<style>
	.profile {
		width: 70px;
		display: inline-block;
		border-radius: 70%;
		margin-left: 100px;
		width: 56px;
    	height: 46px;
		
	}
	.options {         
            display: inline-block;
            vertical-align: middle;
            cursor: pointer; 
            margin-left: 20px;
			margin-top: 10px;
        }
     .links {
            display: none; 
            position: absolute;
            left: 130px;
            top: 80px;
            background-color: none; 
            padding: 4px;    
                
        }      
</style>
</head>
<body>
	<table style="float: left;">
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
	</tr>
	</table>
	<div class="options" id="optionsIcon">
		<img src="resources/img/옵션.png" style="width: 25px;">
	</div>
	<div style="float: left;" class="links" id="linksDiv">
		<a href="info">회원정보</a><p>
		<a href="logout">로그아웃</a>
	</div>
	 <script>
        var linksDiv = document.getElementById("linksDiv");
        var optionsIcon = document.getElementById("optionsIcon");
        var isOpen = false;

        optionsIcon.addEventListener("click", function() {
            if (isOpen) {
                linksDiv.style.display = "none"; 
            } else {
                linksDiv.style.display = "block";
            }
            isOpen = !isOpen;
        });
    </script>
</body>
</html>