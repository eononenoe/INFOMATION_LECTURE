<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>a</title>
<style>
td{
text-align:left;
}
.tdd{
text-align:center;
}
.ip{
width:155px;
}


</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h2>백신예약</h2>
	<form name="frm" onsubmit="return check()" action="action.jsp" method="get"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>예약번호</td>
				<td><input name="a1"></td>
			</tr>
			<tr>
				<td>주민번호</td>
				<td><input  name="a2"> ex) 790101-111111</td>
			</tr>
			<tr>
				<td>백신코드</td>
				<td>
					<select class="ip"  name="a3">
						<option value="">백신</option>
						<option value="V001">A백신</option>
						<option value="V002">B백신</option>
						<option value="V003">C백신</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>병원코드</td>
				<td>
				<input type="radio"  name="a4" value="H001">가_병원
				<input type="radio"  name="a4" value="H002">나_병원
				<input type="radio"  name="a4" value="H003">다_병원
				<input type="radio"  name="a4" value="H004">라_병원
				</td>
			</tr>
			<tr>
				<td>예약날짜</td>
				<td><input  name="a5"> ex) 20210101</td>
			</tr>

			<tr>
				<td>예약시간</td>
				<td><input  name="a6"> ex)0930, 1130</td>
			</tr>
			<tr>
				<td colspan="2" class="tdd">
					<button type="submit">등록</button>
					<button type="reset" onclick="return rreset()">취소</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script>
		function check() {
			if(frm.a1.value.trim()==""){
				alert("예약번호를 입력하지 않았습니다");
				frm.a1.focus();
				return false;
			}
			if(frm.a2.value.trim()==""){
				alert("주민번호를 입력하지 않았습니다");
				frm.a2.focus();
				return false;
			}
			if(frm.a3.value.trim()==""){
				alert("백신코드를 입력하지 않았습니다");
				frm.a3.focus();
				return false;
			}
			if(!document.querySelector('input[name="a4"]:checked')){
				alert("병원코드를 입력하지 않았습니다");
				return false;
			}
			if(frm.a5.value.trim()==""){
				alert("예약날짜를 입력하지 않았습니다");
				frm.a5.focus();
				return false;
			}
			if(frm.a6.value.trim()==""){
				alert("예약시간를 입력하지 않았습니다");
				frm.a6.focus();
				return false;
			}
			return true;
		}
		function rreset() {
			alert("모든 정보를 지우고 처음부터 다시 입력합니다!");
			frm.a1.focus();
		}
		
	</script>
</body>
</html>