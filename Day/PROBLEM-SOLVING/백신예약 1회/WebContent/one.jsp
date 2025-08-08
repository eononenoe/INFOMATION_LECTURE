<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>one</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%; height:100%; background-color:gray; text-align:center;">
	<h2>백신예약</h2>
	<form onsubmit="return check(this)" action="insert.jsp" method="post"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>예약번호</td>
				<td style="text-align: left;"><input name="an"></td>
			</tr>
			<tr>
				<td>주민번호</td>
				<td style="text-align: left;"><input name="bn">
					ex)790101-11111111</td>
			</tr>
			<tr>
				<td>백신코드</td>
				<td style="text-align: left;"><select style="width: 153px;"
					name="vc">
						<option value="V001">A백신</option>
						<option value="V002">B백신</option>
						<option value="V003">C백신</option>
				</select></td>
			</tr>
			<tr>
				<td>병원코드</td>
				<td><input type="radio" name="hc" value="H001">가_병원 <input
					type="radio" name="hc" value="H002">나_병원 <input
					type="radio" name="hc" value="H003">다_병원 <input
					type="radio" name="hc" value="H004">라_병원</td>
			</tr>
			<tr>
				<td>예약날짜</td>
				<td style="text-align: left;"><input name="dt">
					ex)20210101</td>
			</tr>
			<tr>
				<td>예약시간</td>
				<td style="text-align: left;"><input name="tm">
					ex)0930, 1130</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">등록</button>
					<button type="button" onclick="reset(this.form)">취소</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
		function check(form) {
			if (form.an.value.trim() == "") {
				alert("예약번호를 입력하세요.");
				form.an.focus();
				return false;
			}
			if (form.bn.value.trim() == "") {
				alert("주민번호를 입력하세요.");
				form.bn.focus();
				return false;
			}
			if (form.vc.value == "") {
				alert("백신코드를 입력하세요.");
				form.vc.focus();
				return false;
			}
			if (!document.querySelector('input[name="hc"]:checked')) {
				alert("병원코드를 입력하세요.");
				return false;
			}
			if (form.dt.value.trim() == "") {
				alert("예약날짜를 입력하세요.");
				form.dt.focus();
				return false;
			}
			if (form.tm.value.trim() == "") {
				alert("예약시간를 입력하세요.");
				form.tm.focus();
				return false;
			}
		}
		function reset(form) {
			form.reset();
			form.bn.focus();
		}
	</script>
</body>
</html>