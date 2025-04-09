# 01

# 지역구의원투표

---

## Utils

---

> **ClassDto.java**
> 

```java

package Utils;

public class ClassDto {
    private String regist_month;
    private String c_no;
    private String class_area;
    private String class_name;
    private int tuition;
    private String teacher_code;

    public ClassDto() {}

    public ClassDto(String regist_month, String c_no, String class_area, String class_name, int tuition, String teacher_code) {
        this.regist_month = regist_month;
        this.c_no = c_no;
        this.class_area = class_area;
        this.class_name = class_name;
        this.tuition = tuition;
        this.teacher_code = teacher_code;
    }

    public String getRegist_month() { return regist_month; }
    public void setRegist_month(String regist_month) { this.regist_month = regist_month; }

    public String getC_no() { return c_no; }
    public void setC_no(String c_no) { this.c_no = c_no; }

    public String getClass_area() { return class_area; }
    public void setClass_area(String class_area) { this.class_area = class_area; }

    public String getClass_name() { return class_name; }
    public void setClass_name(String class_name) { this.class_name = class_name; }

    public int getTuition() { return tuition; }
    public void setTuition(int tuition) { this.tuition = tuition; }

    public String getTeacher_code() { return teacher_code; }
    public void setTeacher_code(String teacher_code) { this.teacher_code = teacher_code; }

    @Override
    public String toString() {
        return "ClassDto [regist_month=" + regist_month + ", c_no=" + c_no + ", class_area=" + class_area
                + ", class_name=" + class_name + ", tuition=" + tuition + ", teacher_code=" + teacher_code + "]";
    }
}

```

---

> **DBUtils.java**
> 

```java
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

    private static DBUtils instance;
    private DBUtils() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, id, pw);
    }
    public static DBUtils getInstance() throws Exception {
        if (instance == null)
            instance = new DBUtils();
        return instance;
    }

    public List<MemberDto> selectAllMember() throws Exception {
        String sql = "select M.M_NO,M.M_NAME,P.P_NAME,M.P_SCHOOL,M.M_JUMIN,M.M_CITY,P.P_TEL1,P.P_TEL2,P.P_TEL3"
                + " from TBL_MEMBER_202005 M"
                + " join TBL_PARTY_202005 P"
                + " on M.P_CODE=P.P_CODE";

        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        List<MemberDto> list = new ArrayList<>();
        MemberDto dto = null;
        if (rs != null) {
            while (rs.next()) {
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

    public List<VoteDto> selectAllVote() throws Exception {
        String sql = "select * from TBL_VOTE_202005";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        List<VoteDto> list = new ArrayList<>();
        VoteDto dto = null;
        if (rs != null) {
            while (rs.next()) {
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

> **Join1Dto.java**
> 

```java
package Utils;

public class Join1Dto {
    private String regist_month;
    private String c_no;
    private String c_name;
    private String class_name;
    private String class_area;
    private int tuition;
    private String grade;

    public Join1Dto() {}

    public Join1Dto(String regist_month, String c_no, String c_name, String class_name, String class_area, int tuition, String grade) {
        this.regist_month = regist_month;
        this.c_no = c_no;
        this.c_name = c_name;
        this.class_name = class_name;
        this.class_area = class_area;
        this.tuition = tuition;
        this.grade = grade;
    }

    public String getRegist_month() { return regist_month; }
    public void setRegist_month(String regist_month) { this.regist_month = regist_month; }

    public String getC_no() { return c_no; }
    public void setC_no(String c_no) { this.c_no = c_no; }

    public String getC_name() { return c_name; }
    public void setC_name(String c_name) { this.c_name = c_name; }

    public String getClass_name() { return class_name; }
    public void setClass_name(String class_name) { this.class_name = class_name; }

    public String getClass_area() { return class_area; }
    public void setClass_area(String class_area) { this.class_area = class_area; }

    public int getTuition() { return tuition; }
    public void setTuition(int tuition) { this.tuition = tuition; }

    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    @Override
    public String toString() {
        return "Join1Dto [regist_month=" + regist_month + ", c_no=" + c_no + ", c_name=" + c_name
                + ", class_name=" + class_name + ", class_area=" + class_area + ", tuition=" + tuition + ", grade=" + grade + "]";
    }
}

```

> **Join2Dto.java**
> 

```java
package Utils;

public class Join2Dto {
    private String teacher_code;
    private String class_name;
    private String teacher_name;
    private int total_tuition;

    public Join2Dto() {}

    public Join2Dto(String teacher_code, String class_name, String teacher_name, int total_tuition) {
        this.teacher_code = teacher_code;
        this.class_name = class_name;
        this.teacher_name = teacher_name;
        this.total_tuition = total_tuition;
    }

    public String getTeacher_code() { return teacher_code; }
    public void setTeacher_code(String teacher_code) { this.teacher_code = teacher_code; }

    public String getClass_name() { return class_name; }
    public void setClass_name(String class_name) { this.class_name = class_name; }

    public String getTeacher_name() { return teacher_name; }
    public void setTeacher_name(String teacher_name) { this.teacher_name = teacher_name; }

    public int getTotal_tuition() { return total_tuition; }
    public void setTotal_tuition(int total_tuition) { this.total_tuition = total_tuition; }

    @Override
    public String toString() {
        return "Join2Dto [teacher_code=" + teacher_code + ", class_name=" + class_name + ", teacher_name=" + teacher_name
                + ", total_tuition=" + total_tuition + "]";
    }
}

```

---

> **MemberDto.java**
> 

```java
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

    public MemberDto() {}

    public MemberDto(String m_no, String m_name, String p_name, String p_school, String m_jumin, String m_city,
                     String p_tel1, String p_tel2, String p_tel3) {
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

    public String getM_no() { return m_no; }
    public void setM_no(String m_no) { this.m_no = m_no; }

    public String getM_name() { return m_name; }
    public void setM_name(String m_name) { this.m_name = m_name; }

    public String getP_name() { return p_name; }
    public void setP_name(String p_name) { this.p_name = p_name; }

    public String getP_school() { return p_school; }
    public void setP_school(String p_school) { this.p_school = p_school; }

    public String getM_jumin() { return m_jumin; }
    public void setM_jumin(String m_jumin) { this.m_jumin = m_jumin; }

    public String getM_city() { return m_city; }
    public void setM_city(String m_city) { this.m_city = m_city; }

    public String getP_tel1() { return p_tel1; }
    public void setP_tel1(String p_tel1) { this.p_tel1 = p_tel1; }

    public String getP_tel2() { return p_tel2; }
    public void setP_tel2(String p_tel2) { this.p_tel2 = p_tel2; }

    public String getP_tel3() { return p_tel3; }
    public void setP_tel3(String p_tel3) { this.p_tel3 = p_tel3; }

    @Override
    public String toString() {
        return "MemberDto [m_no=" + m_no + ", m_name=" + m_name + ", p_name=" + p_name + ", p_school=" + p_school
                + ", m_jumin=" + m_jumin + ", m_city=" + m_city + ", p_tel1=" + p_tel1 + ", p_tel2=" + p_tel2
                + ", p_tel3=" + p_tel3 + "]";
    }
}

```

---

> **TeacherDto.java**
> 

```java
package Utils;

public class TeacherDto {
    private String teacher_code;
    private String teacher_name;
    private String class_name;
    private int class_price;
    private String teacher_regist_date;

    public TeacherDto() {}

    public TeacherDto(String teacher_code, String teacher_name, String class_name, int class_price, String teacher_regist_date) {
        this.teacher_code = teacher_code;
        this.teacher_name = teacher_name;
        this.class_name = class_name;
        this.class_price = class_price;
        this.teacher_regist_date = teacher_regist_date;
    }

    public String getTeacher_code() { return teacher_code; }
    public void setTeacher_code(String teacher_code) { this.teacher_code = teacher_code; }

    public String getTeacher_name() { return teacher_name; }
    public void setTeacher_name(String teacher_name) { this.teacher_name = teacher_name; }

    public String getClass_name() { return class_name; }
    public void setClass_name(String class_name) { this.class_name = class_name; }

    public int getClass_price() { return class_price; }
    public void setClass_price(int class_price) { this.class_price = class_price; }

    public String getTeacher_regist_date() { return teacher_regist_date; }
    public void setTeacher_regist_date(String teacher_regist_date) { this.teacher_regist_date = teacher_regist_date; }

    @Override
    public String toString() {
        return "TeacherDto [teacher_code=" + teacher_code + ", teacher_name=" + teacher_name + ", class_name=" + class_name
                + ", class_price=" + class_price + ", teacher_regist_date=" + teacher_regist_date + "]";
    }
}

```

---

> **VoteDto.java**
> 

```java
package Utils;

public class VoteDto {
    private String v_jumin;
    private String v_name;
    private String m_no;
    private String v_time;
    private String v_area;
    private String v_confirm;

    public VoteDto() {}

    public VoteDto(String v_jumin, String v_name, String m_no, String v_time, String v_area, String v_confirm) {
        this.v_jumin = v_jumin;
        this.v_name = v_name;
        this.m_no = m_no;
        this.v_time = v_time;
        this.v_area = v_area;
        this.v_confirm = v_confirm;
    }

    public String getV_jumin() { return v_jumin; }
    public void setV_jumin(String v_jumin) { this.v_jumin = v_jumin; }

    public String getV_name() { return v_name; }
    public void setV_name(String v_name) { this.v_name = v_name; }

    public String getM_no() { return m_no; }
    public void setM_no(String m_no) { this.m_no = m_no; }

    public String getV_time() { return v_time; }
    public void setV_time(String v_time) { this.v_time = v_time; }

    public String getV_area() { return v_area; }
    public void setV_area(String v_area) { this.v_area = v_area; }

    public String getV_confirm() { return v_confirm; }
    public void setV_confirm(String v_confirm) { this.v_confirm = v_confirm; }

    @Override
    public String toString() {
        return "VoteDto [v_jumin=" + v_jumin + ", v_name=" + v_name + ", m_no=" + m_no
                + ", v_time=" + v_time + ", v_area=" + v_area + ", v_confirm=" + v_confirm + "]";
    }
}

```

---

## Webapp

---

> **index.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>

```

---

> **template.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template</title>
</head>
<body>

</body>
</html>

```

---

## 01

---

> **01/index.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사조회</title>
</head>
<body>

<%@ include file="/layouts/Header.jsp" %>
<%@ include file="/layouts/Nav.jsp" %>

<main>
    <h2>강사조회</h2>
    <table>
        <tr>
            <th>강사코드</th>
            <th>강사명</th>
            <th>강의명</th>
            <th>수강료</th>
            <th>강사자격취득일</th>
        </tr>
        <%@page import="java.text.DecimalFormat, Utils.*, java.util.*, java.time.*, java.time.format.*" %>
        <%
          List<TeacherDto> list = DBUtils.getInstance().selectAllTeacher();
          for(TeacherDto dto : list) {
        %>
        <tr>
            <td><%=dto.getTeacher_code() %></td>
            <td><%=dto.getTeacher_name() %></td>
            <td><%=dto.getClass_name() %></td>
            <%
                int price = dto.getClass_price();
                DecimalFormat fmt = new DecimalFormat("#,###");
            %>
            <td><%="\\\\"+fmt.format(price) %></td>
            <%
                String date = dto.getTeacher_regist_date();
                DateTimeFormatter inFmt = DateTimeFormatter.ofPattern("yyyyMMdd");
                LocalDate localDate = LocalDate.parse(date, inFmt);
                DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy년MM월dd일");
                out.print("<td>"+localDate.format(outFmt)+"</td>");
            %>
        </tr>
        <% } %>
    </table>
</main>

<%@ include file="/layouts/Footer.jsp" %>

</body>
</html>

```

---

> **01/create.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="Utils.*" %>

<jsp:useBean id="classDto" class="Utils.ClassDto" scope="request" />
<jsp:setProperty name="classDto" property="*" />

<%
    int result = DBUtils.getInstance().insertClass(classDto);
    if(result>0){
        String code = "<script>";
        code +="alert('수강신청 완료!');";
        code +="location.href='../index.jsp';";
        code +="</script>";
        out.println(code);
    }
    else{
        String code = "<script>";
        code +="alert('수강신청 실패!');";
        code +="location.href='./index.jsp';";
        code +="</script>";
        out.println(code);
    }
%>

```

---

> **01/delete.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 페이지</title>
</head>
<body>

</body>
</html>

```

---

> **01/read.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조회 페이지</title>
</head>
<body>

</body>
</html>

```

---

> **01/update.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 페이지</title>
</head>
<body>

</body>
</html>

```

---

## 02

---

> **02/index.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청</title>
</head>
<body>

<%@page import="Utils.*,java.util.*" %>
<%
	List<MemberDto> member_list = DBUtils.getInstance().selectAllMember();
	List<TeacherDto> teacher_list = DBUtils.getInstance().selectAllTeacher();
%>

<div class="wrapper">
	<%@include file="/layouts/Header.jsp"%>
	<%@include file="/layouts/Nav.jsp"%>

	<main>
		<h2>수강신청</h2>
		<form action="./create.jsp" name="registForm" onsubmit="return false">
			<table>
				<tr>
					<td>수강월</td>
					<td><input name="regist_month" /></td>
				</tr>
				<tr>
					<td>회원명</td>
					<td>
						<select name="c_name">
							<option value="">회원명</option>
							<%
							for(MemberDto dto : member_list){
							%>
							<option data-no="<%=dto.getM_no()%>"><%=dto.getM_name()%></option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>회원번호</td>
					<td><input name="c_no" /></td>
				</tr>
				<tr>
					<td>강의장소</td>
					<td><input name="class_area" /></td>
				</tr>
				<tr>
					<td>강의명</td>
					<td>
						<select name="class_name">
							<option value="">강의선택</option>
							<%
							for(TeacherDto dto : teacher_list){
							%>
							<option data-teacherCode="<%=dto.getTeacher_code()%>" data-price="<%=dto.getClass_price()%>"><%=dto.getClass_name()%></option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>수강료</td>
					<td>
						<input name="tuition"/>
						<input type="hidden" name="teacher_code"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit" onclick="isValid()">수강신청</button>
						<button onclick="resetFunc()">다시쓰기</button>
					</td>
				</tr>
			</table>
		</form>
	</main>

	<%@include file="/layouts/Footer.jsp"%>
</div>

<script>
const form = document.registForm;
form.c_name.addEventListener('change', function(e){
	const selected = e.target.options[e.target.selectedIndex];
	const cno = selected.getAttribute("data-no");
	form.c_no.value = cno;
});

form.class_name.addEventListener('change', function(e){
	const selected = e.target.options[e.target.selectedIndex];
	const teacherCode = selected.getAttribute("data-teacherCode");
	const price = selected.getAttribute("data-price");
	form.teacher_code.value = teacherCode;
	form.tuition.value = price;
});

function isValid() {
	if (form.regist_month.value === "") {
		alert("수강월을 입력하세요 ex)202501");
		form.regist_month.focus();
		return;
	}
	if (form.c_name.value === "") {
		alert("회원명을 선택하세요");
		form.c_name.focus();
		return;
	}
	form.submit();
}

function resetFunc() {
	alert("다시쓰기 합니다!");
	form.reset();
}
</script>

</body>
</html>

```

---

> **02/create.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="Utils.*" %>

<jsp:useBean id="classDto" class="Utils.ClassDto" scope="request" />
<jsp:setProperty name="classDto" property="*" />

<%
    int result = DBUtils.getInstance().insertClass(classDto);
    if(result>0){
        String code = "<script>";
        code +="alert('수강신청 완료!');";
        code +="location.href='../index.jsp';";
        code +="</script>";
        out.println(code);
    }
    else{
        String code = "<script>";
        code +="alert('수강신청 실패!');";
        code +="location.href='./index.jsp';";
        code +="</script>";
        out.println(code);
    }
%>

```

---

> **02/delete.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 페이지</title>
</head>
<body>

</body>
</html>

```

---

> **02/read.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청조회</title>
</head>
<body>

<%@include file="/layouts/Header.jsp" %>
<%@include file="/layouts/Nav.jsp" %>

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
        <tr>
            <td><%= voteDto2.getV_name() %></td>
            <td><%= voteDto2.getV_jumin() %></td>
            <%
                String age = voteDto2.getV_jumin().substring(0,6);
                age = "19" + age;
                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyyMMdd");
                java.time.LocalDate birthDate = java.time.LocalDate.parse(age, formatter);
                java.time.LocalDate today = java.time.LocalDate.now();
                int manAge = java.time.Period.between(birthDate, today).getYears();
                out.println("<td>만 "+manAge+"세</td>");
            %>
            <%
                char gender = voteDto2.getV_jumin().charAt(6);
                if (gender % 2 == 0)
                    out.print("<td>여자</td>");
                else
                    out.print("<td>남자</td>");
            %>
            <td><%= voteDto2.getM_no() %></td>
            <td><%= voteDto2.getV_time() %></td>
            <td><%= voteDto2.getV_confirm() %></td>
        </tr>
    </table>
</main>

<%@include file="/layouts/Footer.jsp" %>

</body>
</html>

```

---

> **02/update.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 페이지</title>
</head>
<body>

</body>
</html>

```

---

## 03

---

> **03/index.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보조회</title>
</head>
<body>

<%@page import="Utils.*,java.util.*" %>
<%
    List<Join1Dto> join_list = DBUtils.getInstance().selectAllJoin1();
%>

<div class="wrapper">
    <%@include file="/layouts/Header.jsp"%>
    <%@include file="/layouts/Nav.jsp"%>

    <main>
        <h2>회원정보조회</h2>
        <table>
            <tr>
                <th>수강월</th>
                <th>회원번호</th>
                <th>회원명</th>
                <th>강의명</th>
                <th>강의장소</th>
                <th>수강료</th>
                <th>등급</th>
            </tr>
            <% for(Join1Dto dto : join_list) { %>
            <tr>
                <td><%=dto.getRegist_month()%></td>
                <td><%=dto.getC_no()%></td>
                <td><%=dto.getC_name()%></td>
                <td><%=dto.getClass_name()%></td>
                <td><%=dto.getClass_area()%></td>
                <td><%=dto.getTuition()%></td>
                <td><%=dto.getGrade()%></td>
            </tr>
            <% } %>
        </table>
    </main>

    <%@include file="/layouts/Footer.jsp"%>
</div>

</body>
</html>

```

---

> **03/create.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>create.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **03/delete.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **03/read.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **03/update.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **04/index.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사매출현황</title>
</head>
<body>

<%@page import="Utils.*,java.util.*" %>
<%
    List<Join2Dto> join_list = DBUtils.getInstance().selectAllJoin2();
%>

<div class="wrapper">
    <%@include file="/layouts/Header.jsp"%>
    <%@include file="/layouts/Nav.jsp"%>

    <main>
        <h2>강사매출현황</h2>
        <table>
            <tr>
                <th>강사코드</th>
                <th>강의명</th>
                <th>강사명</th>
                <th>총매출</th>
            </tr>
            <% for(Join2Dto dto : join_list) { %>
            <tr>
                <td><%=dto.getTeacher_code()%></td>
                <td><%=dto.getClass_name()%></td>
                <td><%=dto.getTeacher_name()%></td>
                <td><%=dto.getTotal_tuition()%></td>
            </tr>
            <% } %>
        </table>
    </main>

    <%@include file="/layouts/Footer.jsp"%>
</div>

</body>
</html>

```

---

> **04/create.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>create.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **04/delete.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **04/read.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **04/update.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
</head>
<body>

</body>
</html>

```

---

> **layouts/Header.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    header {
        background-color: blue;
        line-height: 80px;
    }
    h3 {
        font-size: 1.8rem;
        margin: 0;
        color: white;
        text-align: center;
    }
</style>

<header>
    <h3>골프연습장 회원관리 Ver1.0</h3>
</header>

```

---

> **layouts/Nav.jsp**
> 

```
jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    nav {
        background-color: lightgray;
    }
    nav>ul {
        display: flex;
        justify-content: left;
    }
    nav>ul>li {
        padding: 5px 20px;
    }
</style>

<nav>
    <ul>
        <li><a href="/01/index.jsp">강사조회</a></li>
        <li><a href="/02/index.jsp">수강신청</a></li>
        <li><a href="/03/index.jsp">회원정보조회</a></li>
        <li><a href="/04/index.jsp">강사매출현황</a></li>
        <li><a href="/">홈으로</a></li>
    </ul>
</nav>

```

---

> **layouts/Footer.jsp**
> 

```
jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    footer {
        background-color: black;
    }
</style>

<footer>
</footer>

```

---