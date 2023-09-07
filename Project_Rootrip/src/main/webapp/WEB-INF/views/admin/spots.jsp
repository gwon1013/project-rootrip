<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$.getJSON("location.main", function(locationMainJSON) {
	var i;
	$.each(locationMainJSON.location, function(i, l_m) {
		var no = l_m.l_no;
		var name = l_m.l_name;

		var loc_main_div = $("<span></span>").append(name).attr('value',
				no).attr('class', 'location');

		$("#location_main_div").append(loc_main_div);
		getSubLoc(no, name);
	})
})

function switchSubLocation(no) {
	var state = $('.sub_location_div[value=' + no + ']').attr('hidden');

	if (state == 'hidden') {
		$('.sub_location_div[value=' + no + ']').removeAttr('hidden');
	} else {
		$('.sub_location_div[value=' + no + ']').attr('hidden', 'hidden');
	}
}
function selectMainLocation(no, name) {
	var value = name;
	var count = $(".selected_location").length;
	if ($('.location[value="' + no + '"]').css('background-color') == 'rgba(0, 0, 0, 0)') {
		var selected = $("<label></label>").attr("class",
				"selected_location").text(name).attr('value', no);
		$("#selected_location_div").append(selected);
		$('.location[value="' + no + '"]').css('background-color',
				'rgba(230, 230, 230, 255)');

		if (count == 0) {
			$("#location_title").attr('hidden', 'hidden');
		}
	} else {
		$('.selected_location[value=' + no + ']').remove();
		$('.location[value="' + no + '"]').css('background-color',
				'rgba(0, 0, 0, 0)');

		if (count == 1) {
			$("#location_title").removeAttr('hidden');
		}
	}
}

function selectSubLocation(no, name) {
	if ($('.sub_location[value="' + no + '"]').css('background-color') == 'rgba(0, 0, 0, 0)') {
		var selected = $("<label></label>").attr("class",
				"selected_location").text(name).attr('value', no);
		$("#selected_location_div").append(selected);
		$('.sub_location[value="' + no + '"]').css('background-color',
				'rgba(230, 230, 230, 255)');
	} else {
		$('.selected_location[value=' + no + ']').remove();
		$('.sub_location[value="' + no + '"]').css('background-color',
				'rgba(0, 0, 0, 0)');
	}
}

function selectAllSub(no, name){
	if ($('.sub_location_div[value=' + no + ']').css('background-color') == 'rgba(0, 0, 0, 0)') {
		var selected = $("<label></label>").attr("class",
		"selected_location").text(name).attr('value', no);
		
		$("#selected_location_div").append(selected);
		
		$('.sub_location_div[value=' + no + '] br').attr('hidden', 'hidden');
		$('.sub_location_div[value=' + no + '] .sub_location').attr('hidden', 'hidden');
		$('.sub_location_div[value=' + no + ']').css('background-color',
				'rgba(230, 230, 230, 255)');
	}
	else {
		$('.selected_location[value=' + no + ']').remove();
		$('.sub_location_div[value=' + no + '] .sub_location').removeAttr('hidden');
		$('.sub_location_div[value=' + no + '] br').removeAttr('hidden');
		$('.sub_location_div[value=' + no + ']').css('background-color',
				'rgba(0, 0, 0, 0)');
		
	}
}
function getSubLoc(l_no, l_name) {
	$.getJSON("location.sub?l_no=" + l_no, function(locationSubJSON) {
		if (locationSubJSON.location[0] == null) {
			$('.location[value=' + l_no + ']').attr(
					'onclick',
					'selectMainLocation(' + l_no + ', "' + l_name + '")');
		} else {
			var i;
			var sub_loc_div = $("<div></div>").attr("hidden", "hidden")
					.attr('class', 'sub_location_div').attr('value', l_no);
			
			$('.location[value=' + l_no + ']').attr('onclick', 'switchSubLocation("' + l_no + '")');
			var sub_loc_title = $("<div></div>").attr('class', 'sub_title').text($('.location[value=' + l_no + ']').text());
			sub_loc_div.append(sub_loc_title);
			$('#location_sub_div').append(sub_loc_div);
			var all_loc_sub = $("<span></span").append("전체").attr('value', l_no).attr('class', 'sub_all_location').attr('onclick', 'selectAllSub("'+l_no+'", "'+l_name+'")');
			sub_loc_div.append(all_loc_sub).append("<br>");
			$.each(locationSubJSON.location, function(i, l_s) {
				var no = l_s.l_no;
				var name = l_s.l_name;
				var loc_sub_div = $("<span></span>").append(name).attr(
						'value', no).attr('class', 'sub_location').attr(
						"onclick",
						'selectSubLocation(' + no + ', "' + name + '")');
				$('.sub_location_div[value=' + l_no + ']').append(
						loc_sub_div);
			})
		}
	})
}
</script>
</head>
<body>
	<h1>장소 관리</h1>
	<div id="selected_location_div" hidden="hidden"></div>
	<div id="location_main_div"></div>
	<div id="location_sub_div"></div>
	<div id="category_main_div"></div>
	<div id="category_sub_dib"></div>
	<div id="spot_div">
		<div><span>장소 번호</span><span>범주</span><span>장소</span><span>장소 이름</span><span>지번 주소</span><span>도로명 주소</span></div>
		<c:forEach items="${spots }" var="spot">
			<div onclick="goEditSpot(${spot.s_no })">
				<span>${spot.s_no }</span><span>${category[spot.c_no]}</span><span>${location[spot.l_no]}</span><span>${spot.s_name }</span><span>${spot.s_addr_jibun }</span><span>${spot.s_addr_road}</span>
			</div>
		</c:forEach>
	</div>
	<div>
		<!-- prev 버튼 -->
		<c:if test="${begin != 1 }">
			<span>prev</span>
		</c:if>
		
		<c:forEach begin="${begin }" end="${end }" var="page">
			<c:if test="${param.query == null }">
					<span  onclick="goManageLocation(${page})">${page }</span>
			</c:if>
			<c:if test="${param.query != null }">
				<span  onclick="goManageLocationWithName('${param.query }', ${page})">${page }</span>
			</c:if>
		</c:forEach>
		
		<!-- next 버튼 -->
		<c:if test="${end != all }">
			<span>next</span>
		</c:if>
	</div>
	<div><input type="text" id="location_name" value=''><button id="search_btn" onclick="searchSpot();">검색</button></div>
</body>
</html>