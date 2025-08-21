<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>c</title>
<style>
td {
	padding: 0 5px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>학생성적</h3>
	<br>
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
				DecimalFormat df = new DecimalFormat("0.#");
				String sql = "select a.SNO,a.SNAME,b.EKOR,b.EMATH,b.EENG,b.EHIST, "
						+ "(b.EKOR+b.EMATH+b.EENG+b.EHIST)as score ,(b.EKOR+b.EMATH+b.EENG+b.EHIST)/4.0 as savg "
						+ "from exam_tbl_01 b right join student_tbl_01 a on b.SNO = a.SNO "
						+ "order by sno ,savg desc";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);

				int rank = 0;
				int skor = 0;
				int smat = 0;
				int seng = 0;
				int shis = 0;
				int ssum = 0;
				int ssav = 0;
				try {
					while (rs.next()) {
						if (rs.getObject("EKOR") != null) {
							rank += 1;
							skor += rs.getInt("EKOR");
							smat += rs.getInt("EMATH");
							seng += rs.getInt("EENG");
							shis += rs.getInt("EHIST");
							ssum += rs.getInt("score");
							ssav += rs.getDouble("savg");
						}
			%>
			<tr>
				<td><%=rs.getString("SNO").substring(0, 1)%></td>
				<td><%=rs.getString("SNO").substring(1, 3)%></td>
				<td><%=rs.getString("SNO").substring(3, 5)%></td>
				<td><%=rs.getString("SNAME")%></td>
				<td><%=rs.getObject("EKOR") != null ? rs.getInt("EKOR")
							: ""%></td>
				<td><%=rs.getObject("EMATH") != null ? rs
							.getInt("EMATH") : ""%></td>
				<td><%=rs.getObject("EENG") != null ? rs.getInt("EENG")
							: ""%></td>
				<td><%=rs.getObject("EHIST") != null ? rs
							.getInt("EHIST") : ""%></td>
				<td><%=rs.getObject("EHIST") != null ? rs
							.getInt("score") : ""%></td>
				<td><%=rs.getObject("EHIST") != null ? rs.getDouble("savg")
							: ""%></td>
				<td><%=rs.getObject("EHIST") != null ? rank : ""%></td>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<tr>
				<td colspan="4">총&nbsp;합</td>
				<td><%=skor%></td>
				<td><%=smat%></td>
				<td><%=seng%></td>
				<td><%=shis%></td>
				<td><%=ssum%></td>
				<td><%=ssav%></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="4">총평균</td>
				<td><%=df.format(skor/(double)rank)%></td>
				<td><%=df.format(smat/(double)rank)%></td>
				<td><%=df.format(seng/(double)rank)%></td>
				<td><%=df.format(shis/(double)rank)%></td>
				<td><%=df.format(ssum/(double)rank)%></td>
				<td><%=df.format(ssav/(double)rank)%></td>
				<td></td>
			</tr>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>