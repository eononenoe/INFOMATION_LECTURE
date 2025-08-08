<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>three</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%; height:100%; background-color:gray; text-align:center;">
	<h2>백신예약현황</h2>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>병원지역</td>
				<td>병원지역명</td>
				<td>접종에약건수</td>
			</tr>
			<%
				ResultSet rs = null;
				Statement stmt = null;
				int total = 0;

				try {
					String sql = "SELECT  h.hospcode,h.hospaddr, NVL(COUNT(r.jumin), 0) AS ct "
							+ "FROM tbl_hosp_202109 h "
							+ "LEFT JOIN tbl_vaccresv_202109 r ON h.hospcode = r.hospcode "
							+ "GROUP BY h.hospcode, h.hospaddr";
					stmt = con.createStatement();
					rs = stmt.executeQuery(sql);

					while (rs.next()) {
						String hd = rs.getString("hospaddr");
						String hs = rs.getString("hospcode");
						int cnt = rs.getInt("ct");
						total += cnt;
			%>

			<tr>
				<td><%=hd%></td>
				<td>
					<%
						String hn = "";
								switch (hs) {
								case "H001":
									hn = "서울";
									break;
								case "H002":
									hn = "대전";
									break;
								case "H003":
									hn = "대구";
									break;
								case "H004":
									hn = "광주";
									break;
								default :
									hn = "없음";
									break;
								}
					%> <%=hn%></td>
				<td><%=cnt%></td>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<tr>
				<td colspan="2">총합</td>
				<td><%=total %></td>
			</tr>
		</table>
	</form>
	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>