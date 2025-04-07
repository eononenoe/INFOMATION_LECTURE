# 01

# DTO

---

> **OrderDto**
> 

```jsx
package C09;

import java.time.format.DateTimeFormatter;

public class OrderDto {
	private String CATEGORY;
	private Integer SUM;
	
	public OrderDto() {}

	public OrderDto(String cATEGORY, Integer sUM) {
		super();
		CATEGORY = cATEGORY;
		SUM = sUM;
	}

	public String getCATEGORY() {
		return CATEGORY;
	}

	public void setCATEGORY(String cATEGORY) {
		CATEGORY = cATEGORY;
	}

	public Integer getSUM() {
		return SUM;
	}

	public void setSUM(Integer sUM) {
		SUM = sUM;
	}

	@Override
	public String toString() {
		return "OrderDto [CATEGORY=" + CATEGORY + ", SUM=" + SUM + "]";
	}
	
	//getter andSetter
	
	
	
}

```

---

> **OrderDto2**
> 

```jsx
package C09;

import java.time.LocalDate;

public class OrderDto2 {
	private LocalDate order_date;
	private Double	average;
	
	public OrderDto2() {}
	public OrderDto2(LocalDate order_date, Double average) {
		super();
		this.order_date = order_date;
		this.average = average;
	}
	public LocalDate getOrder_date() {
		return order_date;
	}
	public void setOrder_date(LocalDate order_date) {
		this.order_date = order_date;
	}
	public Double getAverage() {
		return average;
	}
	public void setAverage(Double average) {
		this.average = average;
	}
	@Override
	public String toString() {
		return "OrderDto2 [order_date=" + order_date + ", average=" + average + "]";
	}
	
}	

```

---

> **OrderDto3**
> 

```jsx
package C09;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class OrderDto3{

	private String addr;
	private LocalDate order_date;
	private int sum_price;
	public OrderDto3() {}
	public OrderDto3(String addr, LocalDate order_date, int sum_price) {
		super();
		this.addr = addr;
		this.order_date = order_date;
		this.sum_price = sum_price;
	}
	//생성자
	//toString
	//getter and setter
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public LocalDate getOrder_date() {
		return order_date;
	}
	public void setOrder_date(LocalDate order_date) {
		this.order_date = order_date;
	}
	public int getSum_price() {
		return sum_price;
	}
	public void setSum_price(int sum_price) {
		this.sum_price = sum_price;
	}
	@Override
	public String toString() {
		return "OrderDto3 [addr=" + addr + ", order_date=" + order_date + ", sum_price=" + sum_price + "]";
	}
	
	
}

```

---

# Order

---

> **selectAll_1**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!--
	품목별 총합 (총합별 내림차순)
	select CATEGORY,sum(price*quantity) from tbl_order
	group by CATEGORY
	having sum(price*quantity) >=50000
	order by sum(price*quantity) desc;
-->
<%@page import="C04.UserDto,C09.*,java.util.*,java.time.format.DateTimeFormatter"%>
<%
List<OrderDto> list = DBUtils.getInstance().selectAllOrder();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>품목별 총액 (50000만원 이상)</h1>
	<%

	%>
	<table>
		<tr>
			<th>품목</th>
			<th>총합</th>
		</tr>

		<%
		for (OrderDto orderDto : list) {
		%>
			<tr>
				<th><%=orderDto.getCATEGORY() %></th>
				<th><%=orderDto.getSUM() %></th>
			</tr>
		<%
		}
		%>

	</table>
	
	<h1>날짜별 구매 총평균</h1>
	<!--  
		select order_date, round(avg(price*quantity),2)
		from tbl_order
		group by order_date;
	-->
	<%
		List<OrderDto2> list2 = DBUtils.getInstance().selectAllOrder2();
	%>
	<table>
		<tr>
			<th>날짜</th>
			<th>평균</th>
		</tr>
		
		<%
			for(OrderDto2 dto : list2)
			{
				//yyyy.MM.dd
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		%>
			<tr>
				<td><%=dto.getOrder_date().format(formatter) %></td>
				<td><%=dto.getAverage() %></td>
			</tr>
		<%		
			}
		%>

		
	</table>

</body>
</html>

```

---

> **selectAll_2**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="C09.*,C09.DBUtils,java.util.*,java.time.format.DateTimeFormatter" %>
<%
 	List<OrderDto3> list = DBUtils.getInstance().selectAllOrder3();
%>   
<!--  
	INNER JOIN
	
	select u.addr,o.ORDER_DATE, sum(o.PRICE*o.QUANTITY)
	from tbl_user u
	join tbl_order o
	on u.userid=o.userid
	group by u.addr,o.ORDER_DATE
	order by  u.addr asc , sum(o.PRICE*o.QUANTITY) desc
	;

	select *
	from tbl_user
	left outer join tbl_order
	on tbl_user.userid=tbl_order.userid
	where tbl_order.userid is null;
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>지역+날짜별 구매총액</h1>
		<table>
			<tr>
				<th>지역</th>
				<th>날짜</th>
				<th>총액</th>
			</tr>
			
			<%
			for(OrderDto3 dto : list)
			{
				//날짜포매팅 해서 모양변경(yyyy*MM*dd)
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy*MM*dd");
			%>
			<tr>
				<td><%=dto.getAddr() %></td>
				<td><%=dto.getOrder_date().format(formatter) %></td>
				<td><%=dto.getSum_price() %></td>
			</tr>					
			<%
			}
			
			%>

		
		</table>

</body>
</html>
```

---

# 지역구의원투표

---

## Utils

---

> **DBUtils**
> 

```jsx
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	public List<MemberDto> selectAllMember() throws Exception{
		String sql = "select M.M_NO,m.m_name,p.p_name,m.p_school,m.m_jumin,m.m_city,p.p_tel1,p.p_tel2,p.p_tel3"
				+ " from TBL_MEMBER_202005 M"
				+ " join tbl_party_202005 P"
				+ " on M.p_CODE = P.P_CODE";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		List<MemberDto> list = new ArrayList<>();
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
}

```

---

> **MemberDto**
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
	MemberDto() {}
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
	@Override
	public String toString() {
		return "MemberDto [m_no=" + m_no + ", m_name=" + m_name + ", p_name=" + p_name + ", p_school=" + p_school
				+ ", m_jumin=" + m_jumin + ", m_city=" + m_city + ", p_tel1=" + p_tel1 + ", p_tel2=" + p_tel2
				+ ", p_tel3=" + p_tel3 + "]";
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
	
}

```

---

## Layouts

---

> **Footer**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
footer {
	background-color: black;
}
</style>
<footer></footer>
```

---

> **Header**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
header {
	background-color: darkgray;
	line-height: 80px
}

h3 {
	font-size: 1.5rem;
	margin: 0; 
	text-align:center;
}
</style>
<header>
	<h3>(과정평가형 정보처리 산업기사) 지역구의원투표 프로그램 ver 2020-05</h3>
</header>
```

---

> **Nav**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
nav{background-color:lightgray;}
nav>ul {
	display: flex;
	justify-content:left;
}
nav>ul>li{
	padding : 5px 20px;
}
</style>
<nav>
	<ul>
		<li><a href="${pageContext.request.contextPath}/01/index.jsp">후보조회</a></li>
		<li><a href="${pageContext.request.contextPath}/02/index.jsp">투표하기</a></li>
		<li><a href="${pageContext.request.contextPath}/03/index.jsp">투표검수조회</a></li>
		<li><a href="${pageContext.request.contextPath}/04/index.jsp">후보자등수</a></li>
		<li><a href="${pageContext.request.contextPath}">홈으로</a></li>
	</ul>
</nav>
```

---

## 01

---

> **Index**
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
	min-height:200px;
	margin: 0 auto;
}

.wrapper>main table th, .wrapper>main table td {
	min-width: 80px; !important;
	min-height: 20px; !important;
	border:1px solid;
	text-align:center;
}

.wrapper>footer {
	height: 80px
}
</style>
</head>
<body>
	<!-- 
select M.M_NO,m.m_name,p.p_name,m.p_school,m.m_jumin,m.m_city,p.p_tel1
from TBL_MEMBER_202005 M
join tbl_party_202005 P 
on M.p_CODE = P.P_CODE;
 -->
	<%@page import="Utils.*,java.util.*"%>
	<%
	List<MemberDto> list = DBUtils.getInstance().selectAllMember();
	%>
	<div class="wrapper">
		<!--  -->
		<%@include file="/layouts/Header.jsp"%>
		<!--  -->
		<%@include file="/layouts/Nav.jsp"%>
		<main>
			<h2>후보조회</h2>
			<table>
				<tr>
					<th>후보번호</th>
					<th>성명</th>
					<th>소속정당</th>
					<th>학력</th>
					<th>주민번호</th>
					<th>지역구</th>
					<th>대표전화</th>
				</tr>
				<%
				for (MemberDto dto : list) {
				%>
				<tr>
					<td><%=dto.getM_no()%></td>
					<td><%=dto.getM_name()%></td>
					<td><%=dto.getP_name()%></td>
					<%
					String school = dto.getP_school();
					switch(school){
					case "1":
						out.print("<td>고졸</td>");
						break;
					case "2":
						out.print("<td>학사</td>");
						break;
					case "3":
						out.print("<td>석사</td>");
						break;
					case "4":
						out.print("<td>박사</td>");
						break;
					}
					%>
					<td><%=dto.getM_jumin().substring(0,6) + "-" + dto.getM_jumin().substring(6) %></td>
					<td><%=dto.getM_city()%></td>
					<td><%=dto.getP_tel1() + "-" + dto.getP_tel2() + "-" + dto.getP_tel3()%></td>
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
:root{}
*{box-sizing:border-box;}
body{padding:0;margin:0;}
ul{list-style:none; margin:0; padding:0;}
a{text-decoration: none; color:black;}
.wrapper{}
.wrapper>header{height:80px;}
.wrapper>nav{height:50px;}
.wrapper>main{height:calc(100vh - 80px - 50px - 80px);}
.wrapper>footer{height:80px}

</style>
</head>
<body>
	<div class="wrapper">
	<!--  -->
	<%@include file="/layouts/Header.jsp" %>
	<!--  -->
	<%@include file="/layouts/Nav.jsp" %>
		<main>
		</main>
	<!--  -->
	<%@include file="/layouts/Footer.jsp" %>
	</div>
</body>
</html>
```