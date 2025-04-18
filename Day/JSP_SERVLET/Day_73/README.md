## Controller
`FrontController.java`
```java
package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.book.BookCreateController;
import Controller.book.BookDeleteController;
import Controller.book.BookListController;
import Controller.book.BookReadController;
import Controller.book.BookUpdateController;
import Controller.user.AdminMainController;
import Controller.user.ManagerMainController;
import Controller.user.UserCreateController;
import Controller.user.UserLoginController;
import Controller.user.UserLogoutController;
import Controller.user.UserMainController;

//@WebServlet("/")
public class FrontController extends HttpServlet {
	// 서브컨트롤러 저장 자료구조("/endPoint":서브컨트롤러객체)
	private Map<String, SubController> map = new HashMap();

	@Override
	public void init(ServletConfig config) throws ServletException {

		ServletContext context = config.getServletContext();
		try {
			// 기본
			map.put("/", new HomeController());
			map.put("/index.do", new HomeController());
			// ROLE별 메인
			map.put("/user/user", new UserMainController());
			map.put("/user/manager", new ManagerMainController());
			map.put("/user/admin", new AdminMainController());
			
			// 인증(/user/*) - 회원CRUD , 로그인 , 로그아웃
			map.put("/user/create", new UserCreateController());
			map.put("/user/login", new UserLoginController());
			map.put("/user/logout", new UserLogoutController());
			
			
			// 도서(/book/*) - 도서CRUD
			map.put("/book/list", new BookListController());
			map.put("/book/create", new BookCreateController());
			map.put("/book/read", new BookReadController());
			map.put("/book/update", new BookUpdateController());
			map.put("/book/delete", new BookDeleteController());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("서브컨트롤러 등록오류");
		}

	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
			System.out.println("[FC] service...");
			String endPoint = req.getServletPath(); // ProjectPath 제외 EndPoint만
			System.out.println("[FC] endpoint .." + endPoint);
			SubController controller = map.get(endPoint); // 요청사항을 처리할 SubController get
			controller.execute(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			exceptionHandler(e,req);
			req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
		}
	}

	// 예외처리함수
	public void exceptionHandler(Exception e,HttpServletRequest req) {
		
		req.setAttribute("status", false);
		req.setAttribute("message", e.getMessage());
		req.setAttribute("exception", e);
	}

}

```
---
## Controller/book
`BookCreateController.java`
```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookCreateController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
	
	
	private BookServiceImpl bookService;

	public BookCreateController() throws Exception{
		this.bookService = BookServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] BookCreateController execute..");
		
		try {
			String uri = req.getMethod();
			
			if(uri.equals("GET")) {
				req.getRequestDispatcher("/WEB-INF/view/book/create.jsp").forward(req, resp);
				return ;
			}
	
			//파라미터
			String bookCode = req.getParameter("bookCode");
			String bookName = req.getParameter("bookName");
			String publisher = req.getParameter("publisher");
			String isbn = req.getParameter("isbn");
			
			BookDto bookDto = new BookDto(bookCode,bookName,publisher,isbn);
			//유효성
			if(!isValid(bookDto)) {
				req.getRequestDispatcher("/WEB-INF/view/book/create.jsp").forward(req, resp);
				return ;
			}
			//서비스
			boolean isadded =  bookService.bookRegistration(bookDto);
			
			//뷰
			if(isadded) {
				resp.sendRedirect(req.getContextPath()+"/book/list");
			}else {
				req.getRequestDispatcher("/WEB-INF/view/book/create.jsp").forward(req, resp);
			}
			
		}catch(Exception e) {
			exceptionHandler(e);
			try {
				req.getRequestDispatcher("/WEB-INF/view/book/error.jsp").forward(req, resp);
			}catch(Exception e2) {}
		}

	}

	private boolean isValid(BookDto bookDto) {
		if(bookDto.getBookCode().isEmpty()) {
			req.setAttribute("bookCode", "BookCode를 입력하세요");
		}
		if(bookDto.getBookName().isEmpty()) {
			req.setAttribute("bookName", "BookName를 입력하세요");
		}
		if(bookDto.getPublisher().isEmpty()) {
			req.setAttribute("publisher", "출판사명을 입력하세요");
		}
		if(bookDto.getIsbn().isEmpty()) {
			req.setAttribute("isbn", "isbn을 입력하세요");
		}		
		if(
				bookDto.getBookCode().isEmpty() || 
				bookDto.getBookName().isEmpty() ||
				bookDto.getPublisher().isEmpty() ||
				bookDto.getIsbn().isEmpty()
				)
			return false;
		
		return true;		
	}
	
	// 예외처리함수
	public void exceptionHandler(Exception e) {
		req.setAttribute("status", false);
		req.setAttribute("message", e.getMessage());
		req.setAttribute("exception", e);
	}
}

```
---
`BookReadController.java`
```java
package Controller.book;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.BookServiceImpl;

public class BookReadController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
	
	
	private BookServiceImpl bookService;

	public BookReadController() throws Exception{
		this.bookService = BookServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] BookReadController execute..");
		
		try {
			//파라미터
			String bookCode = req.getParameter("bookCode");
			String pageno = req.getParameter("pageno");
			
			//유효성
			if(!isValid(bookCode)) {
//				req.setAttribute("message", "유효성 체크 오류!");
				resp.sendRedirect(req.getContextPath()+"/book/list");
			}
			//서비스
			Map<String,Object> serviceResponse = bookService.getBook(bookCode);
			
			Boolean status = (Boolean)serviceResponse.get("status");
			if(status)
				req.setAttribute("bookDto", serviceResponse.get("bookDto"));
			
			req.setAttribute("pageno", pageno);
			//뷰
			req.getRequestDispatcher("/WEB-INF/view/book/read.jsp").forward(req, resp);
			
		}catch(Exception e) {
			exceptionHandler(e);
			try {
				req.getRequestDispatcher("/WEB-INF/view/book/error.jsp").forward(req, resp);
			}catch(Exception e2) {}
		}

	}

	private boolean isValid(String bookCode) {
		if(bookCode.isEmpty()) {
			req.setAttribute("bookCode", "BookCode 유효성 오류");
		}
		return true;		
	}
	
	// 예외처리함수
	public void exceptionHandler(Exception e) {
		req.setAttribute("status", false);
		req.setAttribute("message", e.getMessage());
		req.setAttribute("exception", e);
	}
}

```
---
`UserCreateController.java`
```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.UserDto;
import Domain.Service.UserServiceImpl;

public class UserCreateController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
	
	private UserServiceImpl userService;
	
	public UserCreateController() throws Exception{
		userService = UserServiceImpl.getInstance();	
//		throw new Exception("TESTTSTST");
	}
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] UserCreateController execute..");
		

		try {
			String uri = req.getMethod();
			if(uri.equals("GET")) {
				req.getRequestDispatcher("/WEB-INF/view/user/create.jsp").forward(req, resp);
				return ;
			}
			
			//파라미터(username,password)
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			String role = "ROLE_USER";
			//입력값검증
			UserDto userDto = new UserDto(username,password,role);
			boolean isOk = isValid(userDto);
			if(!isOk) {
				req.getRequestDispatcher("/WEB-INF/view/user/create.jsp").forward(req, resp);
				return ;
			}
			
			//서비스
			boolean isJoin =  userService.userJoin(userDto);
		
			//뷰
			if(isJoin) {
				resp.sendRedirect(req.getContextPath()+"/index.do");
			}else {
				req.getRequestDispatcher("/WEB-INF/view/user/join.jsp").forward(req, resp);
			}
			
			
		}catch(Exception e) {
			exceptionHandler(e);
			try {
				req.getRequestDispatcher("/WEB-INF/view/user/error.jsp").forward(req, resp);
			}catch(Exception e2) {}
		}

	}

	private boolean isValid(UserDto userDto) {
		if (userDto.getUsername() == null || userDto.getUsername().length() <= 4) {
			req.setAttribute("username_err", "userid의 길이는 최소 5자이상이어야합니다");
			System.out.println("[INVALID] userid의 길이는 최소 5자이상이어야합니다");
			return false;
		}
		if (userDto.getUsername().matches("^[0-9].*")) {
			System.out.println("[INVALID] userid의 첫문자로 숫자가 들어올수 없습니다");
			req.setAttribute("username_err", "userid의 userid의 첫문자로 숫자가 들어올수 없습니다");
			return false;
		}
		// NULL 체크 / 데이터(자료)수준에서의 의미있는데이터가 포함되어져있는지 여부
		// userid 은 첫문자가 숫자인지 여부 - /or 길이가 1글자인지 등등..
		// username 은 첫문자가 숫자인지 여부 -
		// password 복잡도체크는 Business Layer 체크(Policy 에 의한 처리)

		return true;
	}
	// 예외처리함수
	public void exceptionHandler(Exception e) {
		req.setAttribute("status", false);
		req.setAttribute("message", e.getMessage());
		req.setAttribute("exception", e);
	}
}

```
---
## WEB-INF/view/book
`create.jsp`
```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- link -->
	<%@include file="/resources/layouts/link.jsp" %>
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="wrapper">
		<header>
			<!-- topHeader -->
			<%@include file="/resources/layouts/topHeader.jsp" %>
			<!-- nav -->
			<%@include file="/resources/layouts/nav.jsp" %>
		</header>
		<main  class="layout">
			<h1>/BOOK/CREATE</h1>
			<form action="${pageContext.request.contextPath}/book/create" method="post">
				<div>
					<label for="">bookCode : </label><span>${bookCode}</span><br/>
					<input type="text" name="bookCode"  placeHolder="bookCode" />
				</div>
				<div>
					<label for="">bookName : </label><span>${bookName}</span><br/>
					<input type="text" name="bookName"  placeHolder="bookName" />
				</div>
				<div>
					<label for="">publisher : </label><span>${publisher}</span><br/>
					<input type="text" name="publisher"  placeHolder="publisher" />
				</div>
				<div>
					<label for="">isbn : </label><span>${isbn}</span><br/>
					<input type="text" name="isbn" placeHolder="isbn" />
				</div>
				<div>
					<button>도서등록</button>
				</div>
			</form>
		</main>
		
		
		<!-- footer -->
		<%@include file="/resources/layouts/footer.jsp" %>
	</div>

	
</body>
</html>








```
---
`read.jsp`
```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- link -->
	<%@include file="/resources/layouts/link.jsp" %>
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="wrapper">
		<header>
			<!-- topHeader -->
			<%@include file="/resources/layouts/topHeader.jsp" %>
			<!-- nav -->
			<%@include file="/resources/layouts/nav.jsp" %>
		</header>
		<main  class="layout">
			<h1>/BOOK/READ</h1>
			<form action="${pageContext.request.contextPath}/book/update" method="post">
				<div>
					<label for="">bookCode : </label><span>${bookCode}</span><br/>
					<input type="text" name="bookCode"  placeHolder="bookCode" value="${bookDto.bookCode}"  readonly/>
				</div>
				<div>
					<label for="">bookName : </label><span>${bookName}</span><br/>
					<input type="text" name="bookName"  placeHolder="bookName"  value="${bookDto.bookName}"/>
				</div>
				<div>
					<label for="">publisher : </label><span>${publisher}</span><br/>
					<input type="text" name="publisher"  placeHolder="publisher" value="${bookDto.publisher}" />
				</div>
				<div>
					<label for="">isbn : </label><span>${isbn}</span><br/>
					<input type="text" name="isbn" placeHolder="isbn"  value="${bookDto.isbn}"/>
				</div>
				<input type="hidden" name="pageno" value='${pageno}' />
				<div>
					<button>도서수정</button>
					<a href="${pageContext.request.contextPath}/book/delete?bookCode=${bookDto.bookCode}&pageno=${pageno}">도서삭제</a>
				</div>
			</form>
		</main>
		
		
		
		<!-- footer -->
		<%@include file="/resources/layouts/footer.jsp" %>
	</div>

	
</body>
</html>








```
---
`create.jsp`
```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- link -->
	<%@include file="/resources/layouts/link.jsp" %>
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="wrapper">
		<header>
			<!-- topHeader -->
			<%@include file="/resources/layouts/topHeader.jsp" %>
			<!-- nav -->
			<%@include file="/resources/layouts/nav.jsp" %>
		</header>
		<main  class="layout">
		
			<h1>USER JOIN</h1>
			<form action="${pageContext.request.contextPath}/user/create" method="post">
				USERNAME : <input name="username" /><br/>
				PASSWORD : <input name="password" /><br/>
				<button>회원가입</button>
			</form>
			<div>
				${username_err}
			</div>
		</main>
		
		
		<!-- footer -->
		<%@include file="/resources/layouts/footer.jsp" %>
	</div>

	
</body>
</html>








```