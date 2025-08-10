<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>a</title>
<style>
td{
padding-left: 10px;
padding-right: 10px;
}

</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%;height:100%; text-align:center; background-color:lightgray;">
	<h3>환자조회</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>환자번호</td>
				<td>환자성명</td>
				<td>생년월일</td>
				<td>성별</td>
				<td>전화번호</td>
				<td>지역</td>
			</tr>
			<%
				String sql = "select * from TBL_PATIENT_202004";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				try {
					while (rs.next()) {
						
						String ci = rs.getString("P_CITY");
						String cit = "";
						switch(ci){
						case "10":
							cit = "서울";
							break;
						case "20":
							cit = "경기";
							break;
						case "30":
							cit = "강원";
							break;
						case "40":
							cit = "대구";
							break;
						}
			%>
			<tr>
				<td><%=rs.getString("P_NO")%></td>
				<td><%=rs.getString("P_NAME")%></td>
				<td><%=rs.getString("P_BIRTH").substring(0,4)+"년"+rs.getString("P_BIRTH").substring(4,6)+"월"+rs.getString("P_BIRTH").substring(6,8)+"일"%></td>
				<td><%=rs.getString("P_GENDER").equals("M")?"남":"여"%></td>
				<td><%=rs.getString("P_TEL1")+"-"+rs.getString("P_TEL2")+"-"+rs.getString("P_TEL3")%></td>
				<td><%=cit%></td>
			</tr>
			<%
				}
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