<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>추천결과</h1>
	<table>
		<c:forEach var="ln" items="${resultLocName0}" end="4" varStatus="vs">
			<tr>
				<td><a href="#">${vs.count}위 : ${ln }</a></td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>