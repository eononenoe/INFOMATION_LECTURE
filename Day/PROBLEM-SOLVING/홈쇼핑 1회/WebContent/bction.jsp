<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="db.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String a1 = request.getParameter("a1"); // custno
String a2 = request.getParameter("a2"); // custname
String a3 = request.getParameter("a3"); // phone
String a4 = request.getParameter("a4"); // address
String a5 = request.getParameter("a5"); // joindate (yyyy-MM-dd 권장)
String a6 = request.getParameter("a6"); // grade (A/B/C)
String a7 = request.getParameter("a7"); // city

String sql = "update member_tbl_02 set custname=?,phone=?,address=?, joindate=TO_DATE(?, 'YYYY-MM-DD'),grade=?,city=? "+
		"where custno=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, a2);
pstmt.setString(2, a3);
pstmt.setString(3, a4);
pstmt.setString(4, a5);
pstmt.setString(5, a6);
pstmt.setString(6, a7);
pstmt.setInt(7, Integer.parseInt(a1));

int result = pstmt.executeUpdate();

if(result>0){
	%>
	<script>
		alert("회원정보수정이 완료되었습니다!");
        location.href = "b.jsp";
	</script>
	<%
}else{
	%>
	<script>
		alert("회원정보수정이 실패되었습니다!");
		history.back();
	</script>
	<%
}
%>