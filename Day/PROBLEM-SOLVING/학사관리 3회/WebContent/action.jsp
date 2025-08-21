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

	String sql = "insert into exam_tbl_01 values(?,?,?,?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, b1);
	pstmt.setInt(2, Integer.parseInt(b2));
	pstmt.setInt(3, Integer.parseInt(b3));
	pstmt.setInt(4, Integer.parseInt(b4));
	pstmt.setInt(5, Integer.parseInt(b5));

	int result = pstmt.executeUpdate();
	if (result > 0) {
%>
<script>
	alert("학생 성적이 정상적으로 입력되었습니다!");
	location.href = 'b.jsp';
</script>
<%
	} else {
%>
<script>
	alert("학생 성적이 비정상적으로 등록되지 않았습니다!");
	history.back();
</script>
<%
	}
%>