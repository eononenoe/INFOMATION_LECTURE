<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>c</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>백신예약 프로그램</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>병원지역</td>
				<td>병원지역명</td>
				<td>접종예약건수</td>
			</tr>
			<%
				String sql = "select h.hospaddr , count(v.hospcode) as hct "
						+ "from tbl_hosp_202109 h left join  tbl_vaccresv_202109 v on v.hospcode = h.hospcode "
						+ "group by h.hospaddr";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				int cnt = 0;
				try {
					while (rs.next()) {
			%>

			<tr>
				<%
					String ad = rs.getString("hospaddr");
							String add = "";
							switch (ad) {
							case "10":
								add = "서울";
								break;
							case "20":
								add = "대전";
								break;
							case "30":
								add = "대구";
								break;
							case "40":
								add = "광주";
								break;
							}
				%>
				<td><%=rs.getString("hospaddr")%></td>
				<td><%=add%></td>
				<td><%=rs.getInt("hct")%></td>
			</tr>

			<%
				cnt += rs.getInt("hct");
					}
			%>
			<tr>
				<td colspan="2">총합</td>
				<td><%=cnt%></td>
			</tr>
			<%
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