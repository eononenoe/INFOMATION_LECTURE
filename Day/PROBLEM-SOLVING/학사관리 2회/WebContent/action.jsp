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

	int b22 = Integer.parseInt(b2);
	int b33 = Integer.parseInt(b3);
	int b44 = Integer.parseInt(b4);
	int b55 = Integer.parseInt(b5);
	
	String sql = "insert into exam_tbl_01 (SNO, EKOR, EMATH, EENG, EHIST) values(?,?,?,?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, b1);
	pstmt.setInt(2, b22);
	pstmt.setInt(3, b33);
	pstmt.setInt(4, b44);
	pstmt.setInt(5, b55);
	
	int result = pstmt.executeUpdate();
	if (result > 0) {
%>
<script>
	alert("학생정보가 정상적으로 입력되었습니다!");
	window.location.href = "main.jsp";
</script>
<%
	} else {
%>
<script>
	alert("학생정보가 등록이 실패되었습니다!");
	history.back();
</script>
<%
	}
%>