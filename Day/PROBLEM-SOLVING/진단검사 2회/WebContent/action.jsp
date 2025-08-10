<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");

	String b1 = request.getParameter("b1");
	String b2 = request.getParameter("b2");
	String b3 = request.getParameter("b3");
	String b4 = request.getParameter("b4");
	String b5 = request.getParameter("b5");
	String b6 = request.getParameter("b6");

	String sql = "insert into TBL_RESULT_202004 values(?,?,TO_DATE(?,'YYYY-MM-DD'),?,TO_DATE(?,'YYYY-MM-DD'),?)";
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
	alert("검사결과가 정상적으로 등록되었습니다!");
	window.location.href = 'main.jsp';
</script>
<%
	} else {
%>
<script>
	alert("검사결과가 비정상적으로 실패되었습니다!");
	history.back();
</script>
<%
	}
%>