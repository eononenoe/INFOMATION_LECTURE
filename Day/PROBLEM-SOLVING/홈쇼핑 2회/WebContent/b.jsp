<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="db.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b</title>
<style>
td{
padding: 0 5px;
}
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
<h3>회원목록조회/수정</h3>
<br>
<form style="display: flex; justify-content:center; align-items:center;">
	<table border="1">
		<tr>
			<td>회원번호</td>
			<td>회원성명</td>
			<td>전화번호</td>
			<td>주소</td>
			<td>가입일자</td>
			<td>고객등급</td>
			<td>거주지역</td>
		</tr>
		<%
			String sql = "select * from member_tbl_02";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
		
			try{
				while(rs.next()){
					String gr = rs.getString("grade");
					String gra = "";
					
					switch(gr){
					case "A":
						gra = "VIP";
						break;
					case "B":
						gra = "일반";
						break;
					case "C":
						gra = "직원";
						break;
					}
					%>
		<tr>
			<td><a href="b1.jsp?custno=<%=rs.getInt("custno")%>"><%=rs.getInt("custno") %></a></td>
			<td><%=rs.getString("custname") %></td>
			<td><%=rs.getString("phone") %></td>
			<td><%=rs.getString("address") %></td>
			<td><%=rs.getDate("joindate") %></td>
			<td><%=gra %></td>
			<td><%=rs.getString("city") %></td>
		</tr>
					<%
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		%>
	</table>
</form>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>