<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>D</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<section
		style="position:fixed; top:200px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h3>(지역별)검사건수통계</h3>
	<br>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>지역코드</td>
				<td>지역별</td>
				<td>검사건수</td>
			</tr>
			<%
				String sql = "select count(p.P_NO) as cntno, p.P_CITY "
						+ "from TBL_RESULT_202004 r "
						+ "join TBL_PATIENT_202004 p on p.P_NO = r.P_NO "
						+ "group by P_CITY";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);

				try {

					while (rs.next()) {
			%>
			<tr>
			<%
			String ci = rs.getString("P_CITY");
			String ty = "";
			switch(ci){
			case "10" :
				ty = "서울";
				break;
			case "20" :
				ty = "경기";
				break;
			case "30" :
				ty = "강원";
				break;
			case "40" :
				ty = "대구";
				break;
				
			}
			%>
				<td><%=rs.getString("P_CITY")%></td>
				<td><%=ty%></td>
				<td><%=rs.getString("cntno")%></td>
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