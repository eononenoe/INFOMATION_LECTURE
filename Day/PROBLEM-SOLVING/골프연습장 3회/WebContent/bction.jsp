<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String b1 = request.getParameter("b1");
String b2 = request.getParameter("b2");
String b4 = request.getParameter("b4");
String b5 = request.getParameter("b5");
String b6 = request.getParameter("b6");

String sql ="insert into TBL_CLASS_202201 values(?,?,?,?,?)";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, b1);
pstmt.setString(2, b2);
pstmt.setString(3, b4);
pstmt.setInt(4, Integer.parseInt(b6));
pstmt.setString(5, b5);
int result = pstmt.executeUpdate();
if(result>0){
	%>
	<script>
		alert("수강신청이 정상적으로 완료되었습니다!");
		location.href = 'main.jsp';
	</script>
	<%
}else{
	%>
	<script>
		alert("수강신청이 비정상적으로 종료되었습니다!");
		history.back();
	</script>
	<%
}

%>