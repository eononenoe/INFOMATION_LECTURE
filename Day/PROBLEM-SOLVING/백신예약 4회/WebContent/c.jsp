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
	<h3>백신예약현황</h3>
	<br>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>병원지역</td>
				<td>병원지역명</td>
				<td>접종예약건수</td>
			</tr>
			<%
				String sql = "select a.hospaddr ,count(a.hospcode)as hcnt "
						+ "from tbl_hosp_202109 a left join tbl_vaccresv_202109 b on a.hospcode=b.hospcode "
						+ "group by a.hospaddr";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				int total = 0;
				
				
				try {
					while (rs.next()) {
						total += rs.getInt("hcnt");
						
						String ho = rs.getString("hospaddr");
						String hos = "";
						switch(ho){
						case "10":
							hos = "서울";
							break;
						case "20":
							hos = "대전";
							break;
						case "30":
							hos = "대구";
							break;
						case "40":
							hos = "광주";
							break;
						}
			%>
			<tr>
				<td><%=rs.getString("hospaddr")%></td>
				<td><%=hos%></td>
				<td><%=rs.getInt("hcnt")%></td>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<tr>
				<td colspan="2">총합</td>
				<td><%=total%></td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>