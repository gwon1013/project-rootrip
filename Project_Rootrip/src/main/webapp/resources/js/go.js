/**
 * 
 */


function goDrop(){
	if(confirm("탈퇴하시겠습니까?")) {
		location.href="member.drop";
	}
}

function goQuestion(){
	location.href="recommendLoc.question.go";
}

function goManageLocation(){
	location.href="admin.location";
}

function goEditLocation(location_number) {
	location.href="admin.location.edit?l_no="+location_number;
}