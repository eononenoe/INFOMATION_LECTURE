<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>C</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:200px;left:0px; width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>회원정보조회</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>수강월</td>
				<td>회원번호</td>
				<td>회원명</td>
				<td>강의명</td>
				<td>강의장소</td>
				<td>수강료</td>
				<td>등급</td>
			</tr>
			<%
				String sql = "select c.resist_month, c.C_NO, m.C_NAME, t.CLASS_NAME, c.CLASS_AREA, c.TUITION, m.GRADE " +
						"from TBL_CLASS_202201 c " +
						"join TBL_MEMBER_202201 m on  m.c_no = c.c_no " +
						"join TBL_TEACHER_202201 t on t.teacher_code = c.teacher_code";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);

				try {
					while (rs.next()) {
			%>
			<tr>
			<%
			String c1 = rs.getString("resist_month");
			int price = rs.getInt("TUITION");
			DecimalFormat df = new DecimalFormat("￦#,###");
			
			%>
				<td><%=c1.substring(0,4)+"년"+c1.substring(4,6)+"월"%></td>
				<td><%=rs.getString("C_NO")%></td>
				<td><%=rs.getString("C_NAME")%></td>
				<td><%=rs.getString("CLASS_NAME")%></td>
				<td><%=rs.getString("CLASS_AREA")%></td>
				<td><%=df.format(price)%></td>
				<td><%=rs.getString("GRADE")%></td>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>