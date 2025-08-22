<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>c</title>
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
	<h3>검사결과조회</h3>
	<br>
	<form
		style="display: flex; justify-content: center; align-items: :center;">
		<table border="1">
			<tr>
				<td>환자번호</td>
				<td>환자명</td>
				<td>검사명</td>
				<td>검사시작일</td>
				<td>검사상태</td>
				<td>검사종료일</td>
				<td>검사결과</td>
			</tr>
						<%
			String sql = "select a.P_NO,c.T_NAME,a.T_SDATE,a.T_STATUS,a.T_LDATE,a.T_RESULT,b.P_NAME from TBL_RESULT_202004 a "
						+"join TBL_PATIENT_202004 b on b.P_NO=a.P_NO join TBL_LAB_TEST_202004 c on c.T_CODE=a.T_CODE "
						+"order by a.P_NO";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try{
				while(rs.next()){
					String re = rs.getString("T_RESULT");
					String res = "";
					switch(re){
					case "X":
						res = "미입력";
						break;
					case "P":
						res = "양성";
						break;
					case "N":
						res = "음성";
						break;
					}
					%>
			<tr>
				<td><%=rs.getString("P_NO") %></td>
				<td><%=rs.getString("P_NAME") %></td>
				<td><%=rs.getString("T_NAME") %></td>
				<td><%=rs.getDate("T_SDATE") %></td>
				<td><%=rs.getString("T_STATUS").equals("1")?"검사중":"검사완료" %></td>
				<td><%=rs.getDate("T_LDATE") %></td>
				<td><%=res %></td>
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