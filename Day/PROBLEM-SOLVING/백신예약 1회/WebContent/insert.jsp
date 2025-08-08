<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="db.jsp"%>
<%
try{
	

	request.setCharacterEncoding("UTF-8");
	int resvno = Integer.parseInt(request.getParameter("an")); // 예약번호: 숫자
	String jumin = request.getParameter("bn");                 // 주민번호
	String hc = request.getParameter("hc");                    // 병원코드
	String dt = request.getParameter("dt");                    // 예약날짜: YYYYMMDD
	int tm = Integer.parseInt(request.getParameter("tm"));     // 예약시간: 숫자
	String vc = request.getParameter("vc");         

	String sql = "INSERT INTO tbl_vaccresv_202109 VALUES (?, ?, ?, TO_DATE(?, 'YYYYMMDD'), ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, resvno);           // 예약번호
	pstmt.setString(2, jumin);         // 주민번호
	pstmt.setString(3, hc);            // 병원코드
	pstmt.setString(4, dt);            // 예약날짜 (TO_DATE 안으로 들어감)
	pstmt.setInt(5, tm);               // 예약시간
	pstmt.setString(6, vc);            // 백신코드
	int result = pstmt.executeUpdate();

	if (result > 0) {
%>
<script>
	alert("예약이 완료되었습니다!");
	location.href = "index.jsp";
</script>
<%
	}else{
		%>
		<script>
		alert("예약이 실패!");
		history.back();
		</script>
		<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
