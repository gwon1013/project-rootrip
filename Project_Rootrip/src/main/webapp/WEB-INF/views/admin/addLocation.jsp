<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addLocation</title>
</head>
<body>
	<form action="admin.location.add" method="post" enctype="multipart/form-data" name="addForm" onsubmit="return checkEditLocation();">
		<table>
			<tr>
				<td>지역 이름</td>
				<td align="center"><input name="l_name" placeholder="지역 이름"></td>
			</tr>
			<tr>
				<td>지역 번호</td>
				<td align="center"><input name="l_no" placeholder="지역번호"></td>
			</tr>
			<tr>
				<td>지역 사진</td>
			</tr>
			<tr>
				<td>
					<img id="location_preview">
				</td>
				<td><input id="input_photo" type="file" accept="image/*" name="l_photo" onchange='changeLocationImage(this.files, null)'></td>
			</tr>
			<tr>
				<td rowspan="2">위도/경도</td><td><input name="l_lat" placeholder="위도"></td>
			</tr>
			<tr>
				<td><input name="l_lon" placeholder="경도"></td>
			</tr>
			<tr>
				<td><button>추가</button></td>
			</tr>
		</table>
	</form>
</body>
</html>