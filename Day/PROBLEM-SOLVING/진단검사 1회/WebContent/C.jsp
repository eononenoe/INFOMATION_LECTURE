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
		style="position:fixed; top:200px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h3>검사결과조회</h3>
	<br>
	<form
		style="display: flex; justify-content: center; align-items: center;">
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
				String sql = "select p.P_NO,p.P_NAME ,l.T_NAME , r.T_SDATE, r.T_STATUS, r.T_LDATE, r.T_RESULT "
						+ "from TBL_RESULT_202004 r "
						+ "join TBL_LAB_TEST_202004 l on l.T_CODE = r.T_CODE "
						+ "join TBL_PATIENT_202004 p on p.P_NO = r.P_NO ";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);

				try {

					while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("P_NO")%></td>
				<td><%=rs.getString("P_NAME")%></td>
				<td><%=rs.getString("T_NAME")%></td>
				<td><%=rs.getDate("T_SDATE")%></td>
				<%
				String sta = rs.getString("T_STATUS");
				String tus = "";
				switch(sta){
				case "1":
					tus = "검사중";
					break;
				case "2":
					tus = "검사완료";
					break;
				}
				%>
				<td><%=tus%></td>
				<td><%=rs.getDate("T_LDATE")%></td>
				<%
				String res = rs.getString("T_RESULT");
				String ult = "";
				switch(res){
				case "X":
					ult = "미입력";
					break;
				case "P":
					ult = "양성";
					break;
				case "N":
					ult = "음성";
					break;
				}
				%>
				<td><%=ult%></td>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</table>
	</form>

	</div>
	</section>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>