<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section style="position:fixed;top:150px;left:0px;width:100%;height:100%;text-align:center;background-color:lightgray;">
<h3>학사관리 프로그램</h3>
<br>
<div style="text-align: left; padding-left: 10px;">
학생정보와 성적정보 데이터베이스를 구축하고 성적관리 프로그램을 작성하는 프로그램이다.<br>
프로그램 작성 순서<br>
1.학생정보 테이블을 생성한다.<br>
2.성적정보 테이블을 생성한다.<br>
3.학생정보, 성적정보 테이블에 제시된 문제지의 참조데이터를 추가 생성한다.<br>
4.학생목록 조회 프로그램을 작성한다.<br>
5.성적정보 입력 화면프로그램을 작성한다.<br>
6.학생성적 조회 프로그램을 작성한다.<br>
</div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>