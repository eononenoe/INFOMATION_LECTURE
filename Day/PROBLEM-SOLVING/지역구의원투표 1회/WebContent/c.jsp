<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>c</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section
		style="position:fixed; top:150px; left:0px; width:100%;height:100%;background-color:lightgray;text-align:center;">
	<h3>투표검수조회</h3>
	<form
		style="display: flex; justify-content: center; align-items: center;">
		<table border="1">
			<tr>
				<td>성명</td>
				<td>생년월일</td>
				<td>나이</td>
				<td>성별</td>
				<td>후보번호</td>
				<td>투표시간</td>
				<td>유권자확인</td>
			</tr>
			<%
			String sql = "select * from TBL_VOTE_202505 where v_area='제1투표장'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try{
				while(rs.next()){
					int toyy = 25;
					int tomm = 8;
					String yy = rs.getString("v_jumin").substring(0,2);
					String mm = rs.getString("v_jumin").substring(2,4);
					
					int birth = Integer.parseInt(yy);
					int birmm = Integer.parseInt(mm);
					int age = 0;
					if(toyy > birth){
						birth += 2000;
					}else{
						birth += 1900;
					}
					age = (2000+toyy) - birth;
					if(tomm < birmm){
						age -= 1;
					}
					%>
			<tr>
				<td><%=rs.getString("v_name")%></td>
				<td><%=birth+"년"+rs.getString("v_jumin").substring(2,4)+"월"+rs.getString("v_jumin").substring(4,6)+"일생"%></td>
				<td><%="만 " +age+"세"%></td>
				<td><%=rs.getString("v_jumin").substring(5,6).equals("1")||rs.getString("v_jumin").substring(5,6).equals("3")?"남":"여"%></td>
				<td><%=rs.getString("m_no")%></td>
				<td><%=rs.getString("v_time").substring(0,2)+":"+rs.getString("v_time").substring(2,4)%></td>
				<td><%=rs.getString("v_confirm").equals("Y")?"확인":"미확인"%></td>
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