<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>d</title>
<style>
td{
width:140px;
}
.ttd{
text-align: right;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>강사매출현황</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>강사코드</td>
				<td>강의명</td>
				<td>강사명</td>
				<td>총매출</td>
			</tr>
						<%
			String sql ="select t.teacher_code, t.class_name , t.teacher_name ,sum(c.tuition) as tsum "  +
					"from TBL_CLASS_202201 c join TBL_TEACHER_202201 t on t.teacher_code = c.teacher_code " +
					"group by t.teacher_code, t.class_name , t.teacher_name";
			
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			try{
				while(rs.next()){
					DecimalFormat df = new DecimalFormat("￦#,###");
			%>
			<tr>
				<td><%=rs.getString("teacher_code") %></td>
				<td><%=rs.getString("class_name") %></td>
				<td class="ttd"><%=rs.getString("teacher_name") %></td>
				<td class="ttd"><%=df.format(rs.getInt("tsum")) %></td>
			</tr>
			<%
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			%>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>