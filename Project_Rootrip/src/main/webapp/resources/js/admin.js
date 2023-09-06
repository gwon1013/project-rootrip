/**
 * 
 */

function addLocation(){
	location.href="admin.location.add.go";
}

function removeLocation(l_no){
	location.href="admin.location.remove?l_no="+l_no;
}

function goManageLocation(p){
	location.href="admin.location?p="+p;
}

function goManageLocationWithName(query, p){
	location.href="admin.location?query="+query+"&p="+p;		
}

function goEditLocation(location_number) {
	location.href="admin.location.edit?l_no="+location_number;
}

function goManageUsers(p){
	location.href="admin.users?p="+p;
}

function goManageUsersWithNickname(nickname, p){
	location.href="admin.users?nickname="+nickname+"&p="+p;		
}

function goManageUsersWithMail(mail, p) {
	location.href="admin.users?mail="+mail+"&p="+p;
}

function searchLocation(){
	var search_name = document.getElementById('location_name').value;
	goManageLocationWithName(search_name, 1);
}

function searchUser(){
	var user_input = document.getElementById('user_input').value;
	
	var category = document.getElementById('user_category').value;
	
	if(category == '이메일') {
		goManageUsersWithMail(user_input, 1);
	}
	else if (category == '닉네임') {
		goManageUsersWithNickname(user_input, 1);
	}
}

function kickUser(mail) {
	if(confirm('강퇴 시키겠습니까?')) {
		location.href="admin.users.kick?mail="+mail;
	}
}

$(function(){
	let searchParams = new URLSearchParams(window.location.search);
	let mail = searchParams.get('mail');
	let nickname = searchParams.get('nickname');
	var category = document.getElementById('user_category');
	
	if(mail != null){
		category.value = '이메일';
	}
	else if (nickname != null){
		category.value = '닉네임';
	}
	
	$("#location_name").on("keyup", function(e){
		if(e.keyCode==13){
			$("#search_btn").click();
		}
	})
	
	$("#user_input").on("keyup", function(e){
		if(e.keyCode==13){
			$("#search_btn").click();
		}
	})
})


