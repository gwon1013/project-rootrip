<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EditLocation</title>
<script type="text/javascript">
$(function(){
	let searchParams = new URLSearchParams(window.location.search);
	let param = searchParams.get('l_no');
	$.getJSON("location?l_no=" + param, function(locationJSON){
		var i;
		$.each(locationJSON.location, function(i, l){
			var location_number = l.l_no;
			var location_name = l.l_name;
			var location_lat = l.l_lat;
			var location_lon = l.l_lon;
			var location_photo;
			if(l.l_photo == null) {
				location_photo = 'city.png'
			}
			else {
				location_photo = l.l_photo;
			}
			$("img#location_preview").attr('src', 'resources/img/지역사진/'+location_photo);
			$("#input_photo").attr('onchange', 'changeLocationImage(this.files, "'+location_photo+'")');
			document.editForm.l_name.value = location_name;
			document.editForm.l_no.value = location_number;
			document.editForm.l_lat.value = location_lat;
			document.editForm.l_lon.value = location_lon;
		})
	})
})
</script>
</head>
<body>
	<form action="admin.location" method="post" enctype="multipart/form-data" name="editForm" onsubmit="return checkEditLocation();">
		<table>
			<tr>
				<td>지역 이름</td>
				<td align="center"><input name="l_name" placeholder="지역 이름"></td>
			</tr>
			<tr>
				<td>지역 번호</td>
				<td align="center"><input name="l_no" placeholder="지역번호" readonly="readonly"></td>
			</tr>
			<tr>
				<td>지역 사진</td>
			</tr>
			<tr>
				<td>
					<img id="location_preview">
				</td>
				<td><input id="input_photo" type="file" accept="image/*" name="l_photo"></td>
			</tr>
			<tr>
				<td rowspan="2">위도/경도</td><td><input name="l_lat" placeholder="위도"></td>
			</tr>
			<tr>
				<td><input name="l_lon" placeholder="경도"></td>
			</tr>
			<tr>
				<td><button>정보 수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>