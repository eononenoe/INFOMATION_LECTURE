<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b</title>
<style>
td{
text-align: left;
}
.ttd{
text-align: center;
}
.tttd{
width:152px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>강사조회</h3>
	<form name="frm" action="action.jsp" method="get"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td class="ttd">수강월</td>
				<td><input name="b1"> 예) 2022년03월 → 202203 </td>
			</tr>
			<tr>
				<td class="ttd">회원명</td>
				<td>
				<select  name="b2" class="tttd" onchange="rename()">
						<option value="">회원명</option>
						<option value="10001">홍길동</option>
						<option value="10002">장발장</option>
						<option value="10003">임꺽정</option>
						<option value="20001">성춘향</option>
						<option value="20002">이몽룡</option>
				</select>
				</td>
			</tr>
			<tr>
				<td class="ttd">회원번호</td>
				<td><input readonly="readonly" name="b3"> 예)10001 </td>
			</tr>
			<tr>
				<td class="ttd">강의장소</td>
				<td><input name="b4"></td>
			</tr>
			<tr>
				<td class="ttd">강의명</td>
				<td>
				<select name="b5" class="tttd" onchange="money();">
						<option value="">강의신청</option>
						<option value="100">초급반</option>
						<option value="200">중급반</option>
						<option value="300">고급반</option>
						<option value="400">심화반</option>
				</select>
				</td>
			</tr>
			<tr>
				<td class="ttd">수강료</td>
				<td><input readonly="readonly" name="b6"> 원</td>
			</tr>
			<tr>
				<td colspan="2" class="ttd">
					<button type="submit" onclick="return check();">수강신청</button>
					<button type="reset" onclick="return rreset();">다시쓰기</button>
				</td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script>
	function rename(){
		frm.b3.value = frm.b2.value;
		money();
		return true;
	}
	function money(){
		var num1 = parseInt(frm.b3.value);
		var na = frm.b5.value; 
		var nam = 0;
		var price = 0;
		
		switch(na){
		case "100":
			nam = 100000;
			break;
		case "200":
			nam = 200000;
			break;
		case "300":
			nam = 300000;
			break;
		case "400":
			nam = 400000;
			break;
		}
		if(num1 >= 20000){
			price = nam;
			price *= 0.5;
			frm.b6.value=price;
		}else{
			frm.b6.value=nam;
		}
		return true;
	}
	function check(){
		if(frm.b1.value.trim()==""){
			alert("수강월을 입력하세요!");
			frm.b1.focus();
			return false;
		}
		if(frm.b2.value.trim()==""){
			alert("회원명을 선택하세요!");
			frm.b2.focus();
			return false;
		}
		if(frm.b3.value==""){
			alert("회원번호을 입력하세요!");
			frm.b3.focus();
			return false;
		}
		if(frm.b4.value.trim()==""){
			alert("강의장소을 입력하세요!");
			frm.b4.focus();
			return false;
		}
		if(frm.b5.value==""){
			alert("강의명을 선택하세요!");
			frm.b5.focus();
			return false;
		}
		if(frm.b6.value.trim()==""){
			alert("수강료을 입력하세요!");
			frm.b6.focus();
			return false;
		}
		return true;
	}
	function rreset(){
		alert("모든 정보를 지우고 처음부터 다시 입력합니다!");
		frm.b1.focus();
		return true;
	}
	</script>
</body>
</html>