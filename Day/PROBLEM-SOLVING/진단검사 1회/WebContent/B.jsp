<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>B</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<section
		style="position:fixed; top:200px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h3>검사결과입력</h3>
	<br>
	<form onsubmit="return check(this)" action="action.jsp" method="post"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>환자번호</td>
				<td style="text-align: left;"><input name="b1"> 예)1001</td>
			</tr>
			<tr>
				<td>검사코드</td>
				<td style="text-align: left;"><select name="b2">
						<option value="">검사명</option>
						<option value="T001">[T001]결핵</option>
						<option value="T002">[T002]장티푸스</option>
						<option value="T003">[T003]수두</option>
						<option value="T004">[T004]홍역</option>
						<option value="T005">[T005]콜레라</option>
				</select></td>
			</tr>
			<tr>
				<td>검사시작일자</td>
				<td><input name="b3"> 예)20200101</td>
			</tr>
			<tr>
				<td>검사상태</td>
				<td><input type="radio" name="b4" value="1">검사중 <input
					type="radio" name="b4" value="2">검사완료</td>
			</tr>
			<tr>
				<td>검사완료일자</td>
				<td><input name="b5"> 예)20200101</td>
			</tr>
			<tr>
				<td>검사결과</td>
				<td><input type="radio" name="b6" value="X">미입력 <input
					type="radio" name="b6" value="P">양성<input type="radio" name="b6" value="N">음성</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">검사결과등록</button>
					<button type="button" onclick="return resetForm(this)">다시쓰기</button>
				</td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>

	<script>
		function check(form) {
			if (form.b1.value == "") {
				alert("환자번호가 입력되지 않았습니다!");
				form.b1.focus();
				return false;
			}
			if (form.b2.value == "") {
				alert("검사코드가 선택되지 않았습니다!");
				form.b2.focus();
				return false;
			}
			if (form.b3.value.trim() == "") {
				alert("검사시작일자가 입력되지 않았습니다!");
				form.b3.focus();
				return false;
			}
			if (!document.querySelector("input[name='b4']:checked")) {
				alert("검사상태가 입력되지 않았습니다!");
				form.b4.focus();
				return false;
			}
			if (form.b5.value.trim() == "") {
				alert("검사완료일자가 입력되지 않았습니다!");
				form.b5.focus();
				return false;
			}
			if (!document.querySelector("input[name='b6']:checked")) {
				alert("검사결과가 입력되지 않았습니다!");
				form.b6.focus();
				return false;
			}
		}
		function resetForm() {
			alert("정보를 지우고 처음부터 다시 입력 합니다!");
			form.reset();
			return false;
		}

	</script>
</body>
</html>