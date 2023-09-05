<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin/Location.jsp</title>
<script type="text/javascript">
	$(function(){
		$.getJSON("location.all", function(locationJSON){
			var i;
			$.each(locationJSON.location, function(i, l){
				var location_div = $("<div></div>");
				var location_number = l.l_no;
				var location_name = l.l_name;
				
				var code_span = $("<span></span>").text(location_number);
				var name_span = $("<span></span>").text(location_name);
				location_div.append(code_span).append(name_span).attr('class', 'location_div').attr('onclick', 'goEditLocation("'+location_number+'")');
				$("div#location_manage_layout").append(location_div);
			})
		})
	})
</script>
</head>
<body>
	<div><h1>지역 관리</h1></div>
	<div id='location_manage_layout'>
		<div><span>지역 번호</span><span>지역 이름</span></div>
	</div>
	<div><button>추가</button></div>
	<div><input type="text"><button>검색</button></div>
</body>
</html>