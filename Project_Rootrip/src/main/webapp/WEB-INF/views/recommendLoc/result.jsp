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
</head>
<body>
	<h1 align="center">추천결과</h1>
	<table id="resultTB">
		<c:forEach var="rl" items="${resultList }" varStatus="rvs">
			<tr>
				<td>*${resultList[rvs.index][0] }하기 좋은 장소*</td>
			</tr>
			<c:forEach var="ln" items="${rl }" begin="1" end="5" varStatus="vs">
				<tr>
					<td>${vs.count}위 :<a href="recommendLoc.map.go?l_no=${resultNumList[rvs.index][vs.index] }">${ln }<img style="width: 300px; max-height: 100px;" src="resources/img/지역사진/${resultPhotoList[rvs.index][vs.index] }"></a></td>
				</tr>
			</c:forEach>
		</c:forEach>
		<c:forEach var="rlna" items="${resultListNoActs }" begin="0" end="9" varStatus="navs">
			<tr>
				<td>${navs.count}위 :<a href="recommendLoc.map.go?l_no=${resultNumListNoActs[navs.index] }">${rlna }<img style="width: 300px; max-height: 100px;" src="resources/img/지역사진/${resultPhotoListNoActs[navs.index] }"></a></td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>