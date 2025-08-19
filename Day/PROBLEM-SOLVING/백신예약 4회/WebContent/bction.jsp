<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bction</title>
<style>
td {
	
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
	<%
		request.setCharacterEncoding("UTF-8");
		String b1 = request.getParameter("b1");

		String sql = "select c.resvno,a.name,a.jumin,b.hospname,c.resvdate,c.resvtime,c.vcode,b.hospaddr "
				+ "from tbl_vaccresv_202109 c join tbl_jumin_202109 a on a.jumin=c.jumin "
				+"join tbl_hosp_202109 b on b.hospcode = c.hospcode "
				+"where resvno = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(b1));
		ResultSet rs = pstmt.executeQuery();

		try {
			if (rs.next()) {
	%>
	<h3>
		예약번호
		<%=b1%>님의 예약 조회
	</h3>
	<br>
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
			<%
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
			int time = rs.getInt("resvtime");
			String ti = String.format("%04d",time);
			%>
				<td><%=rs.getString("resvno") %></td>
				<td><%=rs.getString("name") %></td>
				<td><%=rs.getString("jumin").substring(7,8).equals("1")||rs.getString("jumin").substring(7,8).equals("3")?"남":"여"%></td>
				<td><%=rs.getString("hospname") %></td>
				<td><%=rs.getString("resvdate").substring(0,4)+"년"+rs.getString("resvdate").substring(5,7)+"월"+rs.getString("resvdate").substring(8,10)+"일" %></td>
				<td><%=ti.substring(0,2)+":"+ti.substring(2,4) %></td>
				<td><%=vco %></td>
				<td><%=hos %></td>
			</tr>
		</table>
	</form>
	<br>
	<button type="button" onclick="window.location.href = 'b.jsp'">돌아가기</button>
	<%
		} else {
	%>
	<h3>
		예약번호
		<%=b1%>로 조회된 결과가 없습니다.
	</h3>
	<br>
	<button type="button" onclick="window.location.href = 'main.jsp'">홈으로</button>
	<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%> </section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>