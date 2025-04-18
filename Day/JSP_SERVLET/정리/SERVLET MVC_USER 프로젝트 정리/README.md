# 💻 MVC_USER 프로젝트 정리

---
## 🧠 주요 키워드 설명

- **HttpServlet**: Java에서 웹 요청을 처리하기 위해 사용하는 기본 서블릿 클래스입니다.
- **HttpServletRequest**: 클라이언트의 요청 정보를 담고 있는 객체로, 파라미터, 헤더 등을 읽을 수 있습니다.
- **HttpServletResponse**: 서버의 응답 정보를 담고 있는 객체로, 클라이언트로 출력할 내용을 설정할 수 있습니다.
- **ServletConfig**: 서블릿의 초기화 정보를 담고 있는 객체입니다.
- **ServletContext**: 웹 애플리케이션 전체의 정보를 공유할 수 있는 객체입니다.
- **RequestDispatcher**: 다른 JSP나 서블릿으로 요청을 포워딩할 때 사용합니다.
- **SubController**: FrontController 패턴에서 요청을 실제 처리하는 하위 컨트롤러 역할의 인터페이스입니다.
- **UserDto**: 사용자 정보를 전달하는 데이터 객체입니다. (Data Transfer Object)
- **UserServiceImpl**: 사용자 관련 비즈니스 로직을 수행하는 서비스 클래스입니다.
- **Map**: Java에서 키-값 쌍으로 데이터를 저장하는 자료구조입니다.

---
## 📄 FrontController.java

✍️ **파일 간단 설명**

모든 웹 요청을 처음으로 받아 해당 URI에 따라 적절한 SubController로 위임하는 중앙 제어 역할의 서블릿입니다.

🧩 **코드 일부 발췌**
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

import Controller.user.UserCreateController;
import Controller.user.UserLoginController;
import Controller.user.UserLogoutController;

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
			
			// 인증(/user/*) - 회원CRUD , 로그인 , 로그아웃
			map.put("/user/create", new UserCreateController());
			map.put("/user/login", new UserLoginController());
			map.put("/user/logout", new UserLogoutController());
			
			// 도서(/book/*) - 도서CRUD
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("서브컨트롤러 등록오류");
		}

	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
```

📌 **코드 등장 메서드**

- service
- init
- exceptionHandler

🧠 **흐름 정리**

init()에서 URI와 서브컨트롤러를 연결하는 map을 생성하고, service()에서 실제 요청을 적절한 서브컨트롤러의 execute()로 위임합니다.

### 🔍 추가 개념 설명 (예: FrontController.java 내부)

- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **ioexception**: 입출력 과정에서 발생하는 예외 상황을 처리하는 클래스입니다.
- **map**: Java의 Map 객체는 키-값(key-value) 쌍으로 데이터를 저장하는 자료구조입니다.
- **put**: Map의 put(key, value) 메서드는 특정 키에 대한 값을 저장하거나 덮어씌웁니다.
- **service**: 비즈니스 로직을 처리하는 계층입니다.
- **servletexception**: 서블릿 처리 중 에러가 발생했음을 나타내는 예외 클래스입니다.

---

## 📄 HomeController.java

✍️ **파일 간단 설명**

기본 홈페이지(index.jsp)로 이동시키는 역할의 컨트롤러입니다.

🧩 **코드 일부 발췌**
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

📌 **코드 등장 메서드**

- exceptionHandler
- execute

🧠 **흐름 정리**

execute() 메서드에서 index.jsp로 포워딩하며 예외 발생 시 exceptionHandler로 처리합니다.

### 🔍 추가 개념 설명 (예: HomeController.java 내부)

- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **forward**: JSP나 서블릿으로 요청을 넘길 때 사용되는 동작입니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **requestdispatcher**: 요청을 다른 자원(JSP 등)으로 포워딩할 때 사용하는 객체입니다.
- **setattribute**: 요청이나 세션에 데이터를 저장하는 메서드입니다.

---

## 📄 SubController.java

✍️ **파일 간단 설명**

모든 서브 컨트롤러가 구현해야 하는 인터페이스로, execute() 메서드를 정의합니다.

🧩 **코드 일부 발췌**
```java
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SubController {
	public void execute (HttpServletRequest req, HttpServletResponse resp);
}
```

📌 **코드 등장 메서드**

- execute

🧠 **흐름 정리**

FrontController가 URI에 따라 이 인터페이스를 구현한 컨트롤러의 execute()를 호출하여 동작합니다.

---

## 📄 UserCreateController.java

✍️ **파일 간단 설명**

회원가입을 담당하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
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
```

📌 **코드 등장 메서드**

- exceptionHandler
- isValid
- execute

🧠 **흐름 정리**

GET 요청 시 회원가입 화면으로 이동, POST 요청 시 사용자 정보 유효성 검사 후 userService를 통해 회원가입 로직 실행

### 🔍 추가 개념 설명 (예: UserCreateController.java 내부)

- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **forward**: JSP나 서블릿으로 요청을 넘길 때 사용되는 동작입니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **getparameter**: HTTP 요청에서 전달된 파라미터 값을 가져오는 메서드입니다.
- **requestdispatcher**: 요청을 다른 자원(JSP 등)으로 포워딩할 때 사용하는 객체입니다.
- **service**: 비즈니스 로직을 처리하는 계층입니다.

---

## 📄 UserLoginController.java

✍️ **파일 간단 설명**

로그인을 담당하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.UserDto;
import Domain.Service.UserServiceImpl;

public class UserLoginController implements SubController{

	private HttpServletRequest req;
	private HttpServletResponse resp;
	
	private UserServiceImpl userService;
	
	public UserLoginController() throws Exception{
		userService = UserServiceImpl.getInstance();	

	}
	@SuppressWarnings("deprecation")
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] UserLoginController execute..");
		

		try {
			String uri = req.getMethod();
			if(uri.equals("GET")) {
				req.getRequestDispatcher("/WEB-INF/view/user/login.jsp").forward(req, resp);
				return ;
			}
			
			//파라미터(username,password)
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			
			//입력값검증
			UserDto userDto = new UserDto(username,password,null);
			boolean isOk = isValid(userDto);
			if(!isOk) {
				req.getRequestDispatcher("/WEB-INF/view/user/login.jsp").forward(req, resp);
				return ;
			}
```

📌 **코드 등장 메서드**

- exceptionHandler
- isValid
- execute

🧠 **흐름 정리**

GET 요청 시 로그인 화면으로 이동하고, POST 요청 시 사용자 정보 검증 및 로그인 상태를 세션에 저장합니다.

### 🔍 추가 개념 설명 (예: UserLoginController.java 내부)

- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **forward**: JSP나 서블릿으로 요청을 넘길 때 사용되는 동작입니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **getparameter**: HTTP 요청에서 전달된 파라미터 값을 가져오는 메서드입니다.
- **map**: Java의 Map 객체는 키-값(key-value) 쌍으로 데이터를 저장하는 자료구조입니다.
- **requestdispatcher**: 요청을 다른 자원(JSP 등)으로 포워딩할 때 사용하는 객체입니다.
- **service**: 비즈니스 로직을 처리하는 계층입니다.

---

## 📄 UserLogoutController.java

✍️ **파일 간단 설명**

로그아웃 처리를 담당하는 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.SubController;
import Domain.Service.UserServiceImpl;

public class UserLogoutController implements SubController{

	private HttpServletRequest req;
	private HttpServletResponse resp;
	
	private UserServiceImpl userService;
	
	public UserLogoutController() throws Exception{
		userService = UserServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		System.out.println("[SC] UserLogoutController execute..");
		
		try {
			
			// FrontController -> UserLogoutController 등록 (URI : /user/logout)
			// UserLogoutController
			//  - 1 파라미터받기 생략 
			//	- 2 session 안 속성 정보(isAuth , role , username) 꺼내오고 유효성 체크
			//  - isAuth == false 라면 포워딩 /WEB-INF/user/login.jsp   session에 message 속성 추가 "로그인상태가 아닙니다"
			// UserService
			//  - logout함수 내 처리
			//		- session invalid 처리 하기
			//		- Map<String,Object> 로 return "isLogout",true , "message","로그아웃성공"

			// UserLogoutController
			//	- isLogout 정보를 확인하여 로그아웃 성공/실패 둘다  /user/login
			//  - message는 session 에 저장

			HttpSession session = req.getSession();
			Boolean isAuth = session.getAttribute("isAuth")!=null?(Boolean)session.getAttribute("isAuth"):null;
			String role = (String)session.getAttribute("role");
			String username = (String)session.getAttribute("username");
			
			if(isAuth==null || isAuth==false) {	
```

📌 **코드 등장 메서드**

- exceptionHandler
- isValid
- execute

🧠 **흐름 정리**

세션 정보를 초기화하고 홈 화면 또는 로그인 화면으로 리다이렉트합니다.

### 🔍 추가 개념 설명 (예: UserLogoutController.java 내부)

- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **map**: Java의 Map 객체는 키-값(key-value) 쌍으로 데이터를 저장하는 자료구조입니다.
- **service**: 비즈니스 로직을 처리하는 계층입니다.
- **session**: 클라이언트와 서버 간의 지속적인 상태 정보를 저장하는 공간입니다.

---

## 📄 Dao.java

✍️ **파일 간단 설명**

설명이 등록되지 않은 Java 파일입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Domain.Dao.ConnectionPool.ConnectionItem;
import Domain.Dao.ConnectionPool.ConnectionPool;

public abstract class Dao {
	
	protected PreparedStatement pstmt;
	protected ResultSet rs;
	
	protected ConnectionPool connectionPool;
	protected ConnectionItem connectionItem;
	public Dao() throws Exception{
		//connectionPool
		connectionPool =ConnectionPool.getInstance();
	}
	
}
```

📌 **코드 등장 메서드**

(없음)

🧠 **흐름 정리**

코드 분석을 통해 흐름을 파악해야 합니다.

### 🔍 추가 개념 설명 (예: Dao.java 내부)

- **connection**: 데이터베이스 연결 객체로 SQL 실행 시 사용됩니다.
- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **preparedstatement**: SQL을 미리 컴파일하여 실행하는 객체입니다.
- **resultset**: SQL 실행 결과를 담는 객체입니다.

---

## 📄 UserDao.java

✍️ **파일 간단 설명**

회원 관련 데이터베이스 접근을 위한 DAO 인터페이스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.SQLException;
import java.util.List;

import Domain.Dto.UserDto;



public interface UserDao {

	int insert(UserDto userDto) throws Exception;

	int update(UserDto userDto) throws SQLException;

	int delete(UserDto userDto) throws SQLException;
	//단건조회

	UserDto select(String username) throws Exception;
	//다건조회

	List<UserDto> selectAll();

}
```

📌 **코드 등장 메서드**

(없음)

🧠 **흐름 정리**

insert, select, login 등 데이터 처리 관련 메서드를 정의합니다.

### 🔍 추가 개념 설명 (예: UserDao.java 내부)

- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.

---

## 📄 UserDaoImpl.java

✍️ **파일 간단 설명**

UserDao 인터페이스를 구현한 클래스입니다. DB 연결 후 SQL 실행을 담당합니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import Domain.Dto.UserDto;



public class UserDaoImpl extends Dao implements UserDao{

	//싱글톤 패턴처리
	private static UserDao instance;
	private UserDaoImpl() throws Exception {
		System.out.println("[DAO] UserDaoImpl init...");		
	};
	public static UserDao getInstance() throws Exception {
		if(instance==null)
			instance = new UserDaoImpl();
		return instance;
	}
	
	//CRUD 
	@Override
	public int insert(UserDto userDto) throws Exception {
		try {
			
			connectionItem = connectionPool.getConnection();
			Connection conn = connectionItem.getConn();
			
			pstmt = conn.prepareStatement("insert into tbl_user values(?,?,?)");
			pstmt.setString(1, userDto.getUsername());
			pstmt.setString(2, userDto.getPassword());
			pstmt.setString(3, "ROLE_USER");
			
			//Connection release
			connectionPool.releaseConnection(connectionItem);
			
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("USERDAO's INSERT SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
	
 
```

📌 **코드 등장 메서드**

- update
- insert
- select
- selectAll
- delete

🧠 **흐름 정리**

ConnectionPool에서 커넥션을 얻고, SQL 쿼리를 실행하여 DB에 접근합니다.

### 🔍 추가 개념 설명 (예: UserDaoImpl.java 내부)

- **connection**: 데이터베이스 연결 객체로 SQL 실행 시 사용됩니다.
- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.

---

## 📄 ConnectionItem.java

✍️ **파일 간단 설명**

ConnectionPool 내부에서 DB 커넥션을 포장하여 상태를 관리하는 객체입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao.ConnectionPool;

import java.sql.Connection;

import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;

public class ConnectionItem {
	private Connection conn;
	private boolean isUse;
	//분산 TX
	private XAResource xaResource ;
	private Xid xid;
	private boolean inTransaction;
	
	public ConnectionItem(Connection conn,XAResource xaResource) {
		this.conn = conn;
		isUse = true;
		this.xaResource = xaResource;
		
	}
	//toString
	//getter and setter

	public Connection getConn() {
		return conn;
	}


	public boolean isUse() {
		return isUse;
	}

	public void setUse(boolean isUse) {
		this.isUse = isUse;
	}

	//분산 TX
	public XAResource getXaResource() {
		return xaResource;
	}

	public void setXaResource(XAResource xaResource) {
		this.xaResource = xaResource;
	}

	public Xid getXid() {
		return xid;
	}

```

📌 **코드 등장 메서드**

- setInTransaction
- getXaResource
- setXaResource
- getInTransaction
- isUse
- setUse
- getXid
- setXid
- getConn

🧠 **흐름 정리**

커넥션의 사용 여부, 생성 시간 등을 관리합니다.

### 🔍 추가 개념 설명 (예: ConnectionItem.java 내부)

- **connection**: 데이터베이스 연결 객체로 SQL 실행 시 사용됩니다.
- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.

---

## 📄 ConnectionPool.java

✍️ **파일 간단 설명**

DB 커넥션을 효율적으로 관리하기 위한 커넥션 풀 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao.ConnectionPool;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.XAConnection;
import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;

import com.mysql.cj.jdbc.MysqlXADataSource;

public class ConnectionPool {
	private List<ConnectionItem> connectionPool;
	//ConnectionPool 에 저장될 Connection 을 위한 변수
	private final int size=10;
	private String url="jdbc:mysql://localhost:3306/testDB";;
	private String id="root";
	private String pw="1234";

	//싱글톤 패턴 코드 추가
	private ConnectionPool() throws SQLException {
		
		this.connectionPool = new ArrayList();
		for(int i=0;i<size;i++) {
			
//			Connection conn = DriverManager.getConnection(url,id,pw);	
//			connectionPool.add(new ConnectionItem(conn,i));
			
			//TX
			//XA 트랜잭션을 처리할 수 있는 연결을 설정, 분산 트랜잭션을 다룸
	        MysqlXADataSource xaDataSource = new MysqlXADataSource(); // MySQL JDBC 드라이버에서 제공하는 클래스
	        
            xaDataSource.setUrl(url);
            xaDataSource.setUser(id);
            xaDataSource.setPassword(pw);
            XAConnection xaConnection = xaDataSource.getXAConnection(); //분산 트랜잭션을 처리할 수 있는 JDBC 연결 객체
            
            // XA 트랜잭션에 의해 관리되는 connection 객체 가져옴
           
            Connection conn = xaConnection.getConnection();
            
            //트랜잭션 관리를 위한 XAResource 객체를 가져옴
            XAResource xaResource = xaConnection.getXAResource();
            
            //ConnectionItem에 xaResource객체를 멤버로 포함
            connectionPool.add(new ConnectionItem(conn, xaResource));
		
		}
```

📌 **코드 등장 메서드**

- getFormatId
- rollbackTransaction
- beginTransaction
- commitTransaction

🧠 **흐름 정리**

미리 커넥션을 만들어두고 요청 시 재사용하는 방식으로 성능을 높입니다.

### 🔍 추가 개념 설명 (예: ConnectionPool.java 내부)

- **connection**: 데이터베이스 연결 객체로 SQL 실행 시 사용됩니다.
- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.

---

## 📄 UserDto.java

✍️ **파일 간단 설명**

회원 정보를 전달하기 위한 데이터 객체입니다 (DTO).

🧩 **코드 일부 발췌**
```java
package Domain.Dto;

public class UserDto {
	private String username;
	private String password;
	private String role;
	//생성자 getter and setter toString
	public UserDto() {}
	public UserDto(String username, String password, String role) {
		super();
		this.username = username;
		this.password = password;
		this.role = role;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
	@Override
	public String toString() {
		return "UserDto [username=" + username + ", password=" + password + ", role=" + role + "]";
	}
	
}
```

📌 **코드 등장 메서드**

- getUsername
- setRole
- getPassword
- setPassword
- setUsername
- getRole
- toString

🧠 **흐름 정리**

username, password, role 필드를 가지며, 서비스 계층 간 데이터 이동을 담당합니다.

### 🔍 추가 개념 설명 (예: UserDto.java 내부)

- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.

---

## 📄 UserServiceImpl.java

✍️ **파일 간단 설명**

회원 관련 비즈니스 로직을 처리하는 서비스 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Service;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import Domain.Dao.UserDao;
import Domain.Dao.UserDaoImpl;
import Domain.Dao.ConnectionPool.ConnectionPool;
import Domain.Dto.UserDto;


public class UserServiceImpl {
	
	//
	private UserDao userDao ;
	private ConnectionPool connectionPool ;	//TX
	
	//싱글톤 패턴
	private static UserServiceImpl instance;
	private UserServiceImpl() throws Exception {
		userDao = UserDaoImpl.getInstance();
		connectionPool = ConnectionPool.getInstance();
		System.out.println("[SERVICE] UserServiceImpl init...");
	};
	public static UserServiceImpl getInstance() throws Exception {
		if(instance==null)
			instance = new UserServiceImpl();
		return instance ;
	}
	
	//회원가입(+TX처리필요)
	public boolean userJoin(UserDto userDto) throws Exception{
		boolean isJoin = false;
		try {
		
			connectionPool.beginTransaction();		
			isJoin  = userDao.insert(userDto)>0; //sql 질의 다수		
			connectionPool.commitTransaction();
			
		}catch(SQLException e) {
			connectionPool.rollbackTransaction();
		}
	
		return  isJoin;	
	};
	
	public Map<String,Object> login(UserDto userDto,HttpSession session) throws Exception {
```

📌 **코드 등장 메서드**

- userJoin

🧠 **흐름 정리**

userJoin, userLogin 등 사용자 등록/로그인과 관련된 기능을 제공합니다.

### 🔍 추가 개념 설명 (예: UserServiceImpl.java 내부)

- **connection**: 데이터베이스 연결 객체로 SQL 실행 시 사용됩니다.
- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.
- **map**: Java의 Map 객체는 키-값(key-value) 쌍으로 데이터를 저장하는 자료구조입니다.
- **service**: 비즈니스 로직을 처리하는 계층입니다.
- **session**: 클라이언트와 서버 간의 지속적인 상태 정보를 저장하는 공간입니다.

---

## 📄 UTF8_EncodingFilter.java

✍️ **파일 간단 설명**

모든 요청과 응답의 인코딩을 UTF-8로 고정하는 필터 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

//@WebFilter("/*")	//url : /* 모든 url , *.do : 확장자가 do인 모든 요청
public class UTF8_EncodingFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println("[Filter] UTF8_EncodingFilter..Start");
		request.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
		response.setContentType("text/html; charset=UTF-8");
		System.out.println("[Filter] UTF8_EncodingFilter..End");
	
	}

}
```

📌 **코드 등장 메서드**

- doFilter

🧠 **흐름 정리**

필터 체인을 통해 한글 깨짐을 방지하며, Filter 인터페이스를 구현합니다.

### 🔍 추가 개념 설명 (예: UTF8_EncodingFilter.java 내부)

- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **ioexception**: 입출력 과정에서 발생하는 예외 상황을 처리하는 클래스입니다.
- **servletexception**: 서블릿 처리 중 에러가 발생했음을 나타내는 예외 클래스입니다.

---

## 📄 DaoTests.java

✍️ **파일 간단 설명**

UserDao 기능들을 테스트하는 테스트 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Tests;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import Domain.Dao.UserDao;
import Domain.Dao.UserDaoImpl;
import Domain.Dto.UserDto;

class DaoTests {
	
	@Test
	@Disabled
	void test() throws Exception {
		UserDao userDao = UserDaoImpl.getInstance();
		
		userDao.insert(new UserDto("user123511","1234","ROLE_USER"));
	}

	@Test
	
	void test2() throws Exception {
		UserDao userDao = UserDaoImpl.getInstance();
		System.out.println(userDao.select("bbbbbb"));
	}
}
```

📌 **코드 등장 메서드**

(없음)

🧠 **흐름 정리**

insert, select 등 데이터베이스 연동 메서드의 동작을 검증합니다.

### 🔍 추가 개념 설명 (예: DaoTests.java 내부)

- **dao**: 데이터베이스와의 연결 및 데이터 처리를 담당하는 객체입니다.
- **dto**: 데이터를 전송하기 위한 객체로, 계층 간 데이터 전달에 사용됩니다.
- **exception**: Java에서 예외 상황을 처리하기 위한 객체입니다. 예상치 못한 에러 상황을 캡처합니다.
- **get**: Map 또는 request 객체에서 값을 가져오는 데 사용되는 메서드입니다.

---

