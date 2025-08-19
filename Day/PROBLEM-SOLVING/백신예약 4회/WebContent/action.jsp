<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="db.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String a1 = request.getParameter("a1");
String a2 = request.getParameter("a2");
String a3 = request.getParameter("a3");
String a4 = request.getParameter("a4");
String a5 = request.getParameter("a5");
String a6 = request.getParameter("a6");

String sql = "insert into tbl_vaccresv_202109 values(?,?,?,TO_DATE(?,'YYYYMMDD'),?,?)";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(a1));
pstmt.setString(2, a2);
pstmt.setString(3, a4);
pstmt.setString(4, a5);
pstmt.setInt(5,Integer.parseInt(a6));
pstmt.setString(6, a3);

int result = pstmt.executeUpdate();

if(result > 0){
	%>
	<script>
		alert("백신예약이 정상적으로 완료되었습니다!");
		window.location.href = "main.jsp";
	</script>
	<%
}else{
	%>
	<script>
		alert("백신예약이 비정상적으로 실패되었습니다!");
		history.back();
	</script>
	<%
}
%>