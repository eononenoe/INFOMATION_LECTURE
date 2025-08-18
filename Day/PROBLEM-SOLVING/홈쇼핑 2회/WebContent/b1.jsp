<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="db.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b1</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>홈쇼핑 회원 수정</h3>
	<br>
	<form name="frm" action="bction.jsp" method="get"
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
		<%
		request.setCharacterEncoding("UTF-8");
		String b1 = request.getParameter("custno");
		String sql ="select * from member_tbl_02 where custno = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(b1));
		ResultSet rs = pstmt.executeQuery();
		try{
			if(rs.next()){
				%>
			<tr>
				<td>회원번호(자동발생)</td>
				<td><input readonly="readonly" name="a1" value=<%=rs.getInt("custno")%>></td>
			</tr>
			<tr>
				<td>회원성명</td>
				<td><input name="a2" value=<%=rs.getString("custname")%>></td>
			</tr>
			<tr>
				<td>회원전화</td>
				<td><input name="a3"  value=<%=rs.getString("phone")%>></td>
			</tr>
			<tr>
				<td>회원주소</td>
				<td><input name="a4" value=<%=rs.getString("address")%>></td>
			</tr>
			<tr>
				<td>가입일자</td>
				<td><input name="a5" value=<%=rs.getString("joindate")%>></td>
			</tr>
			<tr>
				<td>고객등급 [A:VIP,B:일반,C:직원]</td>
				<td><input name="a6" value=<%=rs.getString("grade")%>></td>
			</tr>
			<tr>
				<td>도시코드</td>
				<td><input name="a7" value=<%=rs.getString("city")%>></td>
			</tr>
					<%
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		%>
			<tr>
				<td colspan="2">
				<button type="submit" onclick="return check();">수정</button>
				<button type="button" onclick="window.location.href = 'b.jsp'">조회</button>
				</td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script>
	function check(){
		if(frm.a1.value.trim()==""){
			alert("회원정보가 입력되지 않았습니다!");
			frm.a1.focus();
			return false;
		}
		if(frm.a2.value.trim()==""){
			alert("회원성명이 입력되지 않았습니다!");
			frm.a2.focus();
			return false;
		}
		if(frm.a3.value.trim()==""){
			alert("회원전화가 입력되지 않았습니다!");
			frm.a3.focus();
			return false;
		}
		if(frm.a4.value.trim()==""){
			alert("회원주소가 입력되지 않았습니다!");
			frm.a4.focus();
			return false;
		}
		if(frm.a5.value.trim()==""){
			alert("가입일자가 입력되지 않았습니다!");
			frm.a5.focus();
			return false;
		}
		if(frm.a6.value.trim()==""){
			alert("고객등급이 입력되지 않았습니다!");
			frm.a6.focus();
			return false;
		}
		if(frm.a7.value.trim()==""){
			alert("도시코드가 입력되지 않았습니다!");
			frm.a7.focus();
			return false;
		}
		return true;
	}
	</script>
</body>
</html>