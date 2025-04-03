# 01

> **C05ReqNavStyle**
> 

```jsx
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--  
		col1,col2,col3,col4를 03Result.jsp 에서 받아서
		NavBar를 만들어보세요
		03Ex에서 전달하는 컬럼명을 적용해서 nav 를 만듭니다
		style로 전달받은 스타일링코드를 그대로 적용시켜봅니다
	-->
	<form action="C05Result.jsp">
		<h2>NAV 만들기</h2>
		<input name="col1" placeholder="열이름1">
		<input name="col2" placeholder="열이름2">
		<input name="col3" placeholder="열이름3">
		<input name="col4" placeholder="열이름4">
		<input name="style" placeholder="Nav기본 스타일Code">
		<button>페이지 생성 요청</button>
	</form>	
	
</body>
</html>
</body>
</html>
```

---

> **C05Result**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String col1 = request.getParameter("col1");
	String col2 = request.getParameter("col2");
	String col3 = request.getParameter("col3");
	String col4 = request.getParameter("col4");
	String navStyle = request.getParameter("style");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	ul{
		list-style:none;
		padding:0;
		margin:0;
	}
	header{
		width:100%;
	}
</style>
</head>
<body>

	<div class="wrapper">
		<header>
			<div class="top-header"></div>
			<nav>
				<ul style="<%=navStyle%>">
					<li><%=col1 %></li>
					<li><%=col2 %></li>
					<li><%=col3 %></li>
					<li><%=col4 %></li>
				</ul>
			</nav>
		</header>
		<main>
			<section></section>
		</main>
		<footer></footer>
	</div>

	 

</body>
</html>
```

---

# 01Page

---

> **01Import**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Scanner,C03.SimpleDto" %>    
<%
	Scanner sc = new Scanner(System.in);

	SimpleDto dto = new SimpleDto("홍길동",55,"대구");
	System.out.println("DTO : " + dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 name : <%=dto.getName() %> <br/>
 age : <%=dto.getAge() %> <br/>
 addr : <%=dto.getAddr() %><br/>
	
</body>
</html>
```

---

> **02Error**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>ERROR PAGE...</h1>
	<hr/>
	<%=exception.getMessage() %>

</body>
</html>
```

---

> **02Index**
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

	<form action="02Main.jsp">
		<input type="text" name="name" /><br>
		<input type="text" name="age"/><br>
		<input type="text" name="addr"/><br>
		<button>전송</button>
	</form>

</body>
</html>
```

---

> **02Main**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="02Error.jsp" %>
<%
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String addr = request.getParameter("addr");
	if(name.isEmpty())
		throw new Exception("이름을 입력하세요");
	if(age.isEmpty())
		throw new Exception("나이를 입력하세요");
	if(addr.isEmpty())
		throw new Exception("주소를 입력하세요");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 : <%=name %><br>
나이 : <%=age %><br>
주소 : <%=addr %><br>

</body>
</html>
```

---

# **02Include**

---

> **Footer**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <footer>FOOTER영역</footer>
```

---

> **Nav**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	nav{background-color:green; color:white}
</style>
   <!-- NAV -->
   <nav>NAV 영역</nav>
```

---

> **TopHeader**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- TOP-HEADER -->
<div class="top-header">TOP-HEADER영역</div>
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
	*{box-sizing:border-box;padding:10px; border:1px solid;}
	a{}
	ul{}
	body{padding : 0; margin:0;}
	.wrapper{
		height : 100%;
	}
	.wrapper>header{min-height:100px;}
	.wrapper>header>.top-header{min-height:25px;}
	.wrapper>header>.nav{min-height:75px;}
	.wrapper>main{
		min-height :calc(100vh - 100px - 250px);
	};
	.wrapper>main>section{
		
	}
	.wrapper>footer{min-height:250px;}
</style>

</head>
<body>

	<div class="wrapper">
		<header>
			<!--  -->
			<%@ include file="./layouts/TopHeader.jsp" %>
			<!--  -->
			<%@ include file="./layouts/Nav.jsp" %>
		</header>
		<main>
			<section>MAIN>SECTION 영역</section>
		</main>
		
		<!--  -->
		<%@ include file="./layouts/Footer.jsp" %>
	</div>
	

</body>
</html>
```

---

# Forward

---

> **01Start**
> 

```jsx
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!--  
	Forward방식 페이지 요청 : Request내용은 유지한채 또다른 Page경로로 이동
	클라이언트의 URL경로는 최초요청시의 URL로 유지가 된다
	Request객체의 내용은 최초요청내용이 유지된다(Forward 되는 동안만)
	
	하나의 요청-응답 주기를 가진다
-->

	<form action="02Page.jsp">
		<input type="text" name="username" />
		<input type="text" name="password" />
		<button>전송</button>
	</form>
	

</body>
</html>
```

---

> **02Page**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	<%
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		System.out.println("----------02PAGE-------------");
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		System.out.println("-----------------------------");
		
		request.setAttribute("02Page", "02PageValue");
		/* FORWARDING */
		request.getRequestDispatcher("./03Page.jsp").forward(request,response);
		
	%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>02PAGE</h1>
	USERNAME : <%=username %><br>
	PASSWORD : <%=password %><br>
</body>
</html>
```

---

> **03Page**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     	<%
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String Page02Value = (String)request.getAttribute("02Page");
		System.out.println("----------03PAGE-------------");
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		System.out.println("Page02Value : " + Page02Value);
		System.out.println("-----------------------------");
		
		/* FORWARDING */
		request.setAttribute("03Page", "03Page's Value");
		request.getRequestDispatcher("./04Result.jsp").forward(request,response);
	%>  
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>03PAGE</h1>

</body>
</html>
```

---

> **04Result**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     	<%
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String Page02Value = (String)request.getAttribute("02Page");
		String Page03Value = (String)request.getAttribute("03Page");
		System.out.println("----------RESULT-------------");
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		System.out.println("Page02Value : " + Page02Value);
		System.out.println("Page03Value : " + Page03Value);
		System.out.println("-----------------------------");
		
	%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>RESULT PAGE</h1>
	<%=username %><br/>
	<%=password %><br/>
	<%=Page02Value %><br/>
	<%=Page03Value %><br/>
</body>
</html>
```

---

# Redirect

---

> **01Start**
> 

```jsx
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
		Redirect : 서버가 클라이언트에게 새로운 요청 URL 경로를 전달
		클라이언트는 서버가 제시간 URL 경로로 새롭게 페이지 요청
		Request객체와 Response객체는 redirect 횟수만큼 새로운 값으로 대체
	
	 -->

	<form action="02Page.jsp">
		<input type="text" name="username" />
		<input type="text" name="password" />
		<button>전송</button>
	</form>
	
</body>
</html>
```

---

> **02Page**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.net.*" %>
 	<%
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		System.out.println("----------02PAGE-------------");
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		System.out.println("-----------------------------");
		
		request.setAttribute("02Page", "02PageValue");
		/* REDIRECT */
		response.sendRedirect("./03Page.jsp?hobby="+URLEncoder.encode("등산","UTF-8"));
	%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>02PAGE</h1>
	USERNAME : <%=username %><br>
	PASSWORD : <%=password %><br>
</body>
</html>
```

---

> **03Page**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String Page02Value = (String)request.getAttribute("02Page");
		
		System.out.println("----------03PAGE-------------");
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		System.out.println("Page02Value : " + Page02Value);
		System.out.println("-----------------------------");
		
		String hobby=request.getParameter("hobby");
		System.out.println("hobby : " + hobby);
		/* REDIRECt */
		response.sendRedirect("./04Result.jsp");
		
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>03PAGE</h1>

</body>
</html>
```

---

> **04Result**
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

	<h1>04 RESULT</h1>

</body>
</html>
```

---

> **dbUtils**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="./errors.jsp"%>

<!--속성/기능추가  -->
<%@page import="java.sql.*,C04.*"%>
<%!//속성/기능 추가가능
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String id = "system";
	private String pw = "1234";

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private void getConnection() throws Exception {
		if (conn == null) {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
		}
	}

	private int insert(UserDto userDto) throws Exception {

		pstmt = conn.prepareStatement("insert into TBL_USER values(?,?,?)");
		pstmt.setString(1, userDto.getUserid());
		pstmt.setString(2, userDto.getPassword());
		pstmt.setString(3, userDto.getRole());
		int result = pstmt.executeUpdate();

		conn.commit();

		pstmt.close();

		return result;

	}
	
	private UserDto selectOne(String userid) throws Exception{
		pstmt = conn.prepareStatement("select * from TBL_USER where userid='"+userid+"'");
		rs =  pstmt.executeQuery();
		UserDto userDto=null;
		if(rs!=null){
			if(rs.next()){
				userDto = new UserDto();
				userDto.setUserid(userid);
				userDto.setPassword(rs.getString("password"));
				userDto.setRole(rs.getString("role"));			
			}
		}
		rs.close();
		pstmt.close();
		return userDto;
	}
	
	%>

<!-- Service 함수 -->
<%
	/* 요청 정보확인 */
	String url = (String) request.getAttribute("url"); //
	Integer serviceNo = (Integer) request.getAttribute("serviceNo");
	System.out.println("URL : " + url);
	System.out.println("SERVICENO : " + serviceNo);
	
	if (url.contains("/join")) {
		getConnection();
	
		UserDto userDto = (UserDto) request.getAttribute("userDto");
	
		if (insert(userDto) > 0) {
			response.sendRedirect("login_form.jsp"); //redirect 다수 사용시 return 예약어 사용
			return;
		}
	
	}
	if (url.contains("/myinfo")) {
		request.setAttribute("isConfirm",true);
		
		getConnection();
		String userid = request.getParameter("userid");
		UserDto userDto = selectOne(userid);
		request.setAttribute("myinfo-result", userDto);	
		request.getRequestDispatcher("./myinfo.jsp").forward(request,response); //forwarding 처리 - !
		return ;
		
	
	}
%>

```

---

> **errors**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>JOIN ERROR PAGE...</h1>
	<hr/>
	<%=exception.getMessage() %>

</body>
</html>
```

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
<style>
	:root{}
	*{box-sizing:border-box;padding:10px; border:1px solid;}
	a{}
	ul{}
	body{padding : 0; margin:0;}
	.wrapper{
		height : 100%;
	}
	.wrapper>header{min-height:100px;}
	.wrapper>header>.top-header{min-height:25px;}
	.wrapper>header>.nav{min-height:75px;}
	.wrapper>main{
		min-height :calc(100vh - 100px - 250px);
	};
	.wrapper>main>section{
		
	}
	.wrapper>footer{min-height:250px;}
</style>

</head>
<body>
	<div class="wrapper">
		<header>
			<!-- top-header insert 지시자 이용해서 가져오기 -->
			<%@include file="./layouts/TopHeader.jsp" %>
			<!-- nav Insert 지시자 이용해서 가져오기 -->
			<%@include file="./layouts/Nav.jsp" %>
		</header>
		<main>
			<section>
				<!--  
						form태그로 
						userid
						password
						join.jsp 로 회원가입 요청 처리			
				-->
				<h1>JOIN </h1>
				<form action="join.jsp" method="post">
					<input type="text" name="userid" /><br> 
					<input type="text"name="password" /><br> 
					<input type="submit" value="회원가입" />
				</form>
			</section>

		</main>
		<!-- footer insert 지시자 이용해서 가져오기 -->
		<%@include file="./layouts/Footer.jsp" %>
	</div>

</body>
</html>
```

---

> **join**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--  
		UserDto객체에 전달받은 파라미터(userid,password)를 저장
		request에  setAttribute로 userDto 저장("userDto",userDto);
		validationCheck.jsp 로 forwarding
-->
<%@page import="C04.UserDto" %>
<%
	//userDto 객체 생성
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	
	UserDto userDto = new UserDto(userid,password,"ROLE_USER");

	//request 내장객체 userDto 추가
	request.setAttribute("userDto", userDto);
	
	// 에러 미발생시 dbUtils.jsp 로 해당 내용 Forwarding
	request.setAttribute("url","/join");	//DB 요청 처리
	request.setAttribute("serviceNo",1); 	// ServiceNo C : 1 R : 2 U : 3 D : 4
	
	//forwarding 
	request.getRequestDispatcher("./validationCheck.jsp").forward(request,response);
%>
```

---

> **login_form**
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
	*{box-sizing:border-box;padding:10px; border:1px solid;}
	a{}
	ul{}
	body{padding : 0; margin:0;}
	.wrapper{
		height : 100%;
	}
	.wrapper>header{min-height:100px;}
	.wrapper>header>.top-header{min-height:25px;}
	.wrapper>header>.nav{min-height:75px;}
	.wrapper>main{
		min-height :calc(100vh - 100px - 250px);
	};
	.wrapper>main>section{
		
	}
	.wrapper>footer{min-height:250px;}
</style>

</head>
<body>
	<div class="wrapper">
		<header>
			<!-- top-header insert 지시자 이용해서 가져오기 -->
			<%@include file="./layouts/TopHeader.jsp" %>
			<!-- nav Insert 지시자 이용해서 가져오기 -->
			<%@include file="./layouts/Nav.jsp" %>
		</header>
		<main>
			<section>
				<h1>LOGIN</h1>
				<form action="login.jsp" method="post">
					<input type="text" name="userid" /><br> 
					<input type="text"name="password" /><br> 
					<input type="submit" value="로그인" />
				</form>
			</section>

		</main>
		<!-- footer insert 지시자 이용해서 가져오기 -->
		<%@include file="./layouts/Footer.jsp" %>
	</div>

</body>
</html>
```

---

> **validationCheck**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="./errors.jsp"%>

<%@page import="C04.*" %>
<%

	// request로부터 전달받은 userDto 값 꺼내서  System.out 확인
	// 받은 username,password 값이 null인지여부를 체크(String API trim()  + isEmpty() 이용)
	// 에러발생시 처리되는 페이지로 전달(error.jsp)
	
	
	//url선별 serviceNo 선별 -> 유효성체크 
	

	
	String url = (String)request.getAttribute("url");
	Integer serviceNo = (Integer)request.getAttribute("serviceNo");
	
	if(url.contains("/join")){
		// /join 
		UserDto userDto = (UserDto)request.getAttribute("userDto");
		isValid(userDto);
	}else if(url.contains("/myinfo")){
		// /myinfo
		String userid = request.getParameter("userid");
		isValid(userid);
	}
	
	request.getRequestDispatcher("./dbUtils.jsp").forward(request,response);
%>

<%! 
	void isValid(UserDto userDto) throws Exception{
		System.out.println("[VALIDATION CHECK] userDto : " + userDto);
		if(userDto == null)
			throw new Exception("userDto가 NULL 입니다..");
		if(userDto.getUserid().trim().isEmpty())
			throw new Exception("userid를 입력하세요..");
		if(userDto.getPassword().trim().isEmpty())
			throw new Exception("password를 입력하세요..");
		if(userDto.getRole().trim().isEmpty())
			throw new Exception("기본 역할(ROLE_USER)이 지정되지 않았습니다..");
	}

	void isValid(String userid) throws Exception{
		if(userid.trim().isEmpty())
			throw new Exception("userid를 입력하세요..");
	}
%>

```

---

> **myinfo_form**
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
	*{box-sizing:border-box;padding:10px; border:1px solid;}
	a{}
	ul{}
	body{padding : 0; margin:0;}
	.wrapper{
		height : 100%;
	}
	.wrapper>header{min-height:100px;}
	.wrapper>header>.top-header{min-height:25px;}
	.wrapper>header>.nav{min-height:75px;}
	.wrapper>main{
		min-height :calc(100vh - 100px - 250px);
	};
	.wrapper>main>section{
		
	}
	.wrapper>footer{min-height:250px;}
</style>

</head>
<body>
	<div class="wrapper">
		<header>
			<!-- top-header insert 지시자 이용해서 가져오기 -->
			<%@include file="./layouts/TopHeader.jsp" %>
			<!-- nav Insert 지시자 이용해서 가져오기 -->
			<%@include file="./layouts/Nav.jsp" %>
		</header>
		<main>
			<section>

				<!--  
					1. myinfo.jsp(생성)
						
					2. vaildationCheck.jsp
						- 유효성 체크
					3. dbUils.jsp(기존) 
						- select 작업 조회이후 forwarding
					4. myinfoResult.jsp(내용표시)				
						- 
				-->
				<h1>MYINFO </h1>
				<form action="myinfo.jsp" method="post">
					<input type="text" name="userid" /><br>
					<input type="submit" value="조회" />
				</form>
			</section>

		</main>
		<!-- footer insert 지시자 이용해서 가져오기 -->
		<%@include file="./layouts/Footer.jsp" %>
	</div>

</body>
</html>
```

---

> **myinfo**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%!
		//public static boolean isConfirm;	 //false가 기본값
	%>
    <%
    	//DB 조회 여부 확인
    	Boolean isConfirm =  (request.getAttribute("isConfirm")!=null)?
    								(Boolean)request.getAttribute("isConfirm")
    								:null;
    
    	if(isConfirm!=null && isConfirm==true){
				; //현재위치에서 내용 표시	
				
    	}else{
			// 에러 미발생시 dbUtils.jsp 로 해당 내용 Forwarding
			request.setAttribute("url","/myinfo");	//DB 요청 처리
			request.setAttribute("serviceNo",2); 	// ServiceNo C : 1 R : 2 U : 3 D : 4
	    	request.getRequestDispatcher("./validationCheck.jsp").forward(request,response);
			return ;
    	}
    
    %>
  
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>Document</title>
</head>
<body>
		<h1>MYINFO 확인(DBUtils's로부터 Forwarding 처리된 화면)</h1>
		결과 : <%=request.getAttribute("myinfo-result") %>
</body>
</html>
  
  
  
  
    
```

---

> **.UserDto**
> 

```jsx
package C04;

public class UserDto {
	private String userid;
	private String password;
	private String role;
	//생성자/getterandsetter/toSTring
	@Override
	public String toString() {
		return "UserDto [userid=" + userid + ", password=" + password + ", role=" + role + "]";
	}
	public UserDto(String userid, String password, String role) {
		super();
		this.userid = userid;
		this.password = password;
		this.role = role;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	UserDto() {}
	
	
}

```

---