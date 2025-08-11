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

int a11 = Integer.parseInt(a1);
int a66 = Integer.parseInt(a6);

String sql = "insert into tbl_vaccresv_202109(resvno, jumin, hospcode, resvdate, resvtime, vcode) "
        + "values(?,?,?,TO_DATE(?,'YYYYMMDD'),?,?)";

PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, a11);         // resvno
pstmt.setString(2, a2);       // jumin
pstmt.setString(3, a4);       // hospcode
pstmt.setString(4, a5);       // resvdate (문자열을 TO_DATE로 변환)
pstmt.setInt(5, a66);         // resvtime (숫자)
pstmt.setString(6, a3);       // vcode


int result = pstmt.executeUpdate();
if(result > 0) {
	%>
	<script>
		alert("백신예약이 정상적으로 완료되었습니다!");
		window.location.href = "main.jsp";
	</script>
	<%
}else {
	%>
		<script>
		alert("백신예약이 실패되었습니다!");
		history.back();
	</script>
	<%
}
%>