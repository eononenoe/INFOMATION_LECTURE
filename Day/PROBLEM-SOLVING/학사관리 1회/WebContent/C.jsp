<%@include file="db.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>C</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:200px; left:0px; width:100%; height:100%; text-align:center; background-color:lightgray;">
	<h3>학생성적</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>학년</td>
				<td>반</td>
				<td>번호</td>
				<td>이름</td>
				<td>국어</td>
				<td>수학</td>
				<td>영어</td>
				<td>역사</td>
				<td>합계</td>
				<td>평균</td>
				<td>석차</td>
			</tr>
			<%
				String sql = "SELECT "
						+ "s.sno, s.sname, s.sphone, "
						+ "e.ekor, e.emath, e.eeng, e.ehist, "
						+ "(e.ekor + e.emath + e.eeng + e.ehist) AS ssum, "
						+ "ROUND((e.ekor + e.emath + e.eeng + e.ehist) / 4.0, 1) AS savg "
						+ "FROM student_tbl_01 s "
						+ "LEFT JOIN exam_tbl_01 e ON s.sno = e.sno "
						+ "ORDER BY savg ASC";

				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				int ranks = 1;
				int ks = 0;
				int ms = 0;
				int es = 0;
				int hs = 0;
				int as = 0;
				int ss = 0;
				int cnt = 0;
				try {
					while (rs.next()) {
						cnt++;
			%>
			<tr>
				<%
					String sno = rs.getString("sno");
							String s1 = sno.substring(0, 1);
							String s2 = sno.substring(1, 3);
							String s3 = sno.substring(3, 5);
				%>
				<td><%=s1%></td>
				<td><%=s2%></td>
				<td><%=s3%></td>
				<td><%=rs.getString("sname")%></td>
				<td><%=rs.getObject("ekor") == null ? "" : rs
							.getInt("ekor")%></td>
				<td><%=rs.getObject("emath") == null ? "" : rs
							.getInt("emath")%></td>
				<td><%=rs.getObject("eeng") == null ? "" : rs
							.getInt("eeng")%></td>
				<td><%=rs.getObject("ehist") == null ? "" : rs
							.getInt("ehist")%></td>
				<td><%=rs.getObject("ssum") == null ? "" : rs
							.getInt("ssum")%></td>
				<td><%=rs.getObject("savg") == null ? "" : rs
							.getFloat("savg")%></td>
				<td><%=rs.getObject("ssum") == null ? "" : ranks++%></td>
			</tr>
			<%
				ks += rs.getInt("ekor");
						ms += rs.getInt("emath");
						es += rs.getInt("eeng");
						hs += rs.getInt("ehist");
						ss += rs.getInt("ssum");
						as += rs.getFloat("savg");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<tr>
				<td colspan="4">총합</td>
				<td><%=ks%></td>
				<td><%=ms%></td>
				<td><%=es%></td>
				<td><%=hs%></td>
				<td><%=ss%></td>
				<td><%=as%></td>
				<td></td>
			<tr>
			<tr>
				<td colspan="4">총평균</td>
				<td><%=((ks * 1.0) / cnt) % 1 == 0 ? (int) ((ks * 1.0) / cnt)
					: String.format("%.1f", (ks * 1.0) / cnt)%></td>
				<td><%=((ms * 1.0) / cnt) % 1 == 0 ? (int) ((ms * 1.0) / cnt)
					: String.format("%.1f", (ms * 1.0) / cnt)%></td>
				<td><%=((es * 1.0) / cnt) % 1 == 0 ? (int) ((es * 1.0) / cnt)
					: String.format("%.1f", (es * 1.0) / cnt)%></td>
				<td><%=((hs * 1.0) / cnt) % 1 == 0 ? (int) ((hs * 1.0) / cnt)
					: String.format("%.1f", (hs * 1.0) / cnt)%></td>
				<td><%=((ss * 1.0) / cnt) % 1 == 0 ? (int) ((ss * 1.0) / cnt)
					: String.format("%.1f", (ss * 1.0) / cnt)%></td>
				<td><%=((as * 1.0) / cnt) % 1 == 0 ? (int) ((as * 1.0) / cnt)
					: String.format("%.1f", (as * 1.0) / cnt)%></td>
					<td></td>
			<tr>
		</table>
	</form>
	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>