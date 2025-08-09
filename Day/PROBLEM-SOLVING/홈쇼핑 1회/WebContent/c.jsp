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
		style="position:fixed;top:150px;left:0px;width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>홈쇼핑 회원 등록</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>회원번호</td>
				<td>회원성명</td>
				<td>고객등급</td>
				<td>매출</td>
			</tr>
			<%
				String sql = "select a.custno,a.custname,a.grade,sum(b.price) as spr "+
						"from member_tbl_02 a "+
						"join money_tbl_02 b on a.custno = b.custno " +
						"group by  a.custno,a.custname,a.grade " +
						"order by spr desc";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				
				try{
					while(rs.next()){
						String gr = rs.getString("grade");
						String gra = "";
						switch(gr){
						case  "A":
							gra = "VIP";
							break;
						case  "B":
							gra = "일반";
							break;
						case  "C":
							gra = "직원";
							break;
						}
			%>
			<tr>
				<td><%=rs.getString("custno")%></td>
				<td><%=rs.getString("custname")%></td>
				<td><%=gra%></td>
				<td><%=rs.getString("spr")%></td>
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