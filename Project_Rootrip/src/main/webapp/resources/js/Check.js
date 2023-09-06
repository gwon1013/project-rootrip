/**
 * 
 */

function checkJoin(){
	var idInput = document.joinForm.u_id;
	var domainInput = document.joinForm.u_domain_manual;
	var pwInput = document.joinForm.u_pw;
	var pwChkInput = document.joinForm.u_pw_chk;
	var photoInput = document.joinForm.u_profile;
	var nickNameInput = document.joinForm.u_nickname;
	
	if(isEmpty(idInput)) {
		idInput.focus();
		alert("이메일이 비어있음!");
		return false;
	}
	else if(isEmpty(domainInput)) {
		domainInput.focus();
		alert("이메일이 비어있음!");
		return false;
	}
	else if($("#join_id").css("color") == "rgb(255, 0, 0)") {
		domainInput.focus();
		alert("중복된 이메일입니다.");
		return false;
	}
	else if (isEmpty(pwInput)) {
		pwInput.focus();
		alert("비밀번호가 비어있음!");
		return false;
	}
	else if (atLeastLetter(pwInput, 4)) {
		alert("비밀번호는 최소 4자 이상입니다!");
		return false;
	}
	else if (notEqualPW(pwInput, pwChkInput)) {
		pwInput.focus();
		alert("비밀번호가 서로 다름!");
		return false;
	}
	else if (isEmpty(nickNameInput)) {
		nickNameInput.focus();
		alert("닉네임이 비어있음!");
		return false;
	}
	else if (photoInput.value){
		if(isNotType(photoInput, "JPG") && isNotType(photoInput, "PNG")
				&& isNotType(photoInput, "BMP") && isNotType(photoInput, "WEBP")
				&& isNotType(photoInput, "JPEG") && isNotType(photoInput, "jpg")
				&& isNotType(photoInput, "png") && isNotType(photoInput, "bmp")
				&& isNotType(photoInput, "webp")) {
					alert("호환되지 않는 확장자 파일!");
					return false;
				}
	}
	return true;
}

function checkUpdate(){
	var pwInput = document.joinForm.u_pw;
	var pwChkInput = document.joinForm.u_pw_chk;
	var photoInput = document.joinForm.u_profile;
	var nickNameInput = document.joinForm.u_nickname;
	
	if (isEmpty(pwInput)) {
		pwInput.focus();
		alert("비밀번호가 비어있음!");
		return false;
	}
	else if (atLeastLetter(pwInput, 4)) {
		alert("비밀번호는 최소 4자 이상입니다!");
		return false;
	}
	else if (notEqualPW(pwInput, pwChkInput)) {
		pwInput.focus();
		alert("비밀번호가 서로 다름!");
		return false;
	}
	else if (isEmpty(nickNameInput)) {
		nickNameInput.focus();
		alert("닉네임이 비어있음!");
		return false;
	}
	else if (photoInput.value){
		if(isNotType(photoInput, "JPG") && isNotType(photoInput, "PNG")
				&& isNotType(photoInput, "BMP") && isNotType(photoInput, "WEBP")
				&& isNotType(photoInput, "JPEG") && isNotType(photoInput, "jpg")
				&& isNotType(photoInput, "png") && isNotType(photoInput, "bmp")
				&& isNotType(photoInput, "webp")) {
					alert("호환되지 않는 확장자 파일!");
					return false;
				}
	}
	return true;
}

function changeImage(files, profile){
	if(files[0]) {
		if(files[0].type.startsWith("image/")) {
			var reader = new FileReader()
			reader.onload = e => {
				$(".profile_preview").attr("src", e.target.result)
			}
			reader.readAsDataURL(files[0]);
			return;
		}
		else {
			alert("지원하지 않는 파일입니다.");
			document.getElementById("input_profile").value="";
		}
    }
	if(!(profile == null || profile == "")) {
		$(".profile_preview").attr("src", "resources/img/"+profile)
	}
	else {
		$(".profile_preview").attr("src", "resources/img/profile.png")
	}
}

function changeLocationImage(files, photo){
	if(files[0]) {
		if(files[0].type.startsWith("image/")) {
			var reader = new FileReader()
			reader.onload = e => {
				$("#location_preview").attr("src", e.target.result)
			}
			reader.readAsDataURL(files[0]);
			return;
		}
		else {
			alert("지원하지 않는 파일입니다.");
			document.getElementById("input_photo").value="";
		}
    }
	if(!(photo == null || photo == "")) {
		$("#location_preview").attr("src", "resources/img/지역사진/"+photo)
	}
	else {
		$("#location_preview").attr("src", "resources/img/city.png")
	}
}

function connectIdCheckEvent() {
	$("#join_id").on("propertychange change keyup paste input", function() {
		var u_mail = $(this).val()+'@'+$("#join_domain_input").val();
		$.getJSON("member.check?u_mail="+u_mail, function(memberJSON){
			if (memberJSON.member[0] == null) {
				$("#join_id").css("color", "black");
				$("#join_domain_input").css("color", "black");
			} else {
				$("#join_id").css("color", "red");
				$("#join_domain_input").css("color", "red");
			}
		});
	});
	$("#join_domain_input").on("propertychange change keyup paste input", function() {
		var u_mail = $("#join_id").val() + '@' + $(this).val();
		$.getJSON("member.check?u_mail="+u_mail, function(memberJSON){
			if (memberJSON.member[0] == null) {
				$("#join_id").css("color", "black");
				$("#join_domain_input").css("color", "black");
			} else {
				$("#join_id").css("color", "red");
				$("#join_domain_input").css("color", "red");
			}
		});
	});
	$("#join_domain").on("change", function() {
		var u_mail = $("#join_id").val() + '@' + $(this).val();
		$.getJSON("member.check?u_mail="+u_mail, function(memberJSON){
			if (memberJSON.member[0] == null) {
				$("#join_id").css("color", "black");
				$("#join_domain_input").css("color", "black");
			} else {
				$("#join_id").css("color", "red");
				$("#join_domain_input").css("color", "red");
			}
		});
	});
}

function selectDomain(){
	var value = $("#join_domain option:selected").text();
	if(value == "직접입력") {
		$("#join_domain_input").attr("readonly", false);
		$("#join_domain_input").val("").focus();
	}
	else {
		$("#join_domain_input").attr("readonly", "readonly");
		$("#join_domain_input").val(value);
	}
	
}

function checkEditLocation(){
	var l_name = document.editForm.l_name;
	var l_number = document.editForm.l_no;
	var l_lat = document.editForm.l_lat;
	var l_lon = document.editForm.l_lon;
	var l_photo = document.editForm.l_photo;
	
	if(isEmpty(l_name)) {
		l_name.focus();
		alert("지역 이름이 비어있습니다!");
		return false;
	}
	else if(isEmpty(l_lat) || isEmpty(l_lon)){
		l_lat.focus();
		alert("위도/경도가 비어있습니다!");
		return false;
	}
	else if (l_photo.value){
		if(isNotType(photoInput, "JPG") && isNotType(photoInput, "PNG")
				&& isNotType(photoInput, "BMP") && isNotType(photoInput, "WEBP")
				&& isNotType(photoInput, "JPEG") && isNotType(photoInput, "jpg")
				&& isNotType(photoInput, "png") && isNotType(photoInput, "bmp")
				&& isNotType(photoInput, "webp")) {
					alert("호환되지 않는 확장자 파일!");
					return false;
				}
	}
	return true;
}

$(function() {
	connectIdCheckEvent();
	$("#join_domain_input").val($("#join_domain option:selected").text());
})