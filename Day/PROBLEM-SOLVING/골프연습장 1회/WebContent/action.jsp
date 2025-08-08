<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String b1 = request.getParameter("b1");
	String b2 = request.getParameter("c_no");
	String b3 = request.getParameter("b4");
	String b4 = request.getParameter("teacher_code");
	String b5 = request.getParameter("tuition");
	
	int bt = Integer.parseInt(b5);
	
	String sql = "insert into TBL_CLASS_202201(resist_month,c_no,class_area,tuition,teacher_code) values(?,?,?,?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, b1);
	pstmt.setString(2, b2);
	pstmt.setString(3, b3);
	pstmt.setInt(4, bt);
	pstmt.setString(5, b4);

	int result = pstmt.executeUpdate();

	if (result > 0) {
%>
<script>
	alert("수강신청이 정상적으로 완료되었습니다!");
	window.location.href = "main.jsp";
</script>
<%
	} else {
%>
<script>
	alert("수강신청이 실패");
	history.back();	
</script>
<%
	}
%>