<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String resvno = request.getParameter("resvno");
	String sql = "select v.resvno, j.name, j.jumin, h.hospname, v.resvdate, v.resvtime, v.vcode, h.hospaddr "
			+ "from tbl_vaccresv_202109 v "
			+ "join tbl_jumin_202109 j on v.jumin = j.jumin "
			+ "join tbl_hosp_202109 h on v.hospcode = h.hospcode "
			+ "where v.resvno = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, resvno);
	ResultSet rs = pstmt.executeQuery();
	if (rs.next()) {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b2</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position: fixed; top: 150px; left: 0px; width: 100%; height: 100%; background-color: lightgray; text-align: center;">
		<h2>예약번호 <%=resvno%>님의 예약 조회</h2>
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
				<tr>
				<%
				String gen = rs.getString("jumin");
				String der = gen.substring(7,8).equals("1")||gen.substring(7,8).equals("3")?"남":"여";
				
				String de = rs.getString("resvdate");
				String te = de.substring(0,4) + "년" + de.substring(5,7) + "월" + de.substring(8,10)+"일";
				
				DecimalFormat df = new DecimalFormat("0000");
				String ti = rs.getString("resvtime");
				ti = df.format(Integer.parseInt(ti));
				String me = ti.substring(0,2) + ":" + ti.substring(2,4);
				
				String vc = rs.getString("vcode");
				String vco = "";
				switch(vc){
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
				
				String hos = rs.getString("hospaddr");
				String hosp = "";
				switch(hos){
				case "10":
					hosp = "서울";
					break;
				case "20":
					hosp = "대전";
					break;
				case "30":
					hosp = "대구";
					break;	
				case "40":
					hosp = "광주";
					break;		
				}
				%>
					<td><%=rs.getString("resvno")%></td>
					<td><%=rs.getString("name")%></td>
					<td><%=der%></td>
					<td><%=rs.getString("hospname")%></td>
					<td><%=te%></td>
					<td><%=me%></td>
					<td><%=vco%></td>
					<td><%=hosp%></td>
				</tr>
			</table>
		</form>
				<button type="button" onclick="window.location.href = 'b.jsp'">돌아가기</button>
		
		</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
<%
	} else {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b2</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position: fixed; top: 150px; left: 0px; width: 100%; height: 100%; background-color: lightgray; text-align: center;">
		<h2>
			예약번호<%=resvno%>로 조회된 결과가 없습니다.
		</h2>
		<button type="button" onclick="window.location.href = 'main.jsp'">홈으로</button>
		</div>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

<%
	}
%>
