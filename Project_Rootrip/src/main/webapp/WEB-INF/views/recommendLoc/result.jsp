<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/startPage.css"
    type="text/css" />
<link rel="stylesheet" href="resources/css/questionmenu.css" />
<style>
#resultContainer {
    overflow-x: auto; 
}
#resultTB {
    display: inline-block; /* 테이블을 인라인 블록 요소로 표시 */
    margin-right: 20px; /* 각 테이블 사이의 간격 설정 */
    vertical-align: top; /* 테이블을 상단 정렬 */
    width: 300px; /* 각 테이블의 너비 설정 */
}

#resultTB tr {
        margin-bottom: 60px; 
    }

#resultTB td {
        padding-top: 20px; 
        padding-bottom: 20px;
    }
    

.text-overlay {
        position: absolute;
        overflow: hidden;
        white-space: nowrap;
        padding: 5px;
    }

</style>
</head>
<body>
    <h1 align="center">추천결과</h1>
        <!-- 액티비티를 선택했을 경우 -->
        <c:forEach var="rl" items="${resultList}" varStatus="rvs">
    	<table id="resultTB">
            <tr class="trcut" style="margin-bottom: -30px;">
                <td>*${resultList[rvs.index][0]}하기 좋은 장소*</td>
            </tr>
            <c:forEach var="ln" items="${rl}" begin="1" end="5" varStatus="vs">
            <tr>
                <td class="resultTD">
                    <a href="recommendLoc.map.go?l_no=${resultNumList[rvs.index][vs.index]}&when=${when}&cats=${cats}">
                        <img class="locationimage" src="resources/img/지역사진/${resultPhotoList[rvs.index][vs.index]}">
                        <div class="text-overlay">
                            ${vs.count}위 :${ln}
                        </div>
                    </a>
                </td>
            </tr>
            </c:forEach>
        </table>
        </c:forEach>
            <!-- 5위까지 출력이 끝나면 다음 행으로 내려감 -->
        <!-- 액티비티를 선택하지 않았을 경우 -->
        <table>
        <c:forEach var="rlna" items="${resultListNoActs}" begin="0" end="9" varStatus="navs">
            <tr>
                <td class="resultTD"><a href="recommendLoc.map.go?l_no=${resultNumListNoActs[navs.index]}&when=${when}&cats=${cats}">
                        ${navs.count}위 :${rlna} <img src="resources/img/지역사진/${resultPhotoListNoActs[navs.index]}">
                    </a></td>
            </tr>
        </c:forEach>
    	</table>
</body>
</html>
