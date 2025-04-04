# 01

> **login_form**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

	if(session.getAttribute("isAuth")!=null){
		out.println("<script>alert('이미 로그인 상태입니다.');location.href='./main.jsp'</script>");
		//response.sendRedirect("./main.jsp");	
	}

%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style>
		label{font-size : .8rem;}
		span{font-size:.5rem; color:red;}
	</style>
</head>
<body>

<h1>LOGIN FORM</h1>
<div style="min-height:25px;font-size:.8rem;color:orange">
	${param.message}
</div>
<form action="${pageContext.request.contextPath}/C07/03/login.jsp" method="post">
	<div>
		<label>아이디 :</label><span>${username_msg}</span> <br/>
		<input type="text"  name="username"  value="${cookie.username != null ? cookie.username.value : '' }" />
	</div>
	<div>
		<label>패스워드 :</label><span>${password_msg}</span> <br/>
		<input type="password"  name="password"/>
	</div>
	<div>
	
		
		<input type="checkbox" id="idSave" name="idSave"  ${ cookie.idchk != null ? 'checked' : '' }   />
		
		<label for="idSave" >ID 저장</label>
		
		<input type="checkbox" id="pwSave" name="pwSave"     />
		<label for="pwSave" >PW 저장</label>
	</div>
	<div>
		<button>로그인</button>
	</div>
	
</form>

</body>
</html>
```

---

> **login**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String idSave = request.getParameter("idSave");
	String pwSave = request.getParameter("pwSave");
	System.out.println("idSave : " + idSave);
	System.out.println("pwSave : " + pwSave);
	
	// 파라미터 유효성 체크
	if(username.isEmpty()){
		//out.println("<script>alert('username을 입력하세요');location.href='./login_form.jsp'</script>");
		request.setAttribute("username_msg","username을 입력하세요");				
	}
	if(password.isEmpty()){
		//out.println("<script>alert('password을 입력하세요');location.href='./login_form.jsp'</script>");
		request.setAttribute("password_msg","password을 입력하세요");
	}	
	
	if(username.isEmpty()||password.isEmpty()){
		request.getRequestDispatcher("./login_form.jsp").forward(request, response);
		return ;
	}
	
	//01 ID 확인(DB 조회 - 생략)
	if(!username.equals("admin")){
		request.setAttribute("username_msg","해당 ID는 존재하지않습니다");
		//request.setAttribute("password_msg","");
		request.getRequestDispatcher("./login_form.jsp").forward(request, response);
		return ;
	}
	//02 PW 확인(일치여부 확인)
	if(!password.equals("1234")){
		request.setAttribute("password_msg","패스워드가 일치하지 않습니다");
		request.getRequestDispatcher("./login_form.jsp").forward(request, response);
		return ;
	}	
	
	//03 사용자 상태정보(인증됨)를 Session 저장
	session.setAttribute("isAuth", true);
	session.setAttribute("role", "ROLE_ADMIN");
	session.setMaxInactiveInterval(30); //30초 (기본 1800초 :30분)
	
	//쿠키 설정
	if(idSave!=null){
		Cookie cookie = new Cookie("username",username);
		cookie.setMaxAge(60*5);
		cookie.setPath("/01JSP/C07/03/login_form.jsp");
		response.addCookie(cookie);
		
		Cookie idchk = new Cookie("idchk","on");
		idchk.setMaxAge(60*5);
		idchk.setPath("/01JSP/C07/03/login_form.jsp");
		response.addCookie(idchk);
	}else{
		Cookie cookie = new Cookie("username",null);
		cookie.setMaxAge(0);
		cookie.setPath("/01JSP/C07/03/login_form.jsp");
		response.addCookie(cookie);	
		
		Cookie idchk = new Cookie("idchk",null);
		idchk.setMaxAge(0);
		idchk.setPath("/01JSP/C07/03/login_form.jsp");
		response.addCookie(idchk);
	}
	
	
	//04 로그인 처리후 MAIN PAGE REDIRECT
	out.println("<script> alert('로그인 성공! MAIN page로 이동합니다.');location.href='main.jsp'</script>");
	
	
	
%>
```

---

> **logout**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.invalidate(); 

out.println("<script> alert('LOGOUT 성공! LOGIN PAGE로 이동합니다.');location.href='./login_form.jsp?message=Logout_Successful'</script>");

%>
```

---

> **main**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	if(session.getAttribute("isAuth")==null){
		//request.getRequestDispatcher("./login_form.jsp").forward(request,response);
		response.sendRedirect("./login_form.jsp?message=Session_Expired");
	}
		

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="./logout.jsp">로그아웃</a>
<hr/>
<h1>MAIN PAGE</h1>
ISAUTH : <%=session.getAttribute("isAuth") %> <br/>
ISAUTH(EL):${isAuth}<br/>

ROLE : <%=session.getAttribute("role") %> <br/>
ROLE(EL) : ${role}<br/>

</body>
</html>
```

---

# 01EL

---

> **form**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="./result.jsp">
		<div>
			<input type="text"  name="username"/>
		</div>
		<div>
			<input type="text"  name="password"/>
		</div>
		<div>
			<input type="submit" value="전송" />
		</div>
	</form>
	
</body>
</html>
```

---

> **result**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!--  
	EL(Expression Language) : 내장객체의 Scope 참조
	pageScope : 현재 JSP 페이지 내에서만 사용가능한 속성/기능 (관련 내장객체 : pageContext)
	requestScope : 하나의 요청 처리동안 	(관련 내장객체 : request)
	sessionScope : 일정기간 동안(지정된 혹은 기본값) (관련 내장객체 : session)
	applicationScope : 서버종료시 동안	(관련 내장 객체 application)

-->
<%@page import="C04.UserDto" %>
<% 
	pageContext.setAttribute("P_ATTR", "P_ATTR_VALUE");
	request.setAttribute("R_ATTR", "R_ATTR_VALUE");
	session.setAttribute("S_ATTR", "S_ATTR_VALUE");
	application.setAttribute("A_ATTR", "A_ATTR_VALUE");
	
	//pageContext.setAttribute("DUP", "PAGECONTEXT VALUE");
	//request.setAttribute("DUP", "REQUEST VALUE");
	//session.setAttribute("DUP", "SESSION VALUE");
	application.setAttribute("DUP", "APPLICATION VALUE");
	

%>

<!-- EL : PARAM -->
USERNAME : ${ param.username } <br/>
PASSWORD : ${ param.password } <br/>
<hr />

<!-- EL : ATTRIBUTE -->
PAGECONTEXT's ATTR : ${P_ATTR}<br/>
PAGECONTEXT's ATTR : ${pageScope.P_ATTR}<br/>
REQUEST's ATTR : ${R_ATTR}<br/>
REQUEST's ATTR : ${requestScope.R_ATTR}<br/>
SESSION's ATTR : ${S_ATTR}<br/>
SESSION's ATTR : ${sessionScope.S_ATTR}<br/>
APPLICATION's ATTR : ${A_ATTR}<br/>
APPLICATION's ATTR : ${applicationScope.A_ATTR}<br/>

<hr />
<!-- EL : ATTRIBUTE(중복값) -->
DUPLICATED VALUE : ${DUP}<br/>
<hr />

<!-- EL : OBJECT  -->
<%
	UserDto userDto = new UserDto("user1","1234","ROLE_USER");
	request.setAttribute("userDto", userDto);
%>
표현식 : <%=userDto.getUserid() %>  <br/>
EL : ${userDto.userid}<br/>

<hr />

<!-- EL : 연산자  -->
연산 : <%=1+"1" %> <br/>
EL :  ${1+"1"} <br/>

<hr />
<!-- NULL CHECK -->
NULL : ${null} <br/>
empty NULL : ${empty null} <br/>
empty null : ${empty TEST}<br>
empty not null : ${!empty TEST}<br>

</body>
</html>
```

---

# 02JSTL

---

> **getCookie**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>쿠키 확인(스크립틀릿 + 표현식)</h1>
	<%
		Cookie[] cookies =  request.getCookies();
		if(cookies!=null){
			for(Cookie cookie : cookies){
				
				System.out.println("cookie : " + cookie.getName()+" : " + cookie.getValue());
				%>
					<div>
						<a href="./deleteCookie.jsp?cookieName=<%=cookie.getName()%>">
							<%=cookie.getName() %> : <%=cookie.getValue() %>
						</a> 
					</div>
				<%
			}
		}
	%>
	
</body>
</html>
```

---

# USER

---

> **join_form**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>JOIN</h1>
	<form action="./join.jsp">
		<input type="text" name="userid" /> <br/>
		<input type="text" name="password" /> <br/>
		<button>회원가입</button>
	</form>

</body>
</html>
```

---

> **join**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="C09.DBUtils, C04.*" %>
<%
	//파라미터
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	String role = "ROLE_USER";
	
	//입력값 검증(생략ㅎㅎ)
	
	//서비스 실행(db insert)
	DBUtils dbutils = DBUtils.getInstance();
	int result =  dbutils.insertUser(new UserDto(userid,password,role));
	
	//이동 (redirect or forwarding or script코드 처리(location.href=))
	if(result>0)
		out.println("<script>alert('insert 성공');location.href='../index.jsp'</script>");
	else
		out.println("<script>alert('insert 실패');location.href='./join_form.jsp'</script>");
	
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
</head>
<body>
	
	<h1>INDEX</h1>
	
</body>
</html>
```

---

> **selectAll**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="C04.UserDto,C09.DBUtils,java.util.*" %>
<%
 	DBUtils dbUtils = DBUtils.getInstance();
	
	List<UserDto> list = dbUtils.selectAllUser();
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<!--  
			1 selectAllUser 를 이용해서 table 의 해당 user정보 표시
			2 만들어진 테이블에 컬럼을 추가해서 해당 컬럼의 수정	버튼을 만들어보세요 
			3 만들어진 테이블에 컬럼을 추가해서 해당 컬럼의 삭제	버튼을 만들어보세요 
			4 수정버튼을 클릭하면 수정페이지로 이동(update.jsp + 해당 사용자 파리미터 전달)
			5 삭제버튼을 클릭하면 삭제페이지로 이동(delete.jsp + 해당 사용자 파라미터 전달)
		-->
		총인원 : <%=list.size() %><br/>
		
		<table>
			<tr>
				<th>계정</th>
				<th>패스워드</th>
				<th>역할</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			
			<%
				for(UserDto dto : list)
				{
			%>
				<tr>
					<td><%=dto.getUserid() %></td>
					<td><%=dto.getPassword() %></td>
					<td><%=dto.getRole() %></td>
					<td>
						<a href="./update_form.jsp?userid=<%=dto.getUserid()%>">수정하기</a>
					</td>
					<td>
						<a href="./delete.jsp?userid=<%=dto.getUserid()%>">삭제하기</a>
					</td>
				</tr>
			<%		
				}
			
			%>

			
		</table>
		
		
		

</body>
</html>
```

---

> **update_form**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="C04.UserDto,C09.DBUtils,java.util.*" %>
<%
	String userid = request.getParameter("userid");
	UserDto userDto = DBUtils.getInstance().selectOneUser(userid);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--  
		1. dbutils에서 UserDto selectOneUser(String userid) 를 받아 단건 조회가 되도록 코드 생성
		2. selectOneUser함수를 이용해서 해당 사용자 정보 받아와서 form>input에 각각 표시
		3. dbutils에서 int updateUser(UserDto userDto)를 생성 -> Update 처리코드
		4. update_form.jsp 에서 수정요청 버튼 클릭하면 ./update.jsp에서 업데이트 처리
		5. 처리완료이후 selectAll.jsp 이동	
	-->

	<h1>USER UPDATE</h1>
	<form action="./update.jsp">
		<input type="text" name="userid" value="<%=userDto.getUserid() %>" /> <br/>
		<input type="text" name="password"  value="<%=userDto.getPassword() %>" /> <br/>
		<input type="text" name="role" value="<%=userDto.getRole() %>" /> <br/>
		<button>수정요청</button>
		<a href="javascript:history.go(-1)">이전으로</a>
	</form>
	
</body>
</html>

```

---

> update
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="C04.UserDto,C09.DBUtils,java.util.*" %>
<%
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	String role = request.getParameter("role");
	
	int result = DBUtils.getInstance().updateUser(new UserDto(userid,password,role));
	
	if(result>0)
		out.println("<script>alert('update 성공');location.href='./selectAll.jsp'</script>");
	else
		out.println("<script>alert('update 실패');location.href='history.go(-1)'</script>");
	
%>    
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

> **DBUtils**
> 

```jsx
package C09;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import C04.UserDto;

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
	
	//3-4
	public int insertUser(UserDto userDto) throws Exception {
		
		pstmt = conn.prepareStatement("insert into tbl_user values(?,?,?)");
		pstmt.setString(1, userDto.getUserid());
		pstmt.setString(2, userDto.getPassword());
		pstmt.setString(3, userDto.getRole());
		int result = pstmt.executeUpdate();
		
		conn.commit();
		
		pstmt.close();
		return result; 
	}
	public int updateUser(UserDto userDto) throws Exception {
		
		pstmt = conn.prepareStatement("update TBL_USER set password=?,role=? where userid=?");
		pstmt.setString(1, userDto.getPassword());
		pstmt.setString(2, userDto.getRole());
		pstmt.setString(3, userDto.getUserid());
		int result = pstmt.executeUpdate();
		
		conn.commit();
		
		pstmt.close();
		return result; 
	}
	public List<UserDto> selectAllUser() throws Exception{
		
		pstmt = conn.prepareStatement("select * from TBL_USER");
		rs =  pstmt.executeQuery();
		List<UserDto> list = new ArrayList();
		UserDto userDto = null;
		if(rs != null) {
			while(rs.next()) {
				userDto = new UserDto();
				userDto.setUserid(rs.getString("userid"));
				userDto.setPassword(rs.getString("password"));
				userDto.setRole(rs.getString("role"));
				list.add(userDto);
			}	
		}
		rs.close();
		pstmt.close();
		return list;
	}
	
	public UserDto selectOneUser(String userid) throws Exception {
		pstmt = conn.prepareStatement("select * from TBL_USER where userid=?");
		pstmt.setString(1, userid);
		rs =  pstmt.executeQuery();
		
		UserDto userDto = null;
		if(rs != null) {
			rs.next();
			userDto = new UserDto();
			userDto.setUserid(rs.getString("userid"));
			userDto.setPassword(rs.getString("password"));
			userDto.setRole(rs.getString("role"));
		}
		rs.close();
		pstmt.close();
		return userDto;
	}
	
}

```

---