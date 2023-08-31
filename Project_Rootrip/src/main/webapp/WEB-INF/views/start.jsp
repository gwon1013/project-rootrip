<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>start.jsp</title>
<link rel="stylesheet" href="resources/css/startPage.css" type="text/css" />
<style>
	.di {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
        }

        .di strong {
            margin-right: 20px; /* 텍스트와 이미지 사이의 간격 조절 */
        }
</style>
</head>
<body>	
	<div class="slideshow-container">
		<div class="di">
			<strong>텍스트 한 줄 넣아야 하는데</strong>
		</div>
	        <div class="slide">
	            <img src="resources/img/한강(1).jpg" alt="Image 1">
	        </div>
	        <div class="slide">
	            <img src="resources/img/민속촌(1).jpg" alt="Image 2">
	        </div>
	        <div class="slide">
	            <img src="resources/img/바다(1).jpg" alt="Image 3">
	        </div>
	        <div class="slide">
	            <img src="resources/img/전통시장(1).jpg" alt="Image 4">
	        </div>
	        <div class="slide">
	            <img src="resources/img/ATV(1) (1).jpg" alt="Image 5">
	        </div>    	    
    </div>
    <script src="resources/js/css.js"></script>

	<div class="button-container">
		<button onclick="goQuestion();" class="startBtn">시작하기</button>
		<a href="#">내가 알아서 할게 ~ </a>
	</div>
	
</body>
</html>