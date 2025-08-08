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
		style="position:fixed; top:200px; left:0px; width:100%; height:100%; text-align:center; background-color:lightgray;">
	<h3>성적입력</h3>
	<form onsubmit="return check(this)";  action="action.jsp"; method="post";
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input name="b1"></td>
			</tr>
			<tr>
				<td>국어점수</td>
				<td><input  name="b2"></td>
			</tr>
			<tr>
				<td>수학점수</td>
				<td><input name="b3"></td>
			</tr>
			<tr>
				<td>영어점수</td>
				<td><input  name="b4"></td>
			</tr>
			<tr>
				<td>역사점수</td>
				<td><input  name="b5"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">등록하기</button></td>
			</tr>
		</table>
	</form>
	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
		function check(form){
			if(form.b1.value.trim()==""){
				alert("학번을 입력하지 않았습니다!");
				form.b1.focus();
				return false;
			}
			if(form.b2.value.trim()==""){
				alert("국어점수을 입력하지 않았습니다!");
				form.b2.focus();
				return false;
			}
			if(form.b3.value.trim()==""){
				alert("수학점수을 입력하지 않았습니다!");
				form.b3.focus();
				return false;
			}
			if(form.b4.value.trim()==""){
				alert("영어점수을 입력하지 않았습니다!");
				form.b4.focus();
				return false;
			}
			if(form.b5.value.trim()==""){
				alert("역사을 입력하지 않았습니다!");
				form.b5.focus();
				return false;
			}	
			return true;
		}
		
	</script>
</body>
</html>