<%@page import="java.text.DecimalFormat"%>
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
		style="position:fixed; top:150px;left:0px;width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>학사관리 프로그램</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<%
				int rank = 1;
				int total = 0;
				int tkor = 0;
				int tmath = 0;
				int teng = 0;
				int thist = 0;
				int cnt = 0;
				int tavg= 0;

				String sql = "select s.sno, s.sname, e.ekor, e.emath, e.eeng, e.ehist, "
						+ "(e.ekor + e.emath + e.eeng + e.ehist) AS ssum, ROUND((e.ekor + e.emath + e.eeng + e.ehist) / 4,2) AS savg "
						+ "from student_tbl_01 s left join exam_tbl_01 e on e.sno = s.sno";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				
				DecimalFormat df = new DecimalFormat("0.0");
			%>
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
				try {
					while (rs.next()) {
						if(rs.getObject("ekor") != null){
							cnt++;
						}
			%>

			<tr>
				<td><%=rs.getString("sno").substring(0, 1)%></td>
				<td><%=rs.getString("sno").substring(1, 3)%></td>
				<td><%=rs.getString("sno").substring(3, 5)%></td>
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
							.getDouble("savg")%></td>
				<td><%=rs.getObject("ekor") == null ? "" : rank%></td>
			</tr>
			<%
				rank += 1;
						tkor += rs.getInt("ekor");
						tmath += rs.getInt("emath");
						teng += rs.getInt("eeng");
						thist += rs.getInt("ehist");
						total += rs.getInt("ssum");
						tavg += rs.getDouble("savg");

					}
			%>
			<tr>
				<td colspan="4">총합</td>
				<td><%=tkor%></td>
				<td><%=tmath%></td>
				<td><%=teng%></td>
				<td><%=thist%></td>
				<td><%=total%></td>
				<td><%=tavg%></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="4">총평균</td>
				<td><%=df.format(tkor / cnt)%></td>
				<td><%=df.format(tmath / cnt)%></td>
				<td><%=df.format(teng / cnt)%></td>
				<td><%=df.format(thist / cnt)%></td>
				<td><%=total / cnt%></td>
				<td><%=df.format(tavg / cnt)%></td>
				<td></td>
			</tr>
			<%
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