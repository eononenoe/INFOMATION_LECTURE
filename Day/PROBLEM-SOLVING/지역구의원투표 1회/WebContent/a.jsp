<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>a</title>
<style>
td{
padding: 5px; 10px;
 }
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>후보조회</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>후보</td>
				<td>성명</td>
				<td>소속정당</td>
				<td>학력</td>
				<td>주민번호</td>
				<td>지역구</td>
				<td>대표전화</td>
			</tr>
			<%
			String sql = "select m.m_no,m.m_name,p.p_name,m.p_school,m.m_jumin ,m.m_city ,p.p_tel1,p.p_tel2,p.p_tel3 "+
					"from TBL_MEMBER_202505 m join TBL_PARTY_202505 p on p.p_code = m.p_code";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try{
				while(rs.next()){
					String sc = rs.getString("p_school");
					String sch = "";
					switch(sc){
					case "1":
						sch="고졸";
						break;
					case "2":
						sch="학사";
						break;
					case "3":
						sch="석사";
						break;
					case "4":
						sch="박사";
						break;
					}
					%>
			<tr>
				<td><%=rs.getString("m_no")%></td>
				<td><%=rs.getString("m_name")%></td>
				<td><%=rs.getString("p_name")%></td>
				<td><%=sch%></td>
				<td><%=rs.getString("m_jumin").substring(0,6)+"-"+rs.getString("m_jumin").substring(6)%></td>
				<td><%=rs.getString("m_city")%></td>
				<td><%=rs.getString("p_tel1")+"-"+rs.getString("p_tel2")+"-"+rs.getString("p_tel3")%></td>
			</tr>
				<%
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			%>
		</table>
	</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>