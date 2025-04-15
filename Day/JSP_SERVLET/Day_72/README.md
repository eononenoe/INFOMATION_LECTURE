# 01

---

## Controller

---

> FrontController.java
> 

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

> HomeController.java
> 

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

> SubController.java
> 

```java
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SubController {
	public void execute (HttpServletRequest req, HttpServletResponse resp);
}

```

---

## Controller/user

---

> UserCreateController.java
> 

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

> UserLoginController.java
> 

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

			//서비스
			boolean isLogin = false;
			Map<String,Object> serviceResponse =  userService.login(userDto,req.getSession());
			isLogin =  (boolean)serviceResponse.get("isLogin");
			String message = (String)serviceResponse.get("message");

			//뷰
			PrintWriter out = resp.getWriter();
			if(isLogin) {
				req.getSession().setAttribute("message",message);
				resp.sendRedirect(req.getContextPath()+"/index.do");
//				out.println("<script>alert("+message+");location.href=/index.do;</script>");

			}else {
				req.getRequestDispatcher("/WEB-INF/view/user/login.jsp").forward(req, resp);
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

> UserLogoutController.java
> 

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
				req.setAttribute("message", "로그인된 상태가 아닙니다");
				req.getRequestDispatcher("/WEB-INF/view/user/login.jsp").forward(req, resp);
				return ;
			}

			boolean isOk =  isValid(isAuth,role,username);

			//서비스

			Map<String,Object> serviceResponse  = userService.logout(req.getSession());
			Boolean isLogout = (Boolean)serviceResponse.get("isLogout");

			HttpSession reSession = req.getSession(true);
			if(isLogout!=null&& isLogout==true) {
				reSession.setAttribute("message", "로그아웃 성공!");
			}else {
				reSession.setAttribute("message", "로그아웃 실패!");
			}

			resp.sendRedirect(req.getContextPath()+"/user/login");

		}catch(Exception e) {
			exceptionHandler(e);
			try {
				req.getRequestDispatcher("/WEB-INF/view/user/error.jsp").forward(req, resp);
			}catch(Exception e2) {}
		}

	}

	private boolean isValid(Boolean isAuth , String role , String username) {

		if(isAuth==null || isAuth==false) {

			return false;
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

## Domain/Dao/ConnectionPool

---

> ConnectionItem.java
> 

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

	public void setXid(Xid xid) {
		this.xid = xid;
	}

	public void setInTransaction(boolean b) {
		this.inTransaction = b;

	}

	public boolean getInTransaction() {
		// TODO Auto-generated method stub
		return this.inTransaction
				;
	}

}

```

> ConnectionPool.java
> 

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

		System.out.println("[CP] Connection size : " + connectionPool.size());

	}
	private static ConnectionPool instance;
	public static ConnectionPool getInstance() throws SQLException {
		if(instance==null)
			instance = new ConnectionPool();
		return instance;
	}

	//
	public synchronized ConnectionItem getConnection() throws Exception {

		for(ConnectionItem connItem : connectionPool) {
			if(connItem.isUse()) {
				connItem.setUse(false); 	//사용중인 상태로 변경
				return connItem;			//Connection 리턴
			}
		}
		throw new Exception("모든 Connection이 사용중인 상태입니다.");
	}

	public synchronized void releaseConnection(ConnectionItem connItem) {
		connItem.setUse(true);
	}

	//--------------------------
	//분산 TX
	//--------------------------
    // 트랜잭션 시작
    public void beginTransaction() throws Exception {
        for (int i = 0; i < connectionPool.size(); i++) {
            ConnectionItem connItem = connectionPool.get(i);

            if (connItem.getInTransaction()) {
                // 이미 트랜잭션이 시작된 경우 무시
                continue;
            }
            //식별자생성
            Xid xid = createXid(100, i);
            connItem.setXid(xid);  // Xid 저장

            // XA 트랜잭션 시작
            connItem.getXaResource().start(xid, XAResource.TMNOFLAGS);
            connItem.setInTransaction(true); // 트랜잭션 활성화 플래그 설정
        }
    }

    // 트랜잭션 커밋
    //2-Phase Commit(2PC) 를 통한 트랜잭션 조정
    public void commitTransaction() throws Exception {
        //트랜잭션 식별자(Xid)를 저장할 리스트 생성
    	List<Xid> xidList = new ArrayList<>();

        try {
            // End 단계
            for (ConnectionItem connItem : connectionPool) {
            	//ConnectionItem에서 XAResource 객체를 가져옴
            	//이 객체는 트랜잭션을 시작하고, 준비하고, 커밋하거나 롤백하는 작업을 관리
                XAResource xaResource = connItem.getXaResource();
                // 트랜잭션을 식별하는 Xid 객체를 가져옴
                Xid xid = connItem.getXid();
                //리스트에 추가
                xidList.add(xid);

                // 트랜잭션 종료
                xaResource.end(xid, XAResource.TMSUCCESS);
            }

            // Prepare 단계(커밋 가능 확인 확인)
            for (ConnectionItem connItem : connectionPool) {
                XAResource xaResource = connItem.getXaResource();
                Xid xid = connItem.getXid();
                //각 자원 관리자에 대해 XAResource.prepare(xid)를 호출하여 트랜잭션을 준비
                //prepare는 트랜잭션이 성공적으로 커밋될 수 있는지 자원 관리자가 준비할 수 있도록 합니다.
                int prepare = xaResource.prepare(xid);
                if (prepare != XAResource.XA_OK) //드랜잭션 실패시
                {
                    throw new Exception("Prepare failed for one or more resources.");
                    //예외발생 -> Rollback으로 이동
                }
            }

            // Commit 단계
            for (int i = 0; i < connectionPool.size(); i++) {
            	// connectionPool에있는 i번째 ConnctionItem의 xaResource꺼냄
                XAResource xaResource = connectionPool.get(i).getXaResource();
                //i번째 xid 가져옴
                Xid xid = xidList.get(i);
                // 커밋작업
                xaResource.commit(xid, false); // 분산 트랜잭션 커밋
                //false : 트랜잭션이 1단계로 커밋되지 않고, 2단계 커밋을 완료하겠다는 의미
                //2PC(2-Phase Commit)의 두 번째 단계가 수행됩니다.
            }

            System.out.println("Distributed transaction committed successfully.");
        } catch (Exception e) {
            rollbackTransaction();  // 롤백 수행
            throw e;
        }
    }

    // 트랜잭션 롤백
    public void rollbackTransaction() throws Exception {
        for (ConnectionItem connItem : connectionPool) {
            XAResource xaResource = connItem.getXaResource();
            Xid xid = connItem.getXid();
            xaResource.rollback(xid); // 트랜잭션 롤백
        }
        System.out.println("Distributed transaction rolled back.");
    }

    //
    // Xid 생성 메서드
    private static Xid createXid(int bid, int tid) {
        return new Xid() {
            private int formatId = 1;
            private byte[] branchQualifier = new byte[] { (byte) tid };
            private byte[] globalTransactionId = new byte[] { (byte) bid };

            @Override
            public int getFormatId() {
                return formatId;
            }

            @Override
            public byte[] getBranchQualifier() {
                return branchQualifier;
            }

            @Override
            public byte[] getGlobalTransactionId() {
                return globalTransactionId;
            }
        };
    }

}

```

---

## Domain/Dao

---

> Dao.java
> 

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

> UserDao.java
> 

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

> UserDaoImpl.java
> 

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

	@Override
	public int update(UserDto userDto) throws SQLException {

		return 0;
	}

	@Override
	public int delete(UserDto userDto) throws SQLException {
//		try {
//			pstmt = conn.prepareStatement("");
//
//			return pstmt.executeUpdate();
//
//		}catch(SQLException e) {
//			e.printStackTrace();
//			throw new SQLException("USERDAO's DELETE SQL EXCEPTION!!");
//		}finally {
//			try {pstmt.close();}catch(Exception e2) {}
//		}
		return 0;
	}
	//단건조회

	@Override
	public UserDto select(String username) throws Exception{
	try {

			connectionItem = connectionPool.getConnection();
			Connection conn = connectionItem.getConn();

			pstmt = conn.prepareStatement("select * from tbl_user where username=?");
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();

			UserDto userDto = null;
			if(rs!=null && rs.next())
				userDto = new UserDto(rs.getString(1),rs.getString(2),rs.getString(3));

			//Connection release
			connectionPool.releaseConnection(connectionItem);

			return userDto;

		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("USERDAO's INSERT SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}

	//다건조회

	@Override
	public List<UserDto> selectAll() {
		return null;
	}

}

```

---

## Domain/Dto

---

> UserDto.java
> 

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

---

## Domain/Service

---

> UserServiceImpl.java
> 

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
		Map<String,Object> response = new LinkedHashMap();

		boolean isLogin = false;
		try {

			connectionPool.beginTransaction();

			UserDto userDb  = userDao.select(userDto.getUsername());	//sql 질의 다수

			if(userDb==null) {
				response.put("isLogin", false);
				response.put("message", "동일한 계정이 존재하지 않습니다.");
			}else {

				//패스워드 일치여부 확인(암호화 전)
				if(!userDto.getPassword().equals(userDb.getPassword())) {
					response.put("isLogin", false);
					response.put("message", "패스워드가 일치하지 않습니다.");
				}else {
					//ID/패스워드 일치 -> 로그인처리
					session.setAttribute("isAuth", true);
					session.setAttribute("username",userDb.getUsername());
					session.setAttribute("role", userDb.getRole());
					session.setMaxInactiveInterval(60*10);

					response.put("isLogin", true);
					response.put("message", "로그인 성공!");
				}
			}
			connectionPool.commitTransaction();
		}catch(SQLException e) {
			connectionPool.rollbackTransaction();
		}
		return response;
	}

	public Map<String, Object> logout(HttpSession session) throws Exception  {
		session.invalidate();
		Map<String, Object> response = new LinkedHashMap();
		response.put("isLogout",true);
		return response;
	}

}

```

---

## Filter

---

> UTF8_EncodingFilter.java
> 

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

---

## Tests

---

> DaoTests.java
> 

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