## Controller/book

---
`BookDeleteController.java`
```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookDeleteController implements SubController {
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private BookServiceImpl bookService;

	public BookDeleteController() throws Exception {
		this.bookService = BookServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] BookDeleteController execute..");

		try {
			// 파라미터
			String bookCode = req.getParameter("bookCode");
			String pageno = req.getParameter("pageno")!=null?req.getParameter("pageno"):"1";
			
			// 유효성
			if (!isValid(bookCode)) {
				resp.sendRedirect(req.getContextPath() + "/book/read?bookCode=" + bookCode);
			}

			// 서비스
			boolean isDelete = bookService.removeBook(bookCode);

			// 뷰
			resp.sendRedirect(req.getContextPath() + "/book/list?pageno="+pageno);

		} catch (Exception e) {
			exceptionHandler(e);
			try {
				req.getRequestDispatcher("/WEB-INF/view/book/error.jsp").forward(req, resp);
			} catch (Exception e2) {
			}
		}

	}

	private boolean isValid(BookDto bookDto) {

		return true;
	}

	private boolean isValid(String bookCode) {
		if (true) {
			;
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

## Controller/book

---
`BookUpdateController.java`
```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookUpdateController implements SubController {
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private BookServiceImpl bookService;

	public BookUpdateController() throws Exception {
		this.bookService = BookServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] BookUpdateController execute..");

		try {
			// 파라미터
			String bookCode = req.getParameter("bookCode");
			String bookName = req.getParameter("bookName");
			String publisher = req.getParameter("publisher");
			String isbn = req.getParameter("isbn");
			
			String pageno = req.getParameter("pageno")!=null?req.getParameter("pageno"):"1";
			

			BookDto bookDto = new BookDto(bookCode, bookName, publisher, isbn);

			// 유효성
			if (!isValid(bookDto)) {
				resp.sendRedirect(req.getContextPath() + "/book/read?bookCode=" + bookCode);
			}

			// 서비스
			boolean isUpdate = bookService.modifyBook(bookDto);

			// 뷰
			resp.sendRedirect(req.getContextPath() + "/book/list?pageno="+pageno);

		} catch (Exception e) {
			exceptionHandler(e);
			try {
				req.getRequestDispatcher("/WEB-INF/view/book/error.jsp").forward(req, resp);
			} catch (Exception e2) {
			}
		}

	}

	private boolean isValid(BookDto bookDto) {

		return true;
	}

	private boolean isValid(String bookCode) {
		if (true) {
			;
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

## WEB-INF/view/book

---
`delete.jsp`
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
			<h1>TEMPLATE</h1>
	
		</main>
		
		
		<!-- footer -->
		<%@include file="/resources/layouts/footer.jsp" %>
	</div>

	
</body>
</html>
```
---

## WEB-INF/view/book

---
`update.jsp`
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
			<h1>TEMPLATE</h1>
	
		</main>
		
		
		<!-- footer -->
		<%@include file="/resources/layouts/footer.jsp" %>
	</div>

	
</body>
</html>
```
---

## Controller

---
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

## Controller

---
`SubController.java`
```java
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SubController {
	public void execute (HttpServletRequest req, HttpServletResponse resp);
}
```
---

## Controller

---
`HomeController.java`
```java
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HomeController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		
		this.req = req;
		this.resp = resp;
		try {

			req.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(req, resp);
		}catch(Exception e) {
			exceptionHandler(e);
		}
		
			
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

---
`error.jsp`
```java
[파일 열기 실패: [Errno 2] No such file or directory: '/mnt/data/MVC_BOOK_EXTRACTED/11MVC_BOOK/src/main/webapp/WEB-INF/view/book/error.jsp']
```
---

## WEB-INF/view/book

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

## Domain/Dto

---
`BookDto.java`
```java
package Domain.Dto;

public class BookDto {
	private String bookCode;
	private String bookName;
	private String publisher;
	private String isbn;
	//생성자 , getter and setter toString
	public BookDto() {}
	public BookDto(String bookCode, String bookName, String publisher, String isbn) {
		super();
		this.bookCode = bookCode;
		this.bookName = bookName;
		this.publisher = publisher;
		this.isbn = isbn;
	}
	public String getBookCode() {
		return bookCode;
	}
	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	@Override
	public String toString() {
		return "BookDto [bookCode=" + bookCode + ", bookName=" + bookName + ", publisher=" + publisher + ", isbn="
				+ isbn + "]";
	}
	
}
```
---

## Domain/Service

---
`BookServiceImpl.java`
```java
package Domain.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import Domain.Dao.BookDao;
import Domain.Dao.BookDaoImpl;
import Domain.Dto.BookDto;
import Domain.Dto.Criteria;
import Domain.Dto.PageDto;

public class BookServiceImpl {

	//
	private BookDao bookDao;
	
	//싱글톤 패턴
	private static BookServiceImpl instance;
	private BookServiceImpl() throws Exception{	
		bookDao = BookDaoImpl.getInstance();
	}
	public static BookServiceImpl getInstance() throws Exception{
		if(instance==null)
			instance = new BookServiceImpl();
		return instance;
	}
	
	
	//TX 처리 + 비즈니스 유효성검사(도서추가 -)
	public boolean bookRegistration(BookDto bookDto) throws Exception{
		
		int result = bookDao.insert(bookDto);
		
		return result>0;
		
	}
	
	public Map<String,Object> getAllBooks() throws Exception {
		Map<String,Object> response = new LinkedHashMap();
		
		List<BookDto> list =  bookDao.selectAll();
		if(list.size()>0) {
			response.put("status", true);
			response.put("list", list);
		}else {
			response.put("status", false);
		}

		return response;
	}
	
	
	public Map<String, Object> getAllBooks(Criteria criteria) throws Exception{
		Map<String,Object> response = new LinkedHashMap();
		
		
		if(criteria.getType()==null || criteria.getType().isEmpty())
		{
			int offset = (criteria.getPageno()-1) * criteria.getAmount();	
			
			//페이지별 건수 
			List<BookDto> list =  bookDao.selectAll(offset,criteria.getAmount());
			
			//PageDto
			long totalCount = bookDao.count();
			PageDto pageDto = new PageDto(totalCount,criteria);
			System.out.println("Service pageDto : " + pageDto);
			
			if(list.size()>0) {
				response.put("status", true);
				response.put("list", list);
				response.put("pageDto", pageDto);
			}else {
				response.put("status", false);
			}
		}
		else
		{
			int offset = (criteria.getPageno()-1) * criteria.getAmount();
			//페이지별 건수 
			int amount = criteria.getAmount();
			String type = criteria.getType();
			String keyword = criteria.getKeyword();
			List<BookDto> list =  bookDao.selectAll(offset,amount,type,keyword);
			
			//PageDto
			long totalCount = bookDao.count(criteria);
			PageDto pageDto = new PageDto(totalCount,criteria);
			System.out.println("Service pageDto : " + pageDto);
			
			if(list.size()>0) {
				response.put("status", true);
				response.put("list", list);
				response.put("pageDto", pageDto);
			}else {
				response.put("status", false);
			}
			
		}
		
		
		return response;
	}
	
	
	
	public Map<String, Object> getBook(String bookCode) throws Exception{
		
		Map<String, Object> response = new LinkedHashMap();
		
		BookDto bookDto =  bookDao.select(bookCode);
		
		if(bookDto == null)
			response.put("status", false);
		else {
			response.put("status", true);
			response.put("bookDto", bookDto);
		}
		
		return response;
	}
	public boolean modifyBook(BookDto bookDto) throws Exception{
		
		int result = bookDao.update(bookDto);

		return result>0;
	}
	
	public boolean removeBook(String bookCode) throws Exception{
		
		int result = bookDao.delete(bookCode);

		return result>0;
	}
	
	
}
```
---
