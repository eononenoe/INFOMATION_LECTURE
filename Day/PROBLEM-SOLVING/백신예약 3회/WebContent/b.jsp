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
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>백신예약 프로그램</h3>
	<form name="frm" action="bction.jsp" method="get" 
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>예약번호</td>
				<td><input name="b1"></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit" onclick="return check();">조회하기</button>
					<button type="button" onclick="window.location.href = 'main.jsp'">홈으로</button>
				</td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script>
		function check(){
			if(frm.b1.value.trim()==""){
				alert("예약번호를 입력하세요!");
				frm.b1.focus();
				return false;
			}
			return true;		
		}
	</script>
</body>
</html>