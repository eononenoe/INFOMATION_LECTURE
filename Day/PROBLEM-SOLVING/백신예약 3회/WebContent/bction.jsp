<%@page import="com.sun.glass.ui.Pixels.Format"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bction</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<%
		String b1 = request.getParameter("b1");
		String sql = "select b.resvno,a.name,b.jumin,b.hospcode,b.resvdate,b.resvtime,b.vcode,c.hospaddr "
				+ "from tbl_vaccresv_202109 b "
				+ "join tbl_hosp_202109 c on c.hospcode = b.hospcode "
				+ "join tbl_jumin_202109 a on a.jumin = b.jumin "
				+ "where resvno = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(b1));
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
	%>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>
		예약번호
		<%=b1%>님의 예약 조회
	</h3>
	<form name="frm" action="bction" method="get"
		style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
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
				<%
					String reti = String.format("%04d", rs.getInt("resvtime"));

						String ho = rs.getString("hospcode");
						String hos = "";

						String vc = rs.getString("vcode");
						String vco = "";

						String ad = rs.getString("hospaddr");
						String add = "";

						switch (ho) {
						case "H001":
							hos = "가_병원";
							break;
						case "H002":
							hos = "나_병원";
							break;
						case "H003":
							hos = "다_병원";
							break;
						case "H004":
							hos = "라_병원";
							break;
						}
						switch (vc) {
						case "V001":
							vco = "A백신";
							break;
						case "V002":
							vco = "B백신";
							break;
						case "V003":
							vco = "C백신";
							break;
						}
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
				<td><%=rs.getInt("resvno")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("jumin").substring(7, 8).equals("1")
						|| rs.getString("jumin").substring(7, 8).equals("3") ? "남"
						: "여"%></td>
				<td><%=hos%></td>
				<td><%=rs.getString("resvdate").substring(0, 4) + "년"
						+ rs.getString("resvdate").substring(5, 7) + "월"
						+ rs.getString("resvdate").substring(8, 10) + "일"%></td>
				<td><%=reti.substring(0, 2) + ":" + reti.substring(2, 4)%></td>
				<td><%=vco%></td>
				<td><%=add%></td>
			</tr>
		</table>
		<br>
		<button type="button" onclick="window.location.href = 'b.jsp'">
			홈으로</button>
	</form>
	</section>

	<%
		} else {
	%>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<h3>
		예약번호
		<%=b1%>로 조회된 결과가 없습니다
	</h3>
	<form name="frm" action="bction" method="get"
		style="display: flex; justify-content: center; align-items: center;">
		<button type="button" onclick="window.location.href = 'main.jsp'">
			홈으로</button>
	</form>
	</section>
	<%
		}
	%>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
