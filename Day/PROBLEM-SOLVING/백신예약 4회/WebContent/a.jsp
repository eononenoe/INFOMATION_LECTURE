<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>a</title>
<style>
td{
text-align: left;
}
.ttd{
text-align: center;
padding: 0 10px;
}
.tttd{
width:152px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>백신예약</h3>
	<br>
	<form name="frm" action="action.jsp" method="get"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td class="ttd">예약번호</td>
				<td><input name="a1"></td>
			</tr>
			<tr>
				<td class="ttd">주민번호</td>
				<td><input name="a2"> ex)790101-11111111</td>
			</tr>
			<tr>
				<td class="ttd">백신코드</td>
				<td>
					<select name="a3" class="tttd">
						<option value="">백신</option>
						<option value="V001">A백신</option>
						<option value="V002">B백신</option>
						<option value="V003">C백신</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="ttd">병원코드</td>
				<td>
					<input type="radio" value="H001" name="a4">가_병원
					<input type="radio" value="H002" name="a4">나_병원
					<input type="radio" value="H003" name="a4">다_병원
					<input type="radio" value="H004" name="a4">라_병원
				</td>
			</tr>
			<tr>
				<td class="ttd">예약날짜</td>
				<td><input name="a5"> ex)20210101</td>
			</tr>
			<tr>
				<td class="ttd">예약시간</td>
				<td><input name="a6"> ex)0930,1130</td>
			</tr>
			<tr>
				<td colspan="2" class="ttd">
					<button type="submit" onclick="return check();">등록</button>
					<button type="reset" onclick="return rreset();">취소</button>
				</td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script>
	function check(){
		if(frm.a1.value.trim()==""){
			alert("예약번호가 입력되지 않았습니다!");
			frm.a1.focus();
			return false;
		}
		if(frm.a2.value.trim()==""){
			alert("주민번호가 입력되지 않았습니다!");
			frm.a2.focus();
			return false;
		}
		if(frm.a3.value==""){
			alert("백신코드가 선택되지 않았습니다!");
			frm.a3.focus();
			return false;
		}
		if(!document.querySelector('input[name="a4"]:checked')){
			alert("병원코드가 입력되지 않았습니다!");
			return false;
		}
		if(frm.a5.value.trim()==""){
			alert("예약날짜가 입력되지 않았습니다!");
			frm.a5.focus();
			return false;
		}
		if(frm.a6.value.trim()==""){
			alert("예약시간가 입력되지 않았습니다!");
			frm.a6.focus();
			return false;
		}
		return true;
	}
	function rreset(){
		alert("모든 정보를 지우고 처음부터 다시 입력합니다!");
		frm.a1.focus();
		return true;
	}
	</script>
</body>
</html>