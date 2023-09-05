<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/startPage.css" type="text/css" />
<link rel="stylesheet" href="resources/css/questionmenu.css" />
<body>
	<h1>추천결과</h1>
	<form>
		<table>
			<c:forEach var="rl" items="${resultList }" varStatus="rvs">
				<tr>
					<td>${resultList[rvs.index][0] }하기 좋은 장소</td>
				</tr>
				<c:forEach var="ln" items="${rl }" begin="1" end="5" varStatus="vs">
					<tr>
						<td><a href="maptest.map.go">${vs.count}위 : ${ln }</a></td>
					</tr>
				</c:forEach>
			</c:forEach>
			<c:forEach var="rlna" items="${resultListNoActs }" begin="0" end="9" varStatus="navs">
				<tr>
					<td><a href="maptest.map.go?loc=${rlna }">${navs.count}위 : ${rlna }</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>