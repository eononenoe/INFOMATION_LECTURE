# 01

# 지역구의원투표

---

## Utils

---

> DBUtils
> 

```jsx
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DBUtils {
	
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String id = "system";
	private String pw = "1234";
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	
	//싱글톤 
	private static DBUtils instance;
	private DBUtils() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, id, pw);
	}
	public static DBUtils getInstance() throws Exception {
		if(instance==null)
			instance = new DBUtils();
		return instance;
	}
	
//	select M.M_NO,M.M_NAME,P.P_NAME,M.P_SCHOOL,M.M_JUMIN,M.M_CITY,P.P_TEL1,P.P_TEL2,P.P_TEL3
//	from TBL_MEMBER_202005 M
//	join TBL_PARTY_202005 P
//	on M.P_CODE=P.P_CODE;
	public List<MemberDto> selectAllMember() throws Exception{
		String sql="select M.M_NO,M.M_NAME,P.P_NAME,M.P_SCHOOL,M.M_JUMIN,M.M_CITY,P.P_TEL1,P.P_TEL2,P.P_TEL3"
				+ " from TBL_MEMBER_202005 M"
				+ " join TBL_PARTY_202005 P"
				+ " on M.P_CODE=P.P_CODE"
				;
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		List<MemberDto> list = new ArrayList();
		MemberDto dto = null;
		if(rs!=null) {
			
			while(rs.next()) {
				dto = new MemberDto();	
				dto.setM_no(rs.getString(1));
				dto.setM_name(rs.getString(2));
				dto.setP_name(rs.getString(3));
				dto.setP_school(rs.getString(4));
				dto.setM_jumin(rs.getString(5));
				dto.setM_city(rs.getString(6));
				dto.setP_tel1(rs.getString(7));
				dto.setP_tel2(rs.getString(8));
				dto.setP_tel3(rs.getString(9));
				list.add(dto);
			}
		}
		
		pstmt.close();
		rs.close();
		return list;
	}

	
	public int insertVote(VoteDto dto) throws Exception {
		
		pstmt = conn.prepareStatement("insert into TBL_VOTE_202005 values(?,?,?,?,?,?)");
		pstmt.setString(1, dto.getV_jumin());
		pstmt.setString(2, dto.getV_name());
		pstmt.setString(3, dto.getM_no());
		pstmt.setString(4, dto.getV_time());
		pstmt.setString(5, dto.getV_area());
		pstmt.setString(6, dto.getV_confirm());
		
		int result = pstmt.executeUpdate();
		
		pstmt.close();
		return result;
	}
	
	
	public List<VoteDto> selectAllVote() throws Exception{
		String sql="select * from TBL_VOTE_202005";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		List<VoteDto> list = new ArrayList();
		VoteDto dto = null;
		if(rs!=null) {
			while(rs.next()) {
				dto = new VoteDto();
				dto.setV_jumin(rs.getString(1));
				dto.setV_name(rs.getString(2));
				dto.setM_no(rs.getString(3));
				dto.setV_time(rs.getString(4));
				dto.setV_area(rs.getString(5));
				dto.setV_confirm(rs.getString(6));
				list.add(dto);
			}
		}
		pstmt.close();
		rs.close();
		return list;
	}
	
	
}

```

---

> MemberDto
> 

```jsx
package Utils;

public class MemberDto {
	private String m_no;
	private String m_name;
	private String p_name;
	private String p_school;
	private String m_jumin;
	private String m_city;
	private String p_tel1;
	private String p_tel2;
	private String p_tel3;
	//나머지 추가코드 넣어주세요(생성자 / getter and setter / toString)
	public MemberDto() {}
	public MemberDto(String m_no, String m_name, String p_name, String p_school, String m_jumin, String m_city,
			String p_tel1, String p_tel2, String p_tel3) {
		super();
		this.m_no = m_no;
		this.m_name = m_name;
		this.p_name = p_name;
		this.p_school = p_school;
		this.m_jumin = m_jumin;
		this.m_city = m_city;
		this.p_tel1 = p_tel1;
		this.p_tel2 = p_tel2;
		this.p_tel3 = p_tel3;
	}
	public String getM_no() {
		return m_no;
	}
	public void setM_no(String m_no) {
		this.m_no = m_no;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_school() {
		return p_school;
	}
	public void setP_school(String p_school) {
		this.p_school = p_school;
	}
	public String getM_jumin() {
		return m_jumin;
	}
	public void setM_jumin(String m_jumin) {
		this.m_jumin = m_jumin;
	}
	public String getM_city() {
		return m_city;
	}
	public void setM_city(String m_city) {
		this.m_city = m_city;
	}
	public String getP_tel1() {
		return p_tel1;
	}
	public void setP_tel1(String p_tel1) {
		this.p_tel1 = p_tel1;
	}
	public String getP_tel2() {
		return p_tel2;
	}
	public void setP_tel2(String p_tel2) {
		this.p_tel2 = p_tel2;
	}
	public String getP_tel3() {
		return p_tel3;
	}
	public void setP_tel3(String p_tel3) {
		this.p_tel3 = p_tel3;
	}
	@Override
	public String toString() {
		return "MemberDto [m_no=" + m_no + ", m_name=" + m_name + ", p_name=" + p_name + ", p_school=" + p_school
				+ ", m_jumin=" + m_jumin + ", m_city=" + m_city + ", p_tel1=" + p_tel1 + ", p_tel2=" + p_tel2
				+ ", p_tel3=" + p_tel3 + "]";
	}
	
}

```

---

> **VoteDto**
> 

```jsx
package Utils;

public class VoteDto {

	private String v_jumin;
	private String v_name;
	private String m_no;
	private String v_time;
	private String v_area;
	private String v_confirm;
	//getter and setter
	//생성자(디폴트 , 모든인자)
	//to String
	public String getV_jumin() {
		return v_jumin;
	}
	public void setV_jumin(String v_jumin) {
		this.v_jumin = v_jumin;
	}
	public String getV_name() {
		return v_name;
	}
	public void setV_name(String v_name) {
		this.v_name = v_name;
	}
	public String getM_no() {
		return m_no;
	}
	public void setM_no(String m_no) {
		this.m_no = m_no;
	}
	public String getV_time() {
		return v_time;
	}
	public void setV_time(String v_time) {
		this.v_time = v_time;
	}
	public String getV_area() {
		return v_area;
	}
	public void setV_area(String v_area) {
		this.v_area = v_area;
	}
	public String getV_confirm() {
		return v_confirm;
	}
	public void setV_confirm(String v_confirm) {
		this.v_confirm = v_confirm;
	}
	@Override
	public String toString() {
		return "VoteDto [v_jumin=" + v_jumin + ", v_name=" + v_name + ", m_no=" + m_no + ", v_time=" + v_time
				+ ", v_area=" + v_area + ", v_confirm=" + v_confirm + "]";
	}
	public VoteDto(String v_jumin, String v_name, String m_no, String v_time, String v_area, String v_confirm) {
		super();
		this.v_jumin = v_jumin;
		this.v_name = v_name;
		this.m_no = m_no;
		this.v_time = v_time;
		this.v_area = v_area;
		this.v_confirm = v_confirm;
	}
	public VoteDto() {}
	
}

```

---

## 02

---

> **create**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 파라미터 받기 -->
<%@page import="Utils.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

	String 	jumin = request.getParameter("v_jumin");
	String 	name = request.getParameter("v_name");
	String 	no = request.getParameter("m_no");
	String 	time = request.getParameter("v_time");
	String 	area = request.getParameter("v_area");
	String 	confirm = request.getParameter("v_confirm");

	VoteDto voteDto = new VoteDto(jumin,name,no,time,area,confirm);
	System.out.println("voteDto : " + voteDto);
%>  

<!-- 파라미터 받기(액션 태그) -: useBean + :setProperty -->
<jsp:useBean id="voteDto2" class="Utils.VoteDto" scope="request" />
<jsp:setProperty name="voteDto2" property="*" />

<%
	System.out.println("voteDto2 : " + voteDto2);
	int result = DBUtils.getInstance().insertVote(voteDto2);
	
	if(result > 0){
		request.getRequestDispatcher("./read.jsp").forward(request,response);
	}else{
		out.println("<script>alert('투표 실패!다시하세요');location.href='./index.jsp'</script>");
	}
%>

```

---

> **index**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
:root {
	
}

html {
	
}

* {
	box-sizing: border-box;
}

body {
	padding: 0;
	margin: 0;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

a {
	text-decoration: none;
	color: black;
}

.wrapper {
	
}

.wrapper>header {
	height: 80px;
}

.wrapper>nav {
	height: 50px;
}

.wrapper>main {
	height: calc(100vh - 80px - 50px - 80px);
}

.wrapper>main h2 {
	text-align: center;
	font-size: 1.8rem;
	font-weight: 400;
}

.wrapper>main table {
	border: 1px solid;
	border-collapse: collapse;
	min-width: 500px;
	min-height: 350px;
	margin: 0 auto;
}

.wrapper>main table th, .wrapper>main table td {
	min-width: 80px !important;
	min-height: 35px !important;
	border: 1px solid;
	text-align: center;
}

.wrapper>main table th {
	background-color: lightgray;
}

.wrapper>footer {
	height: 80px;
}
</style>

</head>
<body>

	<div class="wrapper">
		<!--  -->
		<%@include file="/layouts/Header.jsp"%>

		<!--  -->
		<%@include file="/layouts/Nav.jsp"%>

		<main>
			<h2>투표하기</h2>
			<form name="vote_form" action="./create.jsp" method="post"
				onsubmit="return false">
				<div>
					<label>주민번호</label> <input name="v_jumin" />
				</div>
				<div>
					<label>성명</label> <input name="v_name" />
				</div>
				<div>
					<label>투표번호</label> <input name="m_no" />
				</div>
				<div>
					<label>투표시간</label> <input name="v_time" />
				</div>
				<div>
					<label>투표장소</label> <input name="v_area" />
				</div>
				<div>
					<label>유권자확인</label> <input type="radio" name="v_confirm" value="Y" />
					확인 &nbsp;&nbsp; <input type="radio" name="v_confirm" value="N" />
					미확인
				</div>
				<div>
					<button type="submit" onclick="isValid()">투표하기</button>
					<button type="reset">다시하기</button>
				</div>
			</form>
		</main>

		<!--  -->
		<%@include file="/layouts/Footer.jsp"%>

	</div>

	<script>
		function isValid() {
			//form요소 찾기 
			var form = document.vote_form;
			//유효성검사
			if (form.v_jumin.value === "") {
				alert("주민번호가 입력되지 않았습니다!");
				form.v_jumin.focus();
				return;
			}
			//...
			if (form.v_confirm.value === "") {
				alert("유권자 확인이 선택되지 않았습니다!");
				return;
			}

			//submit처리
			form.submit();
		}
	</script>

</body>
</html>

```

---

> **read**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
:root {
	
}

html {
	
}

* {
	box-sizing: border-box;
}

body {
	padding: 0;
	margin: 0;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

a {
	text-decoration: none;
	color: black;
}

.wrapper {
	
}

.wrapper>header {
	height: 80px;
}

.wrapper>nav {
	height: 50px;
}

.wrapper>main {
	height: calc(100vh - 80px - 50px - 80px);
}

.wrapper>main h2 {
	text-align: center;
	font-size: 1.8rem;
	font-weight: 400;
}

.wrapper>main table {
	border: 1px solid;
	border-collapse: collapse;
	min-width: 500px;
	min-height: 350px;
	margin: 0 auto;
}

.wrapper>main table th, .wrapper>main table td {
	min-width: 80px !important;
	min-height: 35px !important;
	border: 1px solid;
	text-align: center;
}

.wrapper>main table th {
	background-color: lightgray;
}

.wrapper>footer {
	height: 80px;
}
</style>

</head>
<body>

	<div class="wrapper">
		<!--  -->
		<%@include file="/layouts/Header.jsp"%>

		<!--  -->
		<%@include file="/layouts/Nav.jsp"%>

		<!-- 파라미터 받기(액션 태그) -: useBean + :setProperty -->
		<jsp:useBean id="voteDto2" class="Utils.VoteDto" scope="request" />
		<jsp:setProperty name="voteDto2" property="*" />
		<main>
			<h2>투표검수조회</h2>
			<table>
			
				<tr>
					<th>성명</th>
					<th>생년월일</th>
					<th>나이</th>
					<th>성별</th>
					<th>후보번호</th>
					<th>투표시간</th>
					<th>유권자확인</th>
				</tr>
						

				<%@page import="java.time.Period,java.time.LocalDate,java.time.format.DateTimeFormatter" %>
				<tr>
					<td><%=voteDto2.getV_name() 	%></td>
					<td><%=voteDto2.getV_jumin() 	%></td>
					<%
						String age = voteDto2.getV_jumin().substring(0,6);//19 + 860918
						System.out.println("age :" + age);
						age = "19" + age;
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
						LocalDate date = LocalDate.parse(age,formatter);
						System.out.println("date : " + date);
						
						//현재 날짜
						LocalDate today = LocalDate.now();
						
						int manAge = Period.between(date,today).getYears();
						out.println("<td>만 "+manAge+"세</td>");
					%>
					<%-- <td><%=voteDto2.getV_jumin() 	%></td> --%>
					
					<%
						char gender = voteDto2.getV_jumin().charAt(6);
						if(gender%2==0)
							out.print("<td>여자</td>");
						else
							out.print("<td>남자</td>");
					%>
					<%-- <td><%=voteDto2.getV_jumin() 	%></td> --%>
					
					<td><%=voteDto2.getM_no() 		%></td>
					<td><%=voteDto2.getV_time() 	%></td>
					<td><%=voteDto2.getV_confirm() 	%></td>
				</tr>
					
			</table>
		</main>

		<!--  -->
		<%@include file="/layouts/Footer.jsp"%>

	</div>
	

</body>
</html>

```

---

## 03

---

> **index**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
:root {
	
}

html {
	
}

* {
	box-sizing: border-box;
}

body {
	padding: 0;
	margin: 0;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

a {
	text-decoration: none;
	color: black;
}

.wrapper {
	
}

.wrapper>header {
	height: 80px;
}

.wrapper>nav {
	height: 50px;
}

.wrapper>main {
	height: calc(100vh - 80px - 50px - 80px);
	overflow:auto;
}

.wrapper>main h2 {
	text-align: center;
	font-size: 1.8rem;
	font-weight: 400;
}

.wrapper>main table {
	border: 1px solid;
	border-collapse: collapse;
	min-width: 500px;
	min-height: 350px;
	margin: 0 auto;
}

.wrapper>main table th, .wrapper>main table td {
	min-width: 80px !important;
	min-height: 25px !important;
	border: 1px solid;
	text-align: center;
}

.wrapper>main table th {
	background-color: lightgray;
}

.wrapper>footer {
	height: 80px;
}
</style>

</head>
<body>

	<div class="wrapper">
		<!--  -->
		<%@include file="/layouts/Header.jsp"%>

		<!--  -->
		<%@include file="/layouts/Nav.jsp"%>

		<%@page
			import="Utils.*,java.util.*,java.time.LocalDate,java.time.format.DateTimeFormatter"%>
		<%
		List<VoteDto> list = DBUtils.getInstance().selectAllVote(); //860918
		%>
		<main>
			<h2>투표검수조회</h2>
			<table>
				<tr>
					<th>성명</th>
					<th>생년월일</th>
					<th>나이</th>
					<th>성별</th>
					<th>후보번호</th>
					<th>투표시간</th>
					<th>유권자확인</th>
				</tr>
				<%
				for (VoteDto voteDto : list) {
				%>
				<tr>
					<td><%=voteDto.getV_name()%></td>
					<%
					String birthYear = voteDto.getV_jumin().substring(0, 6); //yyMMdd
					System.out.println("birthYear : " + birthYear);
					
					int yy = Integer.parseInt(birthYear.substring(0,2));
					int now = LocalDate.now().getYear()%100;
					System.out.println("now : " + now);
					if(yy>0 && yy<=now)	//01년생 - 24년생
						birthYear = "20"+birthYear;
					else
						birthYear = "19"+birthYear;	//19860918
						
					
					//입력 포맷(yyMMdd)
					DateTimeFormatter infmt = DateTimeFormatter.ofPattern("yyyyMMdd");
					
					LocalDate myBirth = LocalDate.parse(birthYear ,infmt);
						
						
					//출력 포맷(yyyy년MM월dd일생)
					DateTimeFormatter outfmt = DateTimeFormatter.ofPattern("yyyy년MM월dd일생");
					out.println("<td>"+myBirth.format(outfmt)+"</td>");
					%>
					<%-- <td><%=voteDto.getV_jumin()%></td> --%>
					
					
					<td><%=voteDto.getV_jumin()%></td>
					<td><%=voteDto.getV_jumin()%></td>
					<td><%=voteDto.getM_no()%></td>
					<td><%=voteDto.getV_time()%></td>
					<td><%=voteDto.getV_confirm()%></td>
				</tr>
				<%
				}
				%>

			</table>
		</main>

		<!--  -->
		<%@include file="/layouts/Footer.jsp"%>

	</div>

</body>
</html>
```

---

# 03HRDKOREA

---

## Utils

---

> DBUtils
> 

```jsx
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DBUtils {
	
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String id = "system";
	private String pw = "1234";
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	
	//싱글톤 
	private static DBUtils instance;
	private DBUtils() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, id, pw);
	}
	public static DBUtils getInstance() throws Exception {
		if(instance==null)
			instance = new DBUtils();
		return instance;
	}
	
	//강사테이블조회
	public List<TeacherDto> selectAllTeacher() throws Exception {
		String sql="select * from TBL_TEACHER_202201";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		List<TeacherDto> list = new ArrayList();
		TeacherDto dto = null;
		if(rs!=null) {
			
			while(rs.next()) {
				//코드 추가해주세요 -
				dto=new TeacherDto();
				dto.setTeacher_code(rs.getString(1));
				dto.setTeacher_name(rs.getString(2));
				dto.setClass_name(rs.getString(3));
				dto.setClass_price(rs.getInt(4));
				dto.setTeacher_regist_date(rs.getString(5));
				list.add(dto);
			}
			
		}
		
		return list;
	}

	
}
```

---

> **TeacherDto**
> 

```jsx
package Utils;

public class TeacherDto {
	private String teacher_code;
	private String teacher_name;
	private String class_name;
	private int class_price;
	private String teacher_regist_date;
	//getter and setter , toString , 생성자(디폴트 , 모든인자)
	public TeacherDto() {}
	public TeacherDto(String teacher_code, String teacher_name, String class_name, int class_price,
			String teacher_regist_date) {
		super();
		this.teacher_code = teacher_code;
		this.teacher_name = teacher_name;
		this.class_name = class_name;
		this.class_price = class_price;
		this.teacher_regist_date = teacher_regist_date;
	}
	public String getTeacher_code() {
		return teacher_code;
	}
	public void setTeacher_code(String teacher_code) {
		this.teacher_code = teacher_code;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public int getClass_price() {
		return class_price;
	}
	public void setClass_price(int class_price) {
		this.class_price = class_price;
	}
	public String getTeacher_regist_date() {
		return teacher_regist_date;
	}
	public void setTeacher_regist_date(String teacher_regist_date) {
		this.teacher_regist_date = teacher_regist_date;
	}
	@Override
	public String toString() {
		return "TeacherDto [teacher_code=" + teacher_code + ", teacher_name=" + teacher_name + ", class_name="
				+ class_name + ", class_price=" + class_price + ", teacher_regist_date=" + teacher_regist_date + "]";
	}
	
}

```

---

> **index**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
:root {
	
}

html {
	
}

* {
	box-sizing: border-box;
}

body {
	padding: 0;
	margin: 0;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

a {
	text-decoration: none;
	color: black;
}

.wrapper {
	
}

.wrapper>header {
	height: 80px;
}

.wrapper>nav {
	height: 50px;
}

.wrapper>main {
	height: calc(100vh - 80px - 50px - 80px);
	overflow:auto;
}

.wrapper>main h2 {
	text-align: center;
	font-size: 1.8rem;
	font-weight: 400;
}

.wrapper>main table {
	border: 1px solid;
	border-collapse: collapse;
	min-width: 500px;
	min-height: 350px;
	margin: 0 auto;
}

.wrapper>main table th, .wrapper>main table td {
	min-width: 80px !important;
	min-height: 25px !important;
	border: 1px solid;
	text-align: center;
}

.wrapper>main table th {
	background-color: lightgray;
}

.wrapper>footer {
	height: 80px;
}
</style>

</head>
<body>
	
	<div class="wrapper">
		<!--  -->
		<%@include file="/layouts/Header.jsp" %>
		
		<!--  -->
		<%@include file="/layouts/Nav.jsp" %>
		
		<main>
			<h2>강사조회</h2>
			<!--  -->
			<table>
				<tr>
					<th>강사코드</th>
					<th>강사명</th>
					<th>강의명</th>
					<th>수강료</th>
					<th>강사자격취득일</th>
				</tr>
				<%@page import="Utils.*,java.util.*,java.time.*,java.time.format.*" %>		
				<%
				  List<TeacherDto> list = DBUtils.getInstance().selectAllTeacher();
				%>
				<%
				 for(TeacherDto dto : list)
				 {
				%>
				<tr>
					<td><%=dto.getTeacher_code() %></td>
					<td><%=dto.getTeacher_name() %></td>
					<td><%=dto.getClass_name() %></td>
					<%
						
					%>
					<td><%=dto.getClass_price() %></td>
					<%
						String date = dto.getTeacher_regist_date();
						//INFMT
						DateTimeFormatter inFmt = DateTimeFormatter.ofPattern("yyyyMMdd");
						LocalDate localDate = LocalDate.parse(date,inFmt);
						//OUTFMT
						DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy년MM월dd일");
						out.print("<td>"+localDate.format(outFmt)+"</td>");
						
					%>
					<%-- <td><%=dto.getTeacher_regist_date() %></td> --%>
				</tr>
				<%	 
				 }
				%>

			</table>
		</main>
		
		<!--  -->
		<%@include file="/layouts/Footer.jsp" %>
	
	</div>

</body>
</html>
```

---