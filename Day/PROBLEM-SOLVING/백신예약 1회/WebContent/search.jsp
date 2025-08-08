<%@page import="com.sun.glass.ui.Pixels.Format"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>search</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<section
		style="position:fixed; top:150px; left:0px; width:100%; height:100%; background-color:gray; text-align:center;">
	<%
		String r = request.getParameter("resvno");
		ResultSet rs = null;
		PreparedStatement pstmt = null;

		String sql = "select v.resvno, j.name, j.jumin, h.hospname, v.resvdate, v.resvtime, v.vcode, h.hospaddr "
				+ "from tbl_vaccresv_202109 v "
				+ "join tbl_jumin_202109 j on v.jumin = j.jumin "
				+ "join tbl_hosp_202109 h on v.hospcode = h.hospcode "
				+ "where v.resvno = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(r));
		rs = pstmt.executeQuery();

		if (rs.next()) {
	%>
	<h3>
		예약번호
		<%=r%>님의 예약조회
	</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">

			<tr>
				<td>예약번호</td>
				<td>성명</td>
				<td>성별</td>
				<td>병원이름</td>
				<td>예약날짜</td>
				<td>예약시간</td>
				<td>백신코드</td>
				<td>병원지역</td>
			</tr>
			<tr>
				<td><%=rs.getString("resvno")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("jumin").charAt(7) % 2 == 1 ? "남" : "여"%></td>
				<td><%=rs.getString("hospname")%></td>
				<td>
					<%
						String date = rs.getString("resvdate");
							String dt = "";
							dt = date.substring(0, 4) + "년" + date.substring(5, 7) + "월"
									+ date.substring(8, 10) + "일";
					%> <%=dt%>
				</td>
				<td>
					<%
						int time = rs.getInt("resvtime");
							String tm = String.format("%02d:%02d", time / 100, time % 100);
					%> <%=tm%></td>
				<td>
					<%
						String vcode = rs.getString("vcode");
							String vc = "";
							switch (vcode) {
							case "V001":
								vc = "A백신";
								break;
							case "V002":
								vc = "B백신";
								break;
							case "V003":
								vc = "C백신";
								break;
							default:
								break;
							}
					%> <%=vc%></td>
				<td>
					<%
						String addr = rs.getString("hospaddr");
							String ad = "";
							switch (addr) {
							case "10":
								ad = "서울";
								break;
							case "20":
								ad = "대전";
								break;
							case "30":
								ad = "대구";
								break;
							case "40":
								ad = "광주";
								break;
							default:
								break;
							}
					%> <%=ad%></td>
			</tr>
		</table>
	</form>
	<br>
	<button type="button" onclick="location.href='two.jsp'">돌아가기</button>
	<%
		} else {
	%>
	</table>
	</form>
	<br>
	<h3>
		예약번호 &nbsp;<%=r%>
		&nbsp;에 대한 조회 결과가 없습니다.
	</h3>
	<br>
	<button type="button" onclick="location.href='index.jsp'">홈으로</button>
	<%
		}
	%>

	</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>