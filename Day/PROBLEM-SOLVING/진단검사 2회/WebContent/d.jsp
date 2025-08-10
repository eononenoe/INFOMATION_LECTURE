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
padding-left: 10px;
padding-right: 10px;
}

</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%;height:100%; text-align:center; background-color:lightgray;">
	<h3>(지역별)검사건수통계</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>지역코드</td>
				<td>지역명</td>
				<td>검사건수</td>
			</tr>
			<%
				String sql = "select a.P_CITY,count(b.P_NO) as pcnt from TBL_PATIENT_202004 a "+
							"join TBL_RESULT_202004 b on b.P_NO = a.P_NO "+
							"group by a.P_CITY";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				try {
					while (rs.next()) {
						String ci = rs.getString("P_CITY");
						String cit = "";
						switch (ci) {
						case "10":
							cit = "서울";
							break;
						case "20":
							cit = "경기";
							break;
						case "30":
							cit = "강원";
							break;
						case "40":
							cit = "대구";
							break;
						}
			%>
			<tr>
				<td><%=rs.getString("P_CITY") %></td>
				<td><%=cit %></td>
				<td><%=rs.getInt("pcnt") %></td>
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