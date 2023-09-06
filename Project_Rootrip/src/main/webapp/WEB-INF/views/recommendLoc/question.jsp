<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>question.jsp</title>
<link rel="stylesheet" href="resources/css/startPage.css" type="text/css" />
<link rel="stylesheet" href="resources/css/questionmenu.css" />
<script type="text/javascript">
		// Q1 선택지 리스트
		let ansQ1 =  [
					{
						option : "혼자",
						value : 1
					},
					{
						option : "둘이서",
						value : 2
					},
					{
						option : "3명 이상",
						value : 3
					},
				];
		
		// Q2 선택지 리스트 
		let ansQ2 =  [
					{
						option : "봄",
						value : "봄"
					},
					{
						option : "여름",
						value : "여름"
					},
					{
						option : "가을",
						value : "가을"
					},
					{
						option : "겨울",
						value : "겨울"
					},
				];
		
		// Q3 선택지 리스트
		let ansQ3 =  [
					{
						option : "맛집",
						value : "맛집"
					},
					{
						option : "관광",
						value : "관광"
					},
					{
						option : "휴양",
						value : "휴양"
					},
					{
						option : "액티비티",
						value : "액티비티"
					},
				];
		
		let ansQ4 = [
			{
				"맛집" : [
					{
						option : "지역맛집",
						value : 101
					},
					{
						option : "전통시장",
						value : 102
					},
					{
						option : "카페",
						value : 103
					},
				],
				"관광" : [
					{
						option : "지역축제",
						value : 201
					},
					{
						option : "테마파크",
						value : 202
					},
					{
						option : "유적지",
						value : 203
					},
					{
						option : "미술관",
						value : 204
					},
					{
						option : "박물관",
						value : 205
					},
				],
				"휴양" : [
					{
						option : "경치",
						value : 301
					},
					{
						option : "온천or스파",
						value : 302
					},
					{
						option : "웰니스",
						value : 303
					},
				],
				"액티비티" : [
					{
						option : "스키",
						value : 401
					},
					{
						option : "썰매",
						value : 402
					},
					{
						option : "패러글라이딩",
						value : 403
					},
					{
						option : "번지점프",
						value : 404
					},
					{
						option : "카트",
						value : 405
					},
					{
						option : "루지",
						value : 406
					},
					{
						option : "ATV",
						value : 407
					},
					{
						option : "워터파크",
						value : 408
					},
					{
						option : "빠지",
						value : 409
					},
					{
						option : "서핑",
						value : 410
					},
					{
						option : "스쿠버다이빙",
						value : 411
					},
					{
						option : "해상레저",
						value : 412
					},
					{
						option : "수상레저",
						value : 413
					},
				]
			},
			
		];
	$(function(){
		// 시작하기 버튼을 누른다면
		$('#start_btn').on('click',function(){
			// 버튼 가리기
			$('#start_btn').css('display','none');
			// Q1 질문 추가하기
			let td1 = $("<td></td>").text("Q1. 누구랑 가?");
			let tr1 = $("<tr></tr>").append(td1);
			
			// Q1 선택자 추가하기
			let td2 = $('<td></td>');
			let tr2 = $('<tr></tr>');
			$.each(ansQ1,function(i, a){
				let input = $("<input type='radio' id='"+a.option+"' name='Q1' value='"+a.value+"' onclick='getQ1Val();'/>");
				let label = $("<label for='"+a.option+"'>"+a.option+"</label>");
				td2.append(input,label);
			});
			tr2.append(td2);
			$("#q4_options").before(tr1, tr2);
			
		});
		
		// 결과확인하기 버튼 = 제출버튼 
		$("#next_btn").on('click',function(){
			$("#submit_btn").click();
		});
		
		
		// 현재 날짜 설정
		let currentDate = new Date();
		// 현재 날짜 String으로
		let minStr = currentDate.toISOString().split('T')[0];
		// 최소 날짜 설정
		$(document).on("click","#sDate",function(){
			$("#sDate").attr("min",minStr);
		});
		$(document).on("click","#eDate",function(){
			$("#eDate").attr("min",$("#sDate").val());
		});
		
		//sDate 바꿨을 때 eDate 초기화
		$(document).on("change","#sDate",function(){
			$("#eDate").val(null);
		});
		
	});
		
	// Q1 선택했을 때
	function getQ1Val(){
		// 만약 #Q1에 값이 0이라면(기본값이라면 = 아무것도 선택되지 않았다면)
		if ($('#Q1').val() == 0) {
			// Q2 질문 추가하기
			let td1 = $("<td></td>").text("Q2. 언제 가?");
			let tr1 = $("<tr></tr>").append(td1);
			
			// Q2 선택지 추가하기
			let td2 = $("<td></td>");
			let tr2 = $("<tr></tr>");
			let input = null;
			let label = null;
			//for (var i = 0; i < ansQ2.length; i++) {
				//input = $("<input type='radio' id='"+ansQ2[i].option+"' name='Q2' value='"+ansQ2[i].value+"' onclick='getQ2Val();'/>");
				//label = $("<label for='"+ansQ2[i].option+"'>"+ansQ2[i].option+"</label>");
				//td2.append(input,label);
			//}
			input1 = $("<input type='date' id='sDate' name='Q2' />");
			input2 = $("<input type='date' id='eDate' name='Q2'onchange='getQ2Val();'/>");
			td2.append(input1,input2);
			tr2.append(td2);
			$("#q4_options").before(tr1, tr2);
		}
		// #Q1에 값 저장
		$('#Q1').val($("input:radio[name='Q1']:checked").val());
	};
	
	// Q2 선택했을 때
	function getQ2Val(){
		var start = $("#sDate").val();
		var end = $("#eDate").val();
		if (start > end) {
			alert("시작 날짜는 종료 날짜보다 앞서야 합니다!");
			$("#eDate").focus();
		} else {
			// 만약 #Q2에 값이 0이라면
			if ($('#Q2').val() == 0) {
				// Q3 질문 추가하기
				let td1 = $("<td></td>").text("Q3. 뭐 하고 싶은데?");
				let tr1 = $("<tr></tr>").append(td1);
				$("#q4_options").before(tr1);
				
				// Q3 선택지 추가하기
				let td2 = $("<td></td>");
				let tr2 = $("<tr></tr>");
				let input = null;
				let label = null;
				for (var i = 0; i < ansQ3.length; i++) {
					input = $("<input type='checkbox' id='"+ansQ3[i].option+"' name='Q3' value='"+ansQ3[i].value+"' onclick='getQ3Val("+ansQ3[i].option+");'/>");
					label = $("<label for='"+ansQ3[i].option+"'>"+ansQ3[i].option+"</label>");
					td2.append(input,label);
				}
				tr2.append(td2);
				$("#q4_options").before(tr2);
			}
			// #Q2에 값 저장
			$('#Q2').val(start+","+end);
			
		}
	};
	
	// Q3 선택했을 때
	function getQ3Val(v){
		// #Q3에 값 저장(체크박스) 전에 선택한 value 가져오기
		var arrChk = [];
		$("input[name='Q3']").each(function(){
		    if( $(this).is(":checked") == true ){
		    	var checkVal = $(this).val();
				arrChk.push(checkVal);
		    } 
		    if ( $(this).is(":checked") == false ) { // 체크가 헤제된다면 
				var unCheckedVal = $(this).val();
				$("."+unCheckedVal+"_tr").remove(); // 기존에 생성되어있었던 선택지 삭제
				$('#Q4').val(0);
			}
		})
		
		if ( $("#Q3").val() == 0 ) { // 아무것도 없는 상태일 때
			if ( $('#question4') ) { // 4번질문이 이미 있다면
				$('#question4').remove();
			}
			let td1 = $("<td></td>").text("Q4. 구체적으로는?");
			let tr1 = $("<tr id='question4'></tr>").append(td1);
			$("#q4_options").before(tr1);
		}
		
		// Q4 선택지 만들기
		$.each(arrChk, function(i, c){
			if ($("."+c+"_tr")) { // 중복생성 방지용
				$("."+c+"_tr").remove();
			}
			let tdtr = $("<tr class='"+c+"_tr'><td>"+c+"</td></tr>");
			let td2 = $("<td></td>");
			let tr2 = $("<tr class='"+c+"_tr'></tr>");
			$.each(ansQ4[0][c], function(i, v){
				let input = $("<input type='checkbox' id='"+v.option+"' name='Q4' value='"+v.value+"' onclick='getVal();'/>");
				let label = $("<label for='"+v.option+"' >"+v.option+"</label>");
				td2.append(input,label);
			});
			tr2.append(td2);
			$('#q4_options_tb').append(tdtr, tr2);
		})
		
		$("#Q3").val(arrChk);
		
	};
	
	// Q4 선택했을 때
	function getVal(){
		var arrChk = [];
		$("input[name='Q4']").each(function(){
		    if( $(this).is(":checked") == true ){
		    	var checkVal = $(this).val();
				arrChk.push(checkVal);	     
		    }
		})
		$("#Q4").val(arrChk);
		if ($("Q4").val() != 0) {
			$("#next_btn").css("display","block");
		}
		if (! $("#Q4").val()) {
			$("#next_btn").css("display","none");
		}
	}
	
</script>
</head>
<body>
	<!-- 전송용 form (보이지 않도록) -->
	<form action="recommendLoc.result.go">
		<table id="invisibleTb" border="1">
			<tr>
				<td><input id="Q1" name="Q1" readonly="readonly" value="0"></td>
				<td><input id="Q2" name="Q2" readonly="readonly" value="0"></td>
				<td><input id="Q3" name="Q3" readonly="readonly" value="0"></td>
				<td><input id="Q4" name="Q4" readonly="readonly" value="0"></td>
				<td><button id="submit_btn"></button></td>
			</tr>
		</table>
	</form>

	<!-- 질문 나오는 table -->
	<table id="visibleTb">
		<tr>
			<td id="recommendplace">내가 여행지를 추천해줄게</td>
		</tr>
		<tr>
			<td id="qq">몇가지 질문에 대답해주면 돼</td>
		</tr>
		<tr id="q4_options">
			<td>
				<table id="q4_options_tb"></table>
			</td>
		</tr>
	</table>
	
	<!-- button table -->
	<table>
		<tr>
			<td><button id="start_btn">시작하기</button></td>
		</tr>
		<tr>
			<td><button id="next_btn" style="display:none">결과확인하기</button></td>
		</tr>
	</table>

</body>