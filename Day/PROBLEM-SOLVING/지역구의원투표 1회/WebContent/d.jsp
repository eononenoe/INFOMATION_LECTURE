<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>d</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>후보자등수</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>후보번호</td>
				<td>성명</td>
				<td>총투표건수</td>
			</tr>
			<%
			String sql = "select m.m_no,m.m_name,count(v.m_no) as mcnt "+
					"from TBL_MEMBER_202505 m " +
					"join TBL_VOTE_202505 v on v.m_no = m.m_no "+
					"where v_confirm='Y' "+
					"group by m.m_no,m.m_name "+
					"order by mcnt desc";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try{
				while(rs.next()){
					%>
			<tr>
				<td><%=rs.getString("m_no")%></td>
				<td><%=rs.getString("m_name")%></td>
				<td><%=rs.getInt("mcnt")%></td>
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