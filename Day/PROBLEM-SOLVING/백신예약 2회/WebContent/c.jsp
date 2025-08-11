<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>c</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%; height:100%; background-color:lightgray; text-align:center;">
	<h2>백신예약현황</h2>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>예약번호</td>
				<td>병원지역명</td>
				<td>접종예약건수</td>
			<tr>
				<%
					String sql = "select h.hospaddr, count(v.hospcode) as hct " +
							"from tbl_hosp_202109 h " +
							"left join tbl_vaccresv_202109 v on h.hospcode = v.hospcode " +
							"group by h.hospaddr";
				
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					int total = 0;

					try {
						while (rs.next()) {
				%>
			
			<tr>
			<%
			String ar = rs.getString("hospaddr");
			int count = rs.getInt("hct");
			total += count;
			String dr = "";
			switch (ar) {
			case "10" : 
				dr = "서울";
				break;
			case "20" : 
				dr = "대전";
				break;
			case "30" : 
				dr = "대구";
				break;
			case "40" : 
				dr = "광주";
				break;
			}
					
			%>
				<td><%= rs.getString("hospaddr")%></td>
				<td><%= dr%></td>
				<td><%= rs.getInt("hct")%></td>
				
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
			<tr>
		</table>
	</form>
	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>