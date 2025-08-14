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

	String sql = "insert into TBL_VOTE_202505 values(?,?,?,?,?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, b1);
	pstmt.setString(2, b2);
	pstmt.setString(3, b3);
	pstmt.setString(4, b4);
	pstmt.setString(5, b5);
	pstmt.setString(6, b6);
	int result = pstmt.executeUpdate();
	
	if(result>0){
		%>
			<script>
				alert("투표하기 정보가 정상적으로 등록 되었습니다!");
				window.location.href = 'main.jsp';
			</script>
		<%
	}else{
		%>
		<script>
			alert("투표하기 정보가 비정상적으로 실패 되었습니다!");
			history.back();
		</script>
	<%
	}
%>