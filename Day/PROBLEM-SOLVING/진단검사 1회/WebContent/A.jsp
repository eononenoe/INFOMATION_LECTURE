<%@page import="java.sql.*"%>
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
		style="position:fixed; top:200px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h3>환자조회</h3>
	<br>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">

			<tr>
				<td>환자번호</td>
				<td>환자성명</td>
				<td>생년월일</td>
				<td>성별</td>
				<td>전화번호</td>
				<td>지역</td>
			</tr>
			<%
				String sql = "select * from TBL_PATIENT_202004";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);

				try {

					while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("P_NO")%></td>
				<td><%=rs.getString("P_NAME")%></td>
				<%
					String bt = rs.getString("P_BIRTH");
							String br = bt.substring(0, 4) + "년" + bt.substring(4, 6)
									+ "월" + bt.substring(6, 8) + "일";
				%>
				<td><%=br%></td>
				<%
					String gen = rs.getString("P_GENDER");
							String ge = "";
							switch (gen) {
							case "M":
								ge = "남";
								break;
							default:
								ge = "여";
								break;
							}
				%>
				<td><%=ge%></td>
				<%
					String num = rs.getString("P_TEL1") + "-"
									+ rs.getString("P_TEL2") + "-"
									+ rs.getString("P_TEL3");
				%>
				<td><%=num%></td>
				<%
					String ci = rs.getString("P_CITY");
							String ty = "";
							switch (ci) {
							case "10":
								ty = "서울";
								break;
							case "20":
								ty = "경기";
								break;
							case "30":
								ty = "강원";
								break;
							default:
								ty = "대구";
								break;
							}
				%>
				<td><%=ty%></td>
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