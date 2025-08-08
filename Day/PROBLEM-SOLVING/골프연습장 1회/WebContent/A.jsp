<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>A</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:200px;left:0px; width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>강사조회</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>강사코드</td>
				<td>강사명</td>
				<td>강의명</td>
				<td>수강료</td>
				<td>강사자격취득일</td>
			</tr>
			<%
			String sql = "select * from TBL_TEACHER_202201";
			Statement stmt = con.createStatement(); 
			ResultSet rs = stmt.executeQuery(sql);
			
			try{
				while(rs.next()){
				%>
			<tr>
				<td><%=rs.getString("teacher_code")%></td>
				<td><%=rs.getString("teacher_name") %></td>
				<td><%=rs.getString("class_name") %></td>
				<%
				int price = rs.getInt("class_price");
				DecimalFormat df = new DecimalFormat("￦#,###");
				%>
				<td><%=df.format(price)%></td>
				<%
				String dt = rs.getString("teach_resist_date");
				String teach = dt.substring(0,4) + "년" + dt.substring(4,6) +"월"+ dt.substring(6,8) + "일";
				%>
				<td><%=teach%></td>
			</tr>
			<%
			}
			}catch(Exception e ){
				e.printStackTrace();
			}
			%>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>