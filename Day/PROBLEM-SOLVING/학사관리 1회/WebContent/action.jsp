<%@page import="java.sql.*"%>
<%@include file="db.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String b1 = request.getParameter("b1");
String b2 = request.getParameter("b2");
String b3 = request.getParameter("b3");
String b4 = request.getParameter("b4");
String b5 = request.getParameter("b5");

int ib2 = Integer.parseInt(b2);
int ib3 = Integer.parseInt(b3);
int ib4 = Integer.parseInt(b4);
int ib5 = Integer.parseInt(b5);

String sql = "insert into exam_tbl_01 values(?,?,?,?,?)";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, b1);
pstmt.setInt(2, ib2);
pstmt.setInt(3, ib3);
pstmt.setInt(4, ib4);
pstmt.setInt(5, ib5);
int result = pstmt.executeUpdate();
if(result >0){
	%>
	<script>
		alert("학생 성적이 정상적으로 입력되었습니다!");
		window.location.href = "main.jsp";
	</script>
	<%
}else {
	%>
	<script>
		alert("학생 성적이 정상적으로 입력되지 않았습니다!");
		history.back();
	</script>
	<%
}
%>