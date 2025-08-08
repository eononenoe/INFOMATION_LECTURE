<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<%
	String b1 = request.getParameter("b1");
	String b2 = request.getParameter("b2");
	String b3 = request.getParameter("b3");
	String b4 = request.getParameter("b4");
	String b5 = request.getParameter("b5");
	String b6 = request.getParameter("b6");

	try {
		String sql = "INSERT INTO TBL_RESULT_202004 (P_NO, T_CODE, T_SDATE, T_STATUS, T_LDATE, T_RESULT)"
				+ "VALUES (?, ?, to_date(?,'yyyymmdd'), ?, to_date(?,'yyyymmdd'), ?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, b1);
		pstmt.setString(2, b2);
		pstmt.setString(3, b3);
		pstmt.setString(4, b4);
		pstmt.setString(5, b5);
		pstmt.setString(6, b6);
		int result = pstmt.executeUpdate();
		if (result > 0) {
%>
<script>
	alert("검사결과가 정상적으로 등록 되었습니다!");
	window.location.href = "main.jsp"
</script>


<%
	} else {
%>
<script>
alert("검사결과가 정상적으로 등록 되지않았습니다!");
history.back();
</script>
<%
	}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>