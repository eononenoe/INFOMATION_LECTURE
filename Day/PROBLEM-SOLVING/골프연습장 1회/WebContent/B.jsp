<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>B</title>
<style>
.td1{
text-align:left;
}
input{
width:150px;
text-align:left;
}
select{
width:150px;
text-align:left;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:200px;left:0px; width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>수강신청</h3>
	<form name="frm"; action="action.jsp"; method="post"; onsubmit="return check()";
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>수강월</td>
				<td><input class="td1" name="b1">예)2022년03월→ 202203</td>
			</tr>
			<tr>
				<td>회원명</td>
				<td  class="td1"><select name="c_name" onchange="fn_change1()">
						<option value="">회원명</option>
						<option value="10001">홍길동</option>
						<option value="10002">장발장</option>
						<option value="10003">임꺽정</option>
						<option value="20001">성춘향</option>
						<option value="20002">이몽룡</option>
				</select></td>
			</tr>
			<tr>
				<td>회원번호</td>
				<td  class="td1"><input name="c_no" readonly="readonly">예)10001</td>
			</tr>
			<tr>
				<td>강의장소</td>
				<td  class="td1"><input  name="b4"></td>
			</tr>
			<tr>
				<td>강의명</td>
				<td  class="td1"><select  name="teacher_code" onchange="fn_change2()">
						<option value="">강의신청</option>
						<option value="100">초급반</option>
						<option value="200">중급반</option>
						<option value="300">고급반</option>
						<option value="400">심화반</option>
				</select></td>
			</tr>
			<tr>
				<td>수강료</td>
				<td  class="td1"><input name="tuition" readonly>원</td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">수강신청</button>
					<button type="button" onclick="return frmreset()">다시쓰기</button></td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
		function fn_change1() {
			var fn = document.frm;

			//수강료 초기화
			fn.tuition.value = "";
			//강의 셀렉트박스 초기화
			fn.teacher_code.options[0].selected = true;
			//회원번호 넣어주기
			fn.c_no.value = fn.c_name.value;
		}
		function fn_change2() {
			var fn = document.frm;
			var teacherCode = parseInt(fn.teacher_code.value);
			var c_no = parseInt(fn.c_no.value);
			var prcie = 0;
			
			 switch (teacherCode) {
		        case 100:
		            price = 100000; // 초급반
		            break;
		        case 200:
		            price = 200000; // 중급반
		            break;
		        case 300:
		            price = 300000; // 고급반
		            break;
		        case 400:
		            price = 400000; // 심화반
		            break;
		        default:
		            price = 0;
		    }

			if(c_no >= 20000) {
				price *= 0.5;
			}
			fn.tuition.value = price;
		}
		function check() {
			if(frm.b1.value.trim()==""){
				alert("수강월을 입력하지 않았습니다");
				frm.b1.focus();
				return false;
			}
			if(frm.c_name.value==""){
				alert("회원명을 입력하지 않았습니다");
				frm.c_name.focus();
				return false;
			}
			if(frm.c_no.value.trim()==""){
				alert("회원번호을 입력하지 않았습니다");
				frm.c_no.focus();
				return false;
			}
			if(frm.b4.value.trim()==""){
				alert("강의장소을 입력하지 않았습니다");
				frm.b4.focus();
				return false;
			}
			if(frm.teacher_code.value==""){
				alert("강의명을 선택하지 않았습니다");
				frm.teacher_code.focus();
				return false;
			}
			if(frm.tuition.value.trim()==""){
				alert("수강료을 입력하지 않았습니다");
				frm.tuition.focus();
				return false;
			}
		}
		function frmreset() {
			alert("모든 정보를 지우고 처음부터 다시 입력합니다!");
			frm.reset();
			frm.b1.focus();
		}
		
	</script>
</body>
</html>