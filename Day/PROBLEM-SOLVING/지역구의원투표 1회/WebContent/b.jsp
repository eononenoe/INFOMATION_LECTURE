<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b</title>
<style>
td {
	padding: 5px 10px;
	text-align: left;
}

.ttd {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>투표하기</h3>
	<form name="frm" action="action.jsp" method="get"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td class="ttd">주민번호</td>
				<td><input name="b1"> 예 : 8906153154726</td>
			</tr>
			<tr>
				<td class="ttd">성명</td>
				<td><input name="b2"></td>
			</tr>
			<tr>
				<td class="ttd">투표번호</td>
				<td><select name="b3">
						<option value=""></option>
						<option value="1">[1] 김후보</option>
						<option value="2">[2] 이후보</option>
						<option value="3">[3] 박후보</option>
						<option value="4">[4] 조후보</option>
						<option value="5">[5] 최후보</option>
				</select></td>
			</tr>
			<tr>
				<td class="ttd">투표시간</td>
				<td><input name="b4"></td>
			</tr>
			<tr>
				<td class="ttd">투표장소</td>
				<td><input name="b5"></td>
			</tr>
			<tr>
				<td class="ttd">유권자확인</td>
				<td><input type="radio" value="Y" name="b6">확인 <input
					type="radio" value="N" name="b6">미확인</td>
			</tr>
			<tr>
				<td colspan="2" class="ttd">
					<button type="submit" onclick="return check();">투표하기</button>
					<button type="reset" onclick="return rreset();">다시하기</button>
				</td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>

	<script>
		function check() {
			if (frm.b1.value.trim() == "") {
				alert("주빈번호가 입력되지 않았습니다!");
				frm.b1.focus();
				return false;
			}
			if (frm.b2.value.trim() == "") {
				alert("성명이 입력되지 않았습니다!");
				frm.b2.focus();
				return false;
			}
			if (frm.b3.value == "") {
				alert("후보번호가 선택되지 않았습니다!");
				frm.b3.focus();
				return false;
			}
			if (frm.b4.value.trim() == "") {
				alert("투표시간이 입력되지 않았습니다!");
				frm.b4.focus();
				return false;
			}
			if (frm.b5.value.trim() == "") {
				alert("투표장소가 입력되지 않았습니다!");
				frm.b5.focus();
				return false;
			}
			if (!document.querySelector('input[name="b6"]:checked')) {
				alert("유권자확인가 선택되지 않았습니다!");
				return false;
			}
			
			return true;
		}
		function rreset() {
			alert("정보를 지우고 처음부터 다시 입력합니다!");
			frm.b1.focus();
			return true;
		}
	</script>
</body>
</html>