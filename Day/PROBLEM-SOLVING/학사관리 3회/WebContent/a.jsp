<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>a</title>
<style>
td{
padding: 0 10px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>학생목록</h3>
	<br>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>학번</td>
				<td>이름</td>
				<td>학년</td>
				<td>반</td>
				<td>번호</td>
				<td>성별</td>
				<td>전화번호</td>
				<td>주소</td>
			</tr>
			<%
			String sql = "select * from student_tbl_01";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try{
				while(rs.next()){
					%>
			<tr>
				<td><%=rs.getString("SNO") %></td>
				<td><%=rs.getString("SNAME") %></td>
				<td><%=rs.getString("SNO").substring(0,1) %></td>
				<td><%=rs.getString("SNO").substring(1,3) %></td>
				<td><%=rs.getString("SNO"). substring(3,5)%></td>
				<td><%=rs.getString("SGENDER").equals("M")?"남":"여" %></td>
				<td><%=rs.getString("SPHONE") %></td>
				<td><%=rs.getString("SADDRESS") %></td>
			</tr>
				<%
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			%>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>