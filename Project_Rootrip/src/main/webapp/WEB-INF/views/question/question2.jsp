<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>question.jsp</title>
<script type="text/javascript" src="resources/js/jQuery.js"></script>
<script type="text/javascript">
	$(function(){
		
		// 질문 리스트
		let arrTxt = [
			"몇명이서 가?",
			"언제가?",
			"뭐하고싶어?",
			"구체적으로는?"
		]; 
		
		// 1번 질문[2] 선택지 리스트
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
						value : 0
					},
				];
		
		// 2번 질문[3] 선택지 리스트 
		let ansQ2 =  [
					{
						option : "봄",
					},
					{
						option : "여름",
					},
					{
						option : "가을",
					},
					{
						option : "겨울",
					},
				];
		
		// 3번 질문[4] 선택지 리스트
		let ansQ3 =  [
					{
						option : "맛집",
					},
					{
						option : "관광",
					},
					{
						option : "휴양",
					},
					{
						option : "액티비티",
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
								option : "온천&스파",
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

			
		// 다음 버튼을 눌렀을 때
		let qc = 0;
		$('#nextBtn').click(function(){
			let q = arrTxt[qc];
			let td = $('<td></td>').text(q);
			let tr = $('<tr></tr>').append(td);
			$('#visibleTb').append(tr);
			
			if(qc == 0){ // 만약 첫번째 질문이라면
				let td = $('<td></td>');
				let tr = $('<tr></tr>');
				$.each(ansQ1,function(i, a){
					let o = a.option;
					let v = a.value;
					let input = $("<input type='radio' id='"+o+"' name='Q1' value='"+v+"' onclick='getRadioVal(\"Q1\");'/>")
					let label = $("<label for='"+o+"'>"+o+"</label>")
					td.append(input,label);
				});
				tr.append(td);
				$('#visibleTb').append(tr);
			} else if (qc == 1) { // 만약 두번째 질문이라면
				let td = $('<td></td>');
				let tr = $('<tr></tr>');
				$.each(ansQ2,function(i, a){
					let o = a.option;
					let input = $("<input type='radio' id='"+o+"' name='Q2' value='"+o+"' onclick='getRadioVal(\"Q2\");'/>")
					let label = $("<label for='"+o+"'>"+o+"</label>")
					td.append(input,label);
				});
				tr.append(td);
				$('#visibleTb').append(tr)
			} else if (qc == 2) { // 만약 세번째 질문이라면
				let td = $('<td></td>');
				let tr = $('<tr></tr>');
				$.each(ansQ3,function(i, a){
					let o = a.option;
					let input = $("<input type='checkbox' id='"+o+"' name='Q3' value='"+o+"'onclick='getCheckboxVal(\"Q3\");'/>")
					let label = $("<label for='"+o+"'>"+o+"</label>")
					td.append(input,label);
				});
				tr.append(td);
				$('#visibleTb').append(tr)
			} else if (qc == 3) { // 만약 네번째 질문이라면
				var arrChk = $('#Q3').val().split(",")
				$.each(arrChk, function(i, a){
					let tdtr = $("<tr><td>"+a+"</td></tr>");
					let td = $('<td></td>');
					let tr = $('<tr></tr>');
					$.each(ansQ4[0][a], function(i, b){
						let o = b.option;
						let v = b.value;
						let input = $("<input type='checkbox' id='"+o+"' name='Q4' value='"+v+"'onclick='getCheckboxVal(\"Q4\");'/>")
						let label = $("<label for='"+o+"'>"+o+"</label>")
						td.append(input,label);
					});
					tr.append(td);
					$('#visibleTb').append(tdtr,tr)
				});
			}
			qc++;
		});
		
	});
	
	$(document).ready(function(){
		$("input[name='Q3']").each(function(){
			if($(this).chage()){
				alert('hi');
			}
		});
	});
	
	function getRadioVal(a){
		$("#"+a).val($("input:radio[name='"+a+"']:checked").val());
	};
	
	function getCheckboxVal(a){
		var arrChk = [];
		$("input[name='"+a+"']").each(function(){
		    if( $(this).is(":checked") == true ){
		    	var checkVal = $(this).val();
				arrChk.push(checkVal);	      
		    }
		})
		$("#"+a).val(arrChk);
	};
	
	
	
	
</script>
</head>
<body>
	<!-- 전송용 form (보이지 않도록) -->
	<form action="#">
		<table id="invisibleTb" border="1">
			<tr>
				<td><input id="Q1" readonly="readonly"></td>
				<td><input id="Q2" readonly="readonly"></td>
				<td><input id="Q3" readonly="readonly"></td>
				<td><input id="Q4" readonly="readonly"></td>
				<td><button></button></td>
			</tr>
		</table>
	</form>

	<!-- 질문 나오는 table -->
	<table id="visibleTb" border="1">
		<tr>
			<td>내가 여행지를 추천해줄게</td>
		</tr>
		<tr>
			<td>몇가지 질문에 대답해주면 돼</td>
		</tr>
	</table>
	
	<!-- button table -->
	<table>
		<tr>
			<td><button id="nextBtn">다음</button></td>
		</tr>
	</table>


</body>