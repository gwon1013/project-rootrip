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
			"내가 여행지를 추천해줄게",
			"몇가지 질문에 대답해주면 돼",
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
						value : 100
					},
					{
						option : "여름",
						value : 200
					},
					{
						option : "가을",
						value : 300
					},
					{
						option : "겨울",
						value : 400
					},
				];
		
		// 3번 질문[4] 선택지 리스트
		let ansQ3 =  [
					{
						option : "맛집",
						value : 100
					},
					{
						option : "관광",
						value : 200
					},
					{
						option : "휴양",
						value : 300
					},
					{
						option : "액티비티",
						value : 400
					},
				];
		
		let ansQ4 = [
					{
						100 : [
							{
								option : "지역맛집",
								value : 101
							},
							{
								option : "지역맛집",
								value : 102
							},
							{
								option : "지역맛집",
								value : 103
							},
						],
						200 : [
							
						]
					},
				];
		
		
		// 다음 버튼을 눌렀을 때
		let i = 0;
		let q = arrTxt[i];
		let td = $('<td></td>').text(q);
		let tr = $('<tr></tr>').append(td);
		$('#visibleTb').append(tr);
		$('#nextBtn').click(function(){
			i++;
			let q = arrTxt[i];
			let td = $('<td></td>').text(q);
			let tr = $('<tr></tr>').append(td);
			$('#visibleTb').append(tr);
			
			// 만약 첫번째 질문이라면
			if(i==2){
				let td = $('<td></td>');
				let tr = $('<tr></tr>');
				$.each(ansQ1,function(i, a){
					let o = a.option;
					let v = a.value;
					let input = $("<input type='radio' id='"+o+"' name='Q1' value='"+v+"' onclick='getRadioVal();'/>")
					let label = $("<label for='"+o+"'>"+o+"</label>")
					td.append(input,label);
				});
				tr.append(td);
				$('#visibleTb').append(tr)
			} else if (i == 3) {
				let td = $('<td></td>');
				let tr = $('<tr></tr>');
				$.each(ansQ2,function(i, a){
					let o = a.option;
					let v = a.value;
					let input = $("<input type='checkbox' id='"+o+"' name='Q2' value='"+v+"' onclick='getCheckboxVal(\"Q2\");'/>")
					let label = $("<label for='"+o+"'>"+o+"</label>")
					td.append(input,label);
				});
				tr.append(td);
				$('#visibleTb').append(tr)
			} else if (i == 4) {
				let td = $('<td></td>');
				let tr = $('<tr></tr>');
				$.each(ansQ3,function(i, a){
					let o = a.option;
					let v = a.value;
					let input = $("<input type='checkbox' id='"+o+"' name='Q3' value='"+v+"'onclick='getCheckboxVal(\"Q3\");'/>")
					let label = $("<label for='"+o+"'>"+o+"</label>")
					td.append(input,label);
				});
				tr.append(td);
				$('#visibleTb').append(tr)
			} else if (i == 5) {
				var arrChk = $('#Q3').val().split(",")
				$.each(arrChk, function(i, a){
					$.each(ansQ4,function(i, b){
						alert(b.a);
					});
				});
			}
		});
		
	});
	
	function getRadioVal(){
		$('#Q1').val($("input:radio[name='Q1']:checked").val());
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
	</table>
	
	<!-- button table -->
	<table>
		<tr>
			<td><button id="nextBtn">다음</button></td>
		</tr>
	</table>


</body>