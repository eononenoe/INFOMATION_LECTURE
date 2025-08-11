<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section   style="position:fixed; top:150px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h2>백신예약조회</h2>
	<form action="b2.jsp"; method="get";
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>예약번호</td>
				<td><input name="resvno"></td>
			<tr>
				<td colspan="2">
					<button type="submit">조회하기</button>
					<button type="button" onclick="window.location.href = 'main.jsp'">홈으로</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>