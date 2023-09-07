<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지도</title>
<script type="text/javascript" src="resources/js/jQuery.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=180742ce7317f945a90b9a754523bdf5"></script>
<script type="text/javascript">
/* 
 * 날짜 변경에 따른 확인창
 * 장날과 축제 기간에 따른 결과 차이
 * 코스 저장 버튼
 */
	let searchParams = new URLSearchParams(window.location.search);
	
	var positions = [];
	var markers = [];
	var contents = [];
	var overlays = [];
	
	const categoryMap = new Map();
	$.ajaxSetup({
		async : false
	});
	$(function() {
		$(".category").on(
				'click',
				function() {
					var value = $(this).text();
					var count = $(".selected_category").length;
					if ($(this).css('background-color') == 'rgba(0, 0, 0, 0)') {
						var selected = $("<label></label>").attr("class",
								"selected_category").text(value).attr('value',
								value);
						$("#category_title_div").append(selected);
						$(this).css('background-color',
								'rgba(230, 230, 230, 255)');

						if (count == 0) {
							$("#category_title").attr('hidden', 'hidden');
						}
					} else {
						$('.selected_category[value=' + value + ']').remove();
						$(this).css('background-color', 'rgba(0, 0, 0, 0)');

						if (count == 1) {
							$("#category_title").removeAttr('hidden');
						}
					}
				})
		$.getJSON("categories", function(categoryJSON) {
			$.each(categoryJSON.category, function(i, c) {
				categoryMap.set(c.c_no, c.c_name);
			})
		})
		$.getJSON("location.main", function(locationMainJSON) {
			var i;
			$.each(locationMainJSON.location, function(i, l_m) {
				var no = l_m.l_no;
				var name = l_m.l_name;
				var lat = l_m.l_lat;
				var lon = l_m.l_lon;

				var loc_main_div = $("<div></div>").append(name).attr('value',
						no).attr('class', 'location');

				$("#location_main_div").append(loc_main_div);
				if (i % 4 == 3) {
					$("#location_main_div").append($("<p>"));
				}
				getSubLoc(no, name, lat, lon);
			})
		})
		$('#search_input').on('change keyup paste input', function(){
			searchSpot();
		});
		
		$(document).on('click', ".spot button", function(no){
			var no = $(this).parent().attr('value');
			addCourse(no);
		})
		
		$(document).on('click', '.course .remove', function(){
			var course = $(this).parent();
			var index = course.children('.idx').text();
			var num = course.children('.course_num').text();
			
			course_markers[num][index].setMap(null);
			course_markers[num].splice(index, 1);	//삭제할 인덱스, 삭제할 개수
			line_paths[num].splice(index, 1);
			
			drawCourseMarkers(courseNum);
			
			course.remove();
			$('.course_div[value="'+ num +'"] .course').each(function(i, c){
				$(this).children('.idx').text(i);
			})
		})
	})
	
	function addCourse(no){
		if(period != 1 && courseNum == 0) {
			alert("먼저 여행 날짜를 선택해주세요");
		}
		else {
			var spot = $('.spot[value='+no+']');
			var index = $('.course_div[value="'+ courseNum +'"] .course').length;
			var category = spot.children('.s_category').text();
			var photo = spot.children('.s_photo img').attr('src');
			var name = spot.children('.s_name').text();
			var lat = spot.children('.s_lat').text();
			var lon = spot.children('.s_lon').text();
			var tel = spot.children('.s_tel').text();
			var addr = spot.children('.s_addr').text();
			var comment = spot.children('s_comment').text();
			
			var course_div = $('.course_div[value="'+ courseNum +'"]');
			var course_detail = $('<div></div>');
			var category_span = $('<span></span>').attr('class', 'category').text(category);
			var name_span = $('<span></span>').attr('class', 'name').text(name);
			var course_name = $('<div></div>').attr('onclick', "moveToSpot(" + lat + ", " + lon + ")").append(category_span).append(name_span);
			var remove_btn = $('<button></button>').attr('class', 'remove').text('제거');
			var course_num_span = $('<span></span>').attr('class', 'course_num').attr('hidden', 'hidden').text(courseNum);
			var index_span = $('<span></span>').attr('class', 'idx').attr('hidden', 'hidden').text(index);
			
			course_detail.append(course_name).append(course_num_span).append(index_span).append(remove_btn).attr('value', spot.attr('value')).attr('class', 'course');
			course_div.append(course_detail);
			
			var content = '<div style="padding:5px; background-color:white;"><div onclick="closeCourseOverlay('+courseNum+', '+index+')">닫기</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			
			if(photo != null) {
				content += '<div><img src=resources/img'+ photo +'></div>';
			}
			content += '<div>'+ name +'</div><div>'+ addr +'</div>'
			if(tel != null) {
				content += '<div>'+ tel +'</div>';
			}
			if(comment != null){
				content += '<div>'+comment+'</div>';
			}
			
			var imageSrc = "resources/img/카테고리/"+category+".png";
			
			var imageSize = new kakao.maps.Size(24, 35);
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
			var marker = new kakao.maps.Marker({
				position : new kakao.maps.LatLng(lat, lon),
				title : name, 
				image : markerImage
			})
			course_markers[courseNum].push(marker);
			
			var overlay = new kakao.maps.CustomOverlay({
			    content : content,
			    position: marker.getPosition()
			});
			
			kakao.maps.event.addListener(marker, 'click', printOverlay(map, overlay));
			
			line_paths[courseNum].push(new kakao.maps.LatLng(lat, lon));
			course_overlays[courseNum].push(overlay);
			
			marker.setMap(map);
			
			if(polyline != null) {
				polyline.setMap(null);
			}
			polyline = new kakao.maps.Polyline({
			    path: line_paths[courseNum],
			    strokeWeight: 5,
			    strokeColor: '#FFAE00',
			    strokeOpacity: 0.7, 
			    strokeStyle: 'solid'
			});
			polyline.setMap(map);
		}
	}

	function switchLocationCheck() {
		var state = $("#location_main_div").attr('hidden');

		if (state == 'hidden') {
			$("#location_main_div").removeAttr('hidden');
		} else {
			$("#location_main_div").attr('hidden', 'hidden');
		}
	}

	function switchSubLocation(no) {
		var state = $('.sub_location_div[value=' + no + ']').attr('hidden');

		if (state == 'hidden') {
			$('.sub_location_div[value=' + no + ']').removeAttr('hidden');
		} else {
			$('.sub_location_div[value=' + no + ']').attr('hidden', 'hidden');
		}
	}

	function getSubLoc(l_no, l_name, lat, lon) {
		$.getJSON("location.sub?l_no=" + l_no, function(locationSubJSON) {
			if (locationSubJSON.location[0] == null) {
				$('.location[value=' + l_no + ']').attr(
						'onclick',
						'selectMainLocation(' + l_no + ', "' + l_name + '", '
								+ lat + ', ' + lon + ')');
			} else {
				var i;
				var sub_loc_div = $("<div></div>").attr("hidden", "hidden")
						.attr('class', 'sub_location_div').attr('value', l_no);
				$('.location[value=' + l_no + ']').after(sub_loc_div).attr(
						'onclick', 'switchSubLocation("' + l_no + '")');
				var all_loc_sub = $("<span></span").append("전체").attr('value', l_no).attr('class', 'sub_all_location').attr('onclick', 'selectAllSub("'+l_no+'", "'+l_name+'", "'+lat+'", "'+ lon +'")');
				sub_loc_div.append(all_loc_sub).append("<br>");
				$.each(locationSubJSON.location, function(i, l_s) {
					var no = l_s.l_no;
					var name = l_s.l_name;
					var lat = l_s.l_lat;
					var lon = l_s.l_lon;
					var loc_sub_div = $("<span></span>").append(name).attr(
							'value', no).attr('class', 'sub_location').attr(
							"onclick",
							'selectSubLocation(' + no + ', "' + name + '", '
									+ lat + ', ' + lon + ')');
					$('.sub_location_div[value=' + l_no + ']').append(
							loc_sub_div);
					if (i % 4 == 3) {
						$('.sub_location_div[value=' + l_no + ']').append(
								$("<br>"));
					}
				})
			}
		})
	}

	function selectMainLocation(no, name, lat, lon) {
		moveToMainLocation(lat, lon)

		var value = name;
		var count = $(".selected_location").length;
		if ($('.location[value="' + no + '"]').css('background-color') == 'rgba(0, 0, 0, 0)') {
			var selected = $("<label></label>").attr("class",
					"selected_location").text(name).attr('value', no);
			$("#location_title_div").append(selected);
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

	function selectSubLocation(no, name, lat, lon) {
		moveToSubLocation(lat, lon)

		var count = $(".selected_location").length;
		if ($('.sub_location[value="' + no + '"]').css('background-color') == 'rgba(0, 0, 0, 0)') {
			var selected = $("<label></label>").attr("class",
					"selected_location").text(name).attr('value', no);
			$("#location_title_div").append(selected);
			$('.sub_location[value="' + no + '"]').css('background-color',
					'rgba(230, 230, 230, 255)');

			if (count == 0) {
				$("#location_title").attr('hidden', 'hidden');
			}
		} else {
			$('.selected_location[value=' + no + ']').remove();
			$('.sub_location[value="' + no + '"]').css('background-color',
					'rgba(0, 0, 0, 0)');

			if (count == 1) {
				$("#location_title").removeAttr('hidden');
			}
		}
	}
	
	function selectAllSub(no, name, lat, lon){
		moveToMainLocation(lat, lon);
		
		var count = $(".selected_location").length;
		if ($('.sub_location_div[value=' + no + ']').css('background-color') == 'rgba(0, 0, 0, 0)') {
			var selected = $("<label></label>").attr("class",
			"selected_location").text(name).attr('value', no);
			
			$("#location_title_div").append(selected);
			
			$('.sub_location_div[value=' + no + '] br').attr('hidden', 'hidden');
			$('.sub_location_div[value=' + no + '] .sub_location').attr('hidden', 'hidden');
			$('.sub_location_div[value=' + no + ']').css('background-color',
					'rgba(230, 230, 230, 255)');
			if (count == 0) {
				$("#location_title").attr('hidden', 'hidden');
			}
		}
		else {
			$('.selected_location[value=' + no + ']').remove();
			$('.sub_location_div[value=' + no + '] .sub_location').removeAttr('hidden');
			$('.sub_location_div[value=' + no + '] br').removeAttr('hidden');
			$('.sub_location_div[value=' + no + ']').css('background-color',
					'rgba(0, 0, 0, 0)');
			
			if (count == 1){
				$("#location_title").removeAttr('hidden');
			}
		}
	}

	function switchCategoryCheck() {
		var state = $("#category_select_div").attr('hidden');

		if (state == 'hidden') {
			$("#category_select_div").removeAttr('hidden');
		} else {
			$("#category_select_div").attr('hidden', 'hidden');
		}
	}

	function moveToMainLocation(lat, lon) {
		var moveLatLon = new kakao.maps.LatLng(lat, lon);
		map.setCenter(moveLatLon);
		map.setLevel(11);
	}

	function moveToSubLocation(lat, lon) {
		var moveLatLon = new kakao.maps.LatLng(lat, lon);
		map.setCenter(moveLatLon);
		map.setLevel(9);
	}

	function moveToSpot(lat, lon) {
		var moveLatLon = new kakao.maps.LatLng(lat, lon);
		map.setCenter(moveLatLon);
		map.setLevel(5);
	}
	
	
	function setSpot(i, s) {
		var no = s.s_no;
		var name = s.s_name;
		var addr;
		if (s.s_addr_road == null) {
			addr = s.s_addr_jibun;
		} else {
			addr = s.s_addr_road;
		}
		var tel = s.s_tel;
		var category = categoryMap.get(s.c_no);
		var photo = s.s_photo;
		var comment = s.s_comment;

		position = {
			title : name,
			category : category,
			address : addr,
			latlng : new kakao.maps.LatLng(s.s_lat, s.s_lon)
		}
		positions.push(position);
		
		var content = '<div style="padding:5px; background-color:white;"><div onclick="closeOverlay('+i+')">닫기</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		
		if(photo != null) {
			content += '<div><img src="resources/img/'+ photo +'"></div>';
		}
		content += '<div>'+ name +'</div><div>'+ addr +'</div>'
		if(tel != null) {
			content += '<div>'+ tel +'</div>';
		}
		if(comment != null){
			content += '<div>'+comment+'</div>';
		}
		content += '<div><button onclick="addCourse('+no+')">추가</button></div></div>';
		
		contents.push(content);
		
		var spot_div = $("<div></div>")
		var category_div = $("<div></div>").attr('class', 's_category').text(category);
		if(photo != null) {
			var photo_div = $("<div></div>").html('<img src="resources/img/'+ photo +'">').attr('class', 's_photo');
			spot_div.append(photo_div);
		}
		var name_div = $("<div></div>").attr('class', 's_name').text(name);
		var addr_div = $("<div></div>").attr('class', 's_addr').text(addr);
		
		spot_div.append(category_div).append(name_div).append(addr_div);
		
		if(tel != null){
			var tel_div = $("<div></div>").attr('class', 's_tel').text(tel);
			spot_div.append(tel_div);
		}
		var lat_div = $("<div></div>").attr('class', 's_lat').attr('hidden', 'hidden').text(s.s_lat);
		var lon_div = $("<div></div>").attr('class', 's_lon').attr('hidden', 'hidden').text(s.s_lon);
		var comment_div = $("<div></div>").attr('class', 's_comment').attr('hidden', 'hidden').text(s.s_comment);
		var add_btn = $("<button></button>").attr('class', 'add_btn').text('추가');
		if(period != 1 && courseNum == 0) {
			add_btn.attr('hidden', 'hidden');
		}
		spot_div.attr("onclick",
				"moveToSpot(" + s.s_lat + ", " + s.s_lon + ")").attr("class", "spot").attr('value', no).append(lat_div).append(lon_div)
				.append(add_btn);
		$("#spot_area").append(spot_div);
	}

	function searchSpot() {
		$("#category_select_div").attr('hidden', 'hidden');
		$("#location_main_div").attr('hidden', 'hidden');
		var cate_count = $(".selected_category").length;
		var loc_count = $(".selected_location").length;
		$("#spot_area").empty();

		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
			overlays[i].setMap(null);
		}

		markers.length = 0;
		positions.length = 0;
		contents.length = 0;
		overlays.length = 0;
		
		var categories = [];
		$(".selected_category").each(function() {
			categories.push($(this).attr('value'));
		})

		var locations = []
		$(".selected_location").each(function() {
			locations.push($(this).attr('value'));
		})
		
		var search = $("#search_input").val();
		if(search == "") {
			if (cate_count != 0 && loc_count != 0) {
				$.getJSON("getSpots.cateloca?categories=" + categories
						+ "&locations=" + locations, function(spotJSON) {
					var i = 0;
					$.each(spotJSON.spot, function(i, s){
						setSpot(i, s);
					});
				});
			} else if (cate_count != 0) {
				$.getJSON("getSpots.category?categories=" + categories, function(
						spotJSON) {
					var i = 0;
					$.each(spotJSON.spot,  function(i, s){
						setSpot(i, s);
					});
				});
			} else if(loc_count != 0){
				$.getJSON("getSpots.location?locations=" + locations, function(
						spotJSON) {
					var i = 0;
					$.each(spotJSON.spot,  function(i, s){
						setSpot(i, s);
					});
				});
			}
		}
		else {
			var count = cate_count + loc_count;
			if(count == 0) {
				$.getJSON("getSpots.name?name=" + search, function(spotJSON) {
					var i = 0;
					$.each(spotJSON.spot,  function(i, s){
						setSpot(i, s);
					});
				});
			}
			else {
				if (cate_count != 0 && loc_count != 0) {
					$.getJSON("getSpots.catelocaname?categories=" + categories
							+ "&locations=" + locations + "&name=" + search, function(spotJSON) {
						var i = 0;
						$.each(spotJSON.spot,  function(i, s){
							setSpot(i, s);
						});
					});
				} else if (cate_count != 0) {
					$.getJSON("getSpots.catename?categories=" + categories + "&name=" + search, function(
							spotJSON) {
						var i = 0;
						$.each(spotJSON.spot,  function(i, s){
							setSpot(i, s);
						});
					});
				} else if(loc_count != 0){
					$.getJSON("getSpots.locaname?locations=" + locations + "&name=" + search, function(
							spotJSON) {
						var i = 0;
						$.each(spotJSON.spot,  function(i, s){
							setSpot(i, s);
						});
					});
				}
			}
		}
		

		for (var i = 0; i < positions.length; i++) {
			var imageSize = new kakao.maps.Size(24, 35);
			var imageSrc = "resources/img/카테고리/"+positions[i].category+".png";
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
			var marker = new kakao.maps.Marker({
				position : positions[i].latlng, // 마커를 표시할 위치
				title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				image : markerImage,
				clickable: true
			});
			
			var overlay = new kakao.maps.CustomOverlay({
			    content : contents[i],
			    position: marker.getPosition()
			});
			
			kakao.maps.event.addListener(marker, 'click', printOverlay(map, overlay));
			
			marker.setMap(map);
			markers.push(marker);
			overlays.push(overlay)
		}
	}
	
	function printOverlay(map, overlay) {
		 return function() {
		        overlay.setMap(map);
		 };
	}
	
	function closeOverlay(i) {
		overlays[i].setMap(null);
	}
	
	function closeCourseOverlay(courseNum, index) {
		course_overlays[courseNum][index].setMap(null);
	}
	
	function searchReset(){
		$("#category_select_div").attr('hidden', 'hidden');
		$("#location_main_div").attr('hidden', 'hidden');
		$("#location_title").removeAttr('hidden');
		$("#category_title").removeAttr('hidden');
		
		$("#search_input").val("");
		
		$("#spot_area").empty();
		
		$(".selected_category").each(function() {
			$(this).remove();
		})
		$(".selected_location").each(function() {
			$(this).remove();
		})
		
		$(".location").each(function(){
			$(this).css('background-color',
			'rgba(0, 0, 0, 0)');
		})
		$(".sub_location").each(function(){
			$(this).css('background-color',
			'rgba(0, 0, 0, 0)').removeAttr('hidden');
		})
		$(".sub_all_location").each(function(){
			$(this).css('background-color',
			'rgba(0, 0, 0, 0)');
		})
		$(".sub_location_div").each(function(){
			$(this).css('background-color',
			'rgba(0, 0, 0, 0)');
		})
		$(".sub_location_div").each(function(){
			$(this).attr('hidden', 'hidden');
		})
		$(".category").each(function(){
			$(this).css('background-color',
			'rgba(0, 0, 0, 0)');
		})

		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
			overlays[i].setMap(null);
		}
		markers.length = 0;
		positions.length = 0;
		contents.length = 0;
		overlays.length = 0;
		
		var moveLatLon = new kakao.maps.LatLng(36.489287, 127.883847);
		map.setCenter(moveLatLon);
		map.setLevel(13);
	}
</script>
<script type="text/javascript">
	var currentYear = new Date().getYear();		//123 (1900 + 123) but, 생성자는 1900을 더한 값을 넣어주어야 한다.
	var currentMonth = new Date().getMonth();	//7 (0부터 시작)
	var drawMonth = new Date().getMonth();
	var drawYear = new Date().getYear();
	var dayCount = 0;
	var period = 0;
	var startDay = 0;
	var endDay = 0;
	var courseNum = 0;
	var courses;
	var course_markers;
	var course_overlays;
	var line_paths;
	var polyline
	
	function drawCalendar(year, month) {
		var startDay = new Date(year+1900, month, 0);
		var prevDate = startDay.getDate();		//31 (마지막 날)
		var prevDay = startDay.getDay();		//1 (월요일)
		
		var endDay = new Date(year+1900, month + 1, 0);
		var nextDate = endDay.getDate();
		var nextDay = endDay.getDay();
		var todayDate = new Date().getDate()
		
		
		var calendar = $("<div></div>").attr('class', 'calendar');
		
		var title = $("<h2></h2>").text((year+1900) + '년 ' + (month + 1) + '월');
		
		var go_before = $("<span></span>").text('<').attr('class', 'go-prev').attr('onclick', 'drawBefore()');
		var go_after = $("<span></span>").text('>').attr('class', 'go-next').attr('onclick', 'drawNext()');
		
		calendar.append(title);
		title.prepend(go_before);
		title.append(go_after);
		
		var calendar_head = $("<div></div>").attr('class', 'calendar_head');
		var sun = $("<span></span>").attr('class', 'day_title').text('Sun');
		var mon = $("<span></span>").attr('class', 'day_title').text('Mon');
		var tue = $("<span></span>").attr('class', 'day_title').text('Tue');
		var wed = $("<span></span>").attr('class', 'day_title').text('Wed');
		var thu = $("<span></span>").attr('class', 'day_title').text('Thu');
		var fri = $("<span></span>").attr('class', 'day_title').text('Fri');
		var sat = $("<span></span>").attr('class', 'day_title').text('Sat');
		
		calendar_head.append([sun, mon, tue, wed, thu, fri, sat]);
		
		calendar.append(calendar_head);
		
		for (var i = prevDate - prevDay; i <= prevDate; i++) {
		    calendar.append($("<div></div>").attr('class', 'day prev-mon').text(i));
		}
		
		for (var i = 1; i<=nextDate; i++){
			var day = $("<div></div>").attr('class', 'day now-mon').text(i).attr('onclick', 'selectDay("'+ year +'", "'+ month +'", "'+ i +'")');
			if (currentMonth == month && currentYear == year && i == todayDate) {
				day.attr('class', 'day now-mon today');
			}
			calendar.append(day);
		}
		for (var i = 1; i <= (nextDay == 6 ? 0 : 6 - nextDay); i++){
			calendar.append($("<div></div>").attr('class', 'day next-mon').text(i));
		}
		
		$("#calendar_div").html(calendar);
		
	}
	
	function drawNext(){
		drawMonth += 1;
		if(drawMonth == 12){
			drawMonth = 0;
			drawYear += 1;
		}
	    drawCalendar(drawYear, drawMonth);
	}
	
	function drawBefore(){
		drawMonth -= 1;
		if(drawMonth == -1){
			drawMonth = 11;
			drawYear -= 1;
		}
	    drawCalendar(drawYear, drawMonth);
	}
	
	function selectDay(year, month, day){
		/*date(2023, 8 , 29) = 2023년 9월 29일*/
		if(startDay != 0 && startDay.getYear() == year && startDay.getMonth() == month && startDay.getDate() == day) {
			startDay = 0;
			dayCount--;
		}
		else if (endDay != 0 && endDay.getYear() == year && endDay.getMonth() == month && endDay.getDate() == day) {
			endDay = 0;
			dayCount--;
		}
		else {
			year = +year + +1900;	//year이 문자열 취급되어 19001XX 되는것 방지

			switch(dayCount){
			case 0:
				startDay = new Date(year, month, day);
				dayCount++;
				break;
			case 1:
				if (startDay == 0) {
					startDay = new Date(year, month, day);
				}
				else {
					endDay = new Date(year, month, day);					
				}
				if(startDay > endDay) {
					var temp = startDay;
					startDay = endDay;
					endDay = temp;
				}
				dayCount++;
				break;
			}
		}
		calculatePeriod();
	}
	function calculatePeriod(){
		$("#schedule_div").empty();
		switch(dayCount) {
		case 0 :
			period = 0;
			break;
		case 1 :
			period = 1;
			var str = "";
			if(startDay != 0) {
				str = "여행일 : " + (startDay.getYear() + +1900) + "년 " + (startDay.getMonth() + +1) + "월"  + startDay.getDate() + "일";
			}
			else {
				str = "여행일 : " + (endDay.getYear() + +1900) + "년 " + (endDay.getMonth() + +1) + "월"  + endDay.getDate() + "일";
			}
			$("#schedule_div").text(str);
			break;
		case 2 :
			period = (endDay - startDay) / 86400000 + 1; //1000 * 60 * 60 * 24 = 86,400,000
			var startStr = "시작일 : " + (startDay.getYear() + +1900) + "년 " + (startDay.getMonth() + +1) + "월"  + startDay.getDate() + "일";
			var endStr = "종료일 : " + (endDay.getYear() + +1900) + "년 " + (endDay.getMonth() + +1) + "월"  + endDay.getDate() + "일";
			var startDiv = $("<div></div>").text(startStr);
			var endDiv = $("<div></div>").text(endStr);
			$("#schedule_div").append(startDiv).append(endDiv);
			
			break;
		}
		if(period != 1 && courseNum == 0) {
			$(".add_btn").each(function(){
				$(this).attr('hidden', 'hidden');
			})
		}
		else {
			$(".add_btn").each(function(){
				$(this).removeAttr('hidden');
			})
		}
		drawCourseTitle();
		drawCourseDetail()
	}
	
	function drawCourseTitle(){
		$("#course_title").empty();
		if(period == 1){
			$("#course_title").text('코스');
		}
		else if (period > 1) {
			var select_before_course = $("<span></span>").text('<').attr('onclick', 'goBeforeCourse()');
			var go_next_course = $("<span></span>").text('>').attr('onclick', 'goNextCourse()');
			if(courseNum == 0) {
				$("#course_title").text("전체 보기");
			}
			else {
				$("#course_title").text(+courseNum + "일차");
			}
			if(courseNum == period) {
				$("#course_title").prepend(select_before_course);
			}
			else if (courseNum == 0) {
				$("#course_title").append(go_next_course);
			}
			else {
				$("#course_title").prepend(select_before_course).append(go_next_course);
			}
		}
	}
	
	/*초기 설정 날짜 있는지 확인!!!!*/
	var when = searchParams.get('when');
	var where = searchParams.get('l_no');
	var cats = searchParams.get('cats');
	if(when != null){
		setTimeout(function(){
			var date = when.split(',');
			var start_date = date[0];
			var end_date=date[1];
		
			if(start_date == end_date) {
				var start = start_date.split('-');
				selectDay(start[0]-1900, start[1]-1, Number(start[2]));
			}
			else {
				var start = start_date.split('-');
				var end = end_date.split('-');
				selectDay(start[0]-1900, start[1]-1, Number(start[2]));
				selectDay(end[0]-1900, end[1]-1, Number(end[2]));
			}
			var arrSpots = ${arrSpots};
			var i = 1;
			for(i; i<arrSpots.length; i++) {
				var j = 0;
				goNextCourse();
				for (j; j<arrSpots[i].length; j++){
					if(arrSpots[i][j] != null){
						$.getJSON("getSpots.num?s_no="+arrSpots[i][j], function (spotJSON){
							$.each(spotJSON.spot, function(i, s){
								setSpot(i, s);
							});
							
						})
						addCourse(Number(arrSpots[i][j]));
						$("div .spot").empty();
					}
				}
			}
			if (period != 1) {
				while(courseNum > 0) {
					goBeforeCourse();
				}
			}
		}, 100);
		
	}
	
	if(where != null) {
		setTimeout(function(){
			$('.location[value='+where+']').trigger('click');
			$('.sub_location[value='+where+']').trigger('click');
		}, 100);
	}
	
	if(cats != null) {
		setTimeout(function(){
			var cat = cats.split(',');
			var i = 0;
			for(i; i<cat.length; i++){
				$('.category[value='+cat[i]+']').trigger('click');
			}
			searchSpot();
		},100);
	}
	
	function goBeforeCourse(){
		courseNum -= 1;
		drawCourseTitle();
		selectCourseDetail();
		drawCourseMarkers(courseNum);
		
		if(period != 1 && courseNum == 0) {
			$(".add_btn").each(function(){
				$(this).attr('hidden', 'hidden');
			})
		}
		else {
			$(".add_btn").each(function(){
				$(this).removeAttr('hidden');
			})
		}
	}
	
	function goNextCourse(){
		courseNum += 1;
		drawCourseTitle();
		selectCourseDetail();
		drawCourseMarkers(courseNum);
		
		if(period != 1 && courseNum == 0) {
			$(".add_btn").each(function(){
				$(this).attr('hidden', 'hidden');
			})
		}
		else {
			$(".add_btn").each(function(){
				$(this).removeAttr('hidden');
			})
		}
	}
	
	function drawCourseMarkers(courseNum){
		if(courseNum == 0 && period != 1) {
			line_paths[0] = [];
			for(var i = 0; i < course_markers.length; i ++){
				for(var j = 0; j < course_markers[i].length; j++){
					course_markers[i][j].setMap(map);
					line_paths[0].push(line_paths[i][j]);
				}
			}
		}
		else {
			for(var i = 0; i < course_markers.length; i ++){
				for(var j = 0; j < course_markers[i].length; j++){
					if(i == courseNum) {
						course_markers[i][j].setMap(map);
					}
					else {
						course_markers[i][j].setMap(null);
					}
				}
			}
		}
		if(polyline != null) {
			polyline.setMap(null);
		}
		polyline = new kakao.maps.Polyline({
		    path: line_paths[courseNum],
		    strokeWeight: 5,
		    strokeColor: '#FFAE00',
		    strokeOpacity: 0.7,
		    strokeStyle: 'solid'
		});
		polyline.setMap(map);
	}
	
	function drawCourseDetail(){
		if(course_markers != null) {
			for(var i = 0; i < course_markers.length; i++){
				for(var j = 0; j < course_markers[i].length; j++){
					course_markers[i][j].setMap(null);
				}
			}
		}
		
		if(course_overlays != null) {
			for(var i = 0; i < course_overlays.length; i++){
				for(var j = 0; j < course_overlays[i].length; j++){
					course_overlays[i][j].setMap(null);
				}
			}
		}
		
		if(polyline != null) {
			polyline.setMap(null);
		}
		$("#course_detail").empty();
		courses = new Array(period + 1);
		course_markers = new Array(period + 1);
		course_overlays = new Array(period + 1);
		line_paths = new Array(period + 1);
		
		for(var i = 0; i<=period; i++){
			var temp_div = $("<div></div>").attr('class', 'course_div').attr('value', i).attr('hidden', 'hidden');
			temp_div.sortable({
				start: function(e, ui){
					$(this).attr('data-previndex', ui.item.index());
				},
				stop: function(e, ui){
					var now_index = ui.item.index();
					var prev_index = Number($(this).attr('data-previndex'));
					var course = $(this).attr('value');
					[course_markers[course][prev_index], course_markers[course][now_index]] = [course_markers[course][now_index], course_markers[course][prev_index]];
					[line_paths[course][prev_index], line_paths[course][now_index]] = [line_paths[course][now_index], line_paths[course][prev_index]];
					
					drawCourseMarkers(courseNum);
				}
			});
			temp_div.disableSelection();
			$("#course_detail").append(temp_div);
			courses[i] = new Array();
			course_markers[i] = new Array();
			course_overlays[i] = new Array();
			line_paths[i] = new Array();
		}
		selectCourseDetail();
	}
	
	function selectCourseDetail(){
		if(courseNum == 0) {
			for(var i = 0; i<=period; i++){
				$('.course_div[value='+i+']').removeAttr('hidden');
			}
		}
		else {
			for(var i = 0; i<=period; i++){
				if (i == courseNum) {
					$('.course_div[value='+i+']').removeAttr('hidden');
				}
				else {
					$('.course_div[value='+i+']').attr('hidden', 'hidden');
				}
			}
		}
	}
	
	$(function(){
		drawCalendar(drawYear, drawMonth);
	})

</script>
<style type="text/css">
#course_layout {
	width: 15%;
	height: 100%;
	display: inline-block;
	float: left;
}

#course_detail {
	height: 100%;
	display: inline-block;
	overflow: auto;
}

#map {
	display: inline-block;
}

#spot_layout {
	width: 15%;
	height: 100%;
	display: inline-block;
	float: right;
	overflow: auto;
}

#save_area {
	position: fixed;
	bottom: 0;
	width: 100%;
}

html, body {
	height: 100%
}

*, *::before, *::after {
	padding: 0;
	margin: 0;
	box-sizing: border-box
}

body {
	min-height: 100vh;
	line-height: 1.5;
	font-family: Lato, sans-serif;
}

.calendar .calendar_head {
	display: flex;
	width: 100%;
	flex-flow: wrap;
	text-align: center;
	align-items: center;
}

.calendar_div {
	width: 100%;
	padding: 0.75em;
	margin: auto;
	font-size: 4vw;
	background-color: #fff;
	border-radius: 1.5em;
	user-select: none;
	box-shadow: 0 0.0625em 0.25em rgba(0, 20, 50, 0.2), 0 0.5em 0.5em
		0.125em rgba(0, 20, 50, 0.1);
}

.month-year {
	margin-bottom: 0.75em;
	font-weight: normal;
	font-size: 1.25em;
	text-align: center;
}

.calendar {
	display: flex;
	width: 100%;
	margin-bottom: 0.75em;
	flex-flow: wrap;
	overflow: hidden;
	border-collapse: collapse;
	-webkit-tap-highlight-color: transparent;
	justify-content: center;
}

.calendar_head .day_title {
	display: flex;
	width: calc(100%/ 7);
	height: 2em;
	vertical-align: top;
	font-weight: bold;
	font-size: 0.75em;
	text-transform: uppercase;
	letter-spacing: 0.0625em;
	text-align: center;
	justify-content: center;
}

.day {
	display: flex;
	height: 2em;
	width: calc(100%/ 7);
	text-align: center;
	position: relative;
	z-index: 1;
	justify-content: center;
	align-items: center;
	height: 2.5em;
	border-radius: 50%;
}

.day:nth-child(7n-4) {
	color: #ed2a61;
}

.day:nth-child(7n-5) {
	color: #3c6ffa;
}

.prev-mon, .next-mon {
	color: #ddd;
}
</style>
</head>
<body>
	<div id="course_layout">
		<div id="calendar_div" style="height: 30%;"></div>
		<div id="schedule_div" style="height: 5%;"></div>
		<div style="height: 65%;" id="course_div">
			<div id="course_title"></div>
			<div id="course_detail"></div>
		</div>
	</div>
	<div id="map" style="width: 70%; height: 100%;"></div>
	<div id="spot_layout">
		<input type="text" id="search_input">
		<div id="location_layout">
			<div id="location_title_div" onclick="switchLocationCheck()">
				<label id="location_title">지역</label>
			</div>
			<div id="location_main_div" hidden="hidden"></div>
		</div>
		<div id="category_layout">
			<div id="category_title_div" onclick="switchCategoryCheck()">
				<label id="category_title">카테고리</label>
			</div>
			<div id="category_select_div" hidden="hidden">
				<div>맛집</div>
				<label class="category" value=100>지역맛집</label><label class="category" value=102>전통시장</label><label class="category" value=103>카페</label><label class="category" value=104>식당</label>
				<p>
				<div>관광</div>
				<label class="category" value=201>지역축제</label><label class="category" value=202>테마파크</label><label
					class="category" value=203>유적지</label><label class="category" value=204>미술관</label><br>
				<label class="category" value=205>박물관</label>
				<p>
				<div>휴양</div>
				<label class="category" value=301>경치</label><label class="category" value=302>온천</label><label
					class="category" value=303>웰니스</label>
				<p>
				<div>액티비티</div>
				<label class="category" value=401>스키</label><label class="category" value=402>썰매</label><label
					class="category" value=403>패러글라이딩</label><label class="category" value=404>번지점프</label><br>
				<label class="category" value=405>카트</label><label class="category" value=406>루지</label><label
					class="category" value=407>ATV</label><label class="category" value=408>워터파크</label><br>
				<label class="category" value=409>빠지</label><label class="category" value=410>서핑</label><label
					class="category" value=411>스쿠버다이빙</label><label class="category" value=412>해상레저</label><br>
				<label class="category" value=413>수상레저</label>
			</div>
			<p>
				<button onclick="searchSpot()">검색</button>
				<button onclick="searchReset()">초기화</button>
		</div>
		<div id="spot_area" style="overflow: auto;"></div>
		<div id="save_area">
			<button>저장</button>
		</div>
	</div>
	<script>
		var mapContainer = document.getElementById('map')
		var mapOption;
		var map;
		
		let l_no = searchParams.get('l_no');
		if (l_no != null) {
			var lat;
			var lon;
			$.getJSON("location?l_no=" + l_no, function(locationJSON) {
				lat = locationJSON.location[0].l_lat;
				lon = locationJSON.location[0].l_lon;
				mapOption = {
					center : new kakao.maps.LatLng(lat, lon),
					level : 9
				};
			});
		} else {
			mapOption = {
				center : new kakao.maps.LatLng(36.489287, 127.883847),
				level : 13
			};
		}
		var map = new kakao.maps.Map(mapContainer, mapOption);
	</script>
</body>
</html>