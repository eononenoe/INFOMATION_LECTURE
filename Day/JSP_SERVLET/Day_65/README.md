# 01

> **01PageContext**
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
<%
	System.out.println("pageContext : " + pageContext);
	System.out.println("pageContext's get request : " + pageContext.getRequest());
	System.out.println("pageContext's get response : " + pageContext.getResponse());
	System.out.println("pageContext's get session : " + pageContext.getSession());
	System.out.println("pageContext's get application : " + pageContext.getServletContext());
	
	System.out.println("project path : " + pageContext.getServletContext().getContextPath());

%>

<!-- 표현식 -->
PROJECTPATH : <%=pageContext.getServletContext().getContextPath()%>
<hr />
<!-- EL -->
PROJECTPATH(EL): ${pageContext.request.contextPath}
</body>
</html>
```

---

> **02Request**
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
<%
String protocol = request.getProtocol();
String serverName = request.getServerName();
int serverPort = request.getServerPort();
String removeAddr = request.getRemoteAddr();
String remoteHost = request.getRemoteHost();
String method = request.getMethod();
StringBuffer requestURL = request.getRequestURL();
String requestURI = request.getRequestURI();
String Browser = request.getHeader("User-Agent");
String fileType = request.getHeader("Accept");
%>
	프로토콜 : <%=protocol%> <br />
	서버이름 : <%=serverName %><br />	
	서버포트 : <%=serverPort %><br />	
	고객주소 : <%=removeAddr %><br />	
	고객이름 : <%=remoteHost %><br />	
	요청함수 : <%=method %><br />	
	요청경로 : <%=requestURL %><br />	
	요청경로 : <%=requestURI %><br />	
	브라우저 : <%=Browser %><br />	
</body>
</html>
```

---

> **03Response**
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
<%@page import="java.io.*" %>
<%
//response.sendRedirect("./02Request.jsp");
//response.sendError(HttpServletResponse.SC_REQUEST_TIMEOUT);
//response.sendError(HttpServletResponse.SC_OK,"정상처리완료!");
//404 Error
//response.sendError(HttpServletResponse.SC_NOT_FOUND,"해당 페이지를 찾을수가 없습니다.");
//403 Error
//response.sendError(HttpServletResponse.SC_FORBIDDEN,"접근금지됨!");
//5xx 에러
//response.sendError(HttpServletResponse.SC_BAD_GATEWAY,"서버 장애 발생!");

/* 새로고침 */
/* response.setIntHeader("Refresh",3);*/

/* OutStream 추출 */
/* ServletOutputStream bout = response.getOutputStream();
bout.write('a');
bout.write(98);	//b
bout.flush();
bout.close(); */

PrintWriter o = response.getWriter();
o.write("<h1>HELLOWORLD</h1>");
%>
</body>
</html>
```

---

> **04Download_SingleFile**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@page import="java.io.*" %>

<%
	
	String dirPath = pageContext.getServletContext().getRealPath("/")+"C05\\files\\";
	System.out.println("dirPath : " + dirPath);
	
	try{
		//INPUTSTREAM
		FileInputStream in = new FileInputStream(dirPath+"TEST.txt");
		
		//OUTPUTSTREAM
		out.clear();					//response outStream 을 닫고 버퍼를 비움
		out = pageContext.pushBody();	//현재페이지의 body에 연결
		
		ServletOutputStream bout =  response.getOutputStream();
		
		//Response Header 지정!!!!
		response.setHeader("Content-Type","application/octet-stream;charset-utf-8");
		response.setHeader("Content-Disposition","attachment; filename=TEST.txt");
		byte[] buff = new byte[4096];
		while(true){
			int data = in.read(buff);
			if(data==-1)
				break;
			bout.write(buff,0,data);
			bout.flush();
		}
		bout.close();
		in.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
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

> **05Download_zip**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.io.*,java.util.zip.*" %>
<%

	//Dir경로 생성
	String dirPath = pageContext.getServletContext().getRealPath("/")+"C05\\files\\";
	System.out.println("dirPath : " + dirPath);
	
	File dir = new File(dirPath);
	File fileList[] = dir.listFiles();
	
	for(File f : fileList)
		System.out.println(f);

	try{
		
		FileInputStream in = null;
		ZipEntry zipEntry = null;

		//내장객체(Out)정리
		out.clear();					//response outStream을 닫고 버퍼를 비움
		out = pageContext.pushBody(); 	//현재페이지에 Body 연결
		
		//OutStream 가져오기
		ServletOutputStream bout = response.getOutputStream();
		
		//추가
		ZipOutputStream zout = new ZipOutputStream(bout);
		
		//response의 Header변경(중요!)
		response.setHeader("Content-Type","application/octet-stream;charset-utf-8");
		response.setHeader("Content-Disposition","attachment; filename=ALLFILES.zip");
		
		for(File file : fileList){
			
			in = new FileInputStream(file);	//기본 InputStream 연결
			zipEntry = new ZipEntry(file.getName().toString());// ZipEntry객체 생성
			
			zout.putNextEntry(zipEntry);
			
			while(true){
				int data = in.read();
				if(data==-1)
					break;
				zout.write((byte)data);
			}
			zout.closeEntry();
			in.close();
		}
		zout.flush();
		zout.close();
		bout.close();

		
	}catch(Exception e){
		e.printStackTrace();
	}
%>

```

---

> **06DownloadLink**
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

<a href="04Download_SingleFile.jsp">단일파일 다운로드</a>
<hr/>
<a href="05Download_zip.jsp">ZIP 다운로드</a>

</body>
</html>
```

---

> **07Out**
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
<%
	out.write("<h1>HELLO WORLD</h1>");
%>
</body>
</html>
```

---

> **Jsession_test**
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
	JSESSION TEST PAGE..
</body>
</html>
```

---

# 01

---

> **getSession**
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
	<h1>확인하기</h1>
	
	<div>REQUEST 속성확인</div>
	ID : <%=request.getAttribute("ID1") %> <br />
	PW : <%=request.getAttribute("PW1") %> <br />
	
	<div>SESSION 속성확인</div>
	ID : <%=request.getAttribute("ID2") %> <br />
	PW : <%=request.getAttribute("PW2") %> <br />
</body>
</html>
```

---

> **setSession**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Request 속성 추가 (새로운 요청 시마다 초기화)
	request.setAttribute("ID1","user1");
	request.setAttribute("PW1","1111");
	//Session 속성 추가 (지정된 시간까지 유지, 기본 1800초(30분),단 App종료시 초기화되겠죠?)
	session.setAttribute("ID2","user2");
	session.setAttribute("PW2","2222");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="./getSession.jsp">정보확인</a>
</body>
</html>
```

---

# 02

---

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
<form action="${pageContext.request.contextPath}/C06/02/login.jsp" method="post">
	<div>
		<label>아이디 :</label><span>${username_msg}</span> <br/>
		<input type="text"  name="username"/>
	</div>
	<div>
		<label>패스워드 :</label><span>${password_msg}</span> <br/>
		<input type="text"  name="password"/>
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
	//04 로그인 처리후 MAIN PAGE REDIRECT
	out.println("<script> alert('로그인 성공! MAIN page로 이동합니다.');location.href='main.jsp'</script>");
	
	
	
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

# 03

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
	
	
	<hr/>
<%-- 	<h1>쿠키 확인 (값만확인 : EL)</h1>
	COOKIE1's VALUE  : ${cookie.myCookie1.value}<br/>
	COOKIE1's VALUE  : ${cookie.myCookie2.value}<br/> --%>
	

</body>
</html>
```

---

> **setCookie**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <!--  
    	Cookie
    	문자열 데이터만 저장가능
    	4Kbyte 이하의 공간을 차지
    	여러개의 쿠키 설정가능(최대 300개)
    	도메인당 20개까지 저장가능
    	저장한도를 초과하면 최근에 사용되지 않는 쿠키부터 자동삭제
    -->
    
 <%
	Cookie cookie1 = new Cookie("myCookie1","myCookie1Value");
	cookie1.setMaxAge(30);  //쿠키 유지 시간(-1:기본값 : 파일생성 x,브라우저가 종료될때까지 쿠키 저장)
							//30초 설정

	
	Cookie cookie2 = new Cookie("myCookie2","myCookie2Value");
	cookie2.setMaxAge(60*5);//5분 설정
	cookie2.setPath("/");
		
	response.addCookie(cookie1);
	response.addCookie(cookie2);
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<a href="./getCookie.jsp">쿠키확인하기</a>
</body>
</html>
```

---

> **deleteCookie**
> 

```jsx
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String cookieName = request.getParameter("cookieName");
	System.out.println("cookieName : " + cookieName);
	
	if(cookieName!=null)
	{
		Cookie cookie = new Cookie(cookieName.trim(), null);	//빈 Value의 쿠키 생성
		cookie.setMaxAge(0);	//쿠키유지시간0초(만료설정)
		cookie.setPath("/");	//쿠키적용 URI 설정(/ : 모든 영역)
		response.addCookie(cookie);//만료처리 전달
	}
		
	

	out.println("<script>alert('쿠키삭제완료!'); location.href='getCookie.jsp'; </script>");
	//만료쿠키 전달후 다음이동 위치 전달(REDIRECT)
	//response.sendRedirect("./getCookie.jsp");
%>

```

---
