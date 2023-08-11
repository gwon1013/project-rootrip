/**
 * 
 */

function checkJoin(){
	var emailInput = document.joinForm.u_mail;
	var pwInput = document.joinForm.u_pw;
	var pwChkInput = document.joinForm.u_pw_chk;
	var photoInput = document.joinForm.u_profile;
	var nickNameInput = document.joinForm.u_nickname;
	
	if(isEmpty(emailInput)) {
		emailInput.focus();
		alert("이메일이 비어있음!");
		return false;
		/*이메일 입력 칸이 비어 있거나, 중복된 회원이 있는 경우, 어떻게 경고할 것인가*/
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