# 01

# Dto

---

> **BookDto**
> 

```java
package Ch38.Domain.Dto;

public class BookDto {
	private String bookCode;
	private String bookName;
	private String publisher;
	private String isbn;
	//생성자
	BookDto(){}
	public BookDto(String bookCode, String bookName, String publisher, String isbn) {
		super();
		this.bookCode = bookCode;
		this.bookName = bookName;
		this.publisher = publisher;
		this.isbn = isbn;
	}
	//getter and setter
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
	//toString	
	@Override
	public String toString() {
		return "BookDto [bookCode=" + bookCode + ", bookName=" + bookName + ", publisher=" + publisher + ", isbn="
				+ isbn + "]";
	}
}

```

---

> **UserDto**
> 

```java
package Ch38.Domain.Dto;

//저장단위(Controller<->Service<->Dao<->DB)
public class UserDto {
	String userid;
	String username;
	String password;
	String role;
	//생성자(디폴트,모든인자)
	public UserDto() {}
	public UserDto(String userid, String username, String password, String role) {
		super();
		this.userid = userid;
		this.username = username;
		this.password = password;
		this.role = role;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
		return "UserDto [userid=" + userid + ", username=" + username + ", password=" + password + ", role=" + role
				+ "]";
	};
	//getter and setter
	//to String
	
}

```

---

# Dao

---

> **BookDaoImpl**
> 

```java
package Ch38.Domain.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import Ch38.Domain.Dto.BookDto;
import Ch38.Domain.Dto.UserDto;

public class BookDaoImpl {
	//DB Attr
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private String id="root";
	private String pw="1234";
	private String url="jdbc:mysql://localhost:3306/bookDB";
	
	//싱글톤
	
	private static BookDaoImpl instance;
	private BookDaoImpl() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		System.out.println("UserDaoImpl DB Connection Success");
	};
	public static BookDaoImpl getInstance() throws ClassNotFoundException, SQLException {
		if(instance==null)
			instance=new BookDaoImpl();
		return instance;
	}
	
	//CRUD 
	 
	public int insert(BookDto bookDto) throws SQLException {
		try {
			pstmt = conn.prepareStatement("insert into tbl_book values(?,?,?,?)");
			pstmt.setString(1, bookDto.getBookCode());
			pstmt.setString(2, bookDto.getBookName());
			pstmt.setString(3, bookDto.getPublisher());
			pstmt.setString(4, bookDto.getIsbn());
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("BOOKDAO's INSERT SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
	
 
	public int update(UserDto userDto) throws SQLException {
		try {
			pstmt = conn.prepareStatement("");
			
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("BOOKDAO's UPDATE SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
 
	public int delete(UserDto userDto) throws SQLException {
		try {
			pstmt = conn.prepareStatement("");
			
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("BOOKDAO's DELETE SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
	//단건조회
 
	public UserDto select(UserDto userDto) {	
		return null;
	}
	//다건조회
 
	public List<UserDto> selectAll() {	
		return null;
	}	

}

```

---

> **UserDaoImpl**
> 

```java
package Ch38.Domain.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import Ch38.Domain.Dto.UserDto;

public class UserDaoImpl{
	//DB Attr
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private String id="root";
	private String pw="1234";
	private String url="jdbc:mysql://localhost:3306/bookDB";
	//싱글톤 패턴처리
	private static UserDaoImpl instance;
	private UserDaoImpl() throws SQLException, ClassNotFoundException {
		System.out.println("[DAO] UserDaoImpl init...");
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		System.out.println("UserDaoImpl DB Connection Success");
		
	};
	public static UserDaoImpl getInstance() throws ClassNotFoundException, SQLException {
		if(instance==null)
			instance = new UserDaoImpl();
		return instance;
	}
	
	//CRUD 
 
	public int insert(UserDto userDto) throws SQLException {
		try {
			pstmt = conn.prepareStatement("insert into tbl_user values(?,?,?,?)");
			pstmt.setString(1, userDto.getUserid());
			pstmt.setString(2, userDto.getUsername());
			pstmt.setString(3, userDto.getPassword());
			pstmt.setString(4, "ROLE_USER");
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("USERDAO's INSERT SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
	
 
	public int update(UserDto userDto) throws SQLException {
		try {
			pstmt = conn.prepareStatement("");
			
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("USERDAO's UPDATE SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
 
	public int delete(UserDto userDto) throws SQLException {
		try {
			pstmt = conn.prepareStatement("");
			
			return pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new SQLException("USERDAO's DELETE SQL EXCEPTION!!");
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
		}
	}
	//단건조회
 
	public UserDto select(UserDto userDto) {	
		return null;
	}
	//다건조회
 
	public List<UserDto> selectAll() {	
		return null;
	}	
	
}

```

---

# Controller

---

> **BookController**
> 

```java
package Ch38.Controller;

import java.util.HashMap;
import java.util.Map;

import Ch38.Domain.Dto.BookDto;

public class BookController implements SubController {
	Map<String, Object> response;
	//C(1)R(2)U(3)D(4) 
	@Override
	public Map<String, Object> execute(Map<String, Object> params) {
		System.out.println("[SC] BookController execute invoke..!");
		//00 
		response = new HashMap();
		Integer serviceNo =(Integer)params.get("serviceNo");
		if(serviceNo==null) {
			response.put("status", false);
			response.put("message", "유효하지 않은 서비스 요청입니다.");
			return response;
		}
		switch(serviceNo) {
			case 1:			//C - 도서등록(ROLE-사서,관리자)
				System.out.println("[SC] 도서등록 요청 확인");
				//01 파라미터받기
				String bookCode = (params.get("bookCode")!=null)?(String) params.get("bookCode"):null;
				String bookName=(params.get("bookName")!=null)?(String) params.get("bookName"):null;
				String publisher=(params.get("publisher")!=null)?(String) params.get("publisher"):null;
				String isbn=(params.get("isbn")!=null)?(String) params.get("isbn"):null;
				
				BookDto bookDto = new BookDto(bookCode,bookName,publisher,isbn);
				if(!isValid(bookDto)){
					response.put("status", false);
					return response;
				}
				
				//02 유효성검증(Data Validation)
				//03 관련 서비스 실행
				//04 뷰로 이동(or 내용전달)
				break;
			case 2:			//R - 도서조회(ROLE-회원,사서,관리자)
				System.out.println("[SC] 도서조회 요청 확인");
				//01 파라미터받기
				//02 유효성검증(Data Validation)
				//03 관련 서비스 실행
				//04 뷰로 이동(or 내용전달)
				break;
			case 3:			//U - 도서수정(ROLE-사서,관리자)
				System.out.println("[SC] 도서수정 수정 요청 확인");
				//01 파라미터받기
				//02 유효성검증(Data Validation)
				//03 관련 서비스 실행
				//04 뷰로 이동(or 내용전달)
				break;
			case 4:			//D - 도서삭제(ROLE_사서,관리자)
				System.out.println("[SC] 도서삭제 요청 확인");
				//01 파라미터받기
				//02 유효성검증(Data Validation)
				//03 관련 서비스 실행
				//04 뷰로 이동(or 내용전달)
				break;
			default :
				System.out.println("[SC] 잘못된 서비스번호 요청 확인");
				response.put("status", false);
				response.put("message", "잘못된 서비스번호 요청입니다.");
		}

		
		return response;
	}
	//
	private boolean isValid(BookDto bookDto) {
//		유효성 체크(isValid) 함수 완성합니다
//		ServiceNo  : 1
//		bookCode 는 기본 8글자만 허용
//		bookName 의 길이는 255자를 넘기면 안됩니다
//
//		필요하면 정규표현식(String.matchs("REG STRING"))
//		이용해서 필터링 해보세요 - !

		if(bookDto.getBookCode()==null || bookDto.getBookCode().length()!=8){ 
			response.put("error","bookCode의 길이는 8자 이어야 합니다");
			return false;
		}
		
		return true;
	}

}

```

---

> **FrontController**
> 

```java
package Ch38.Controller;

import java.util.HashMap;
import java.util.Map;

public class FrontController {
	//서브컨트롤러 저장 자료구조("/endPoint":서브컨트롤러객체)
	private Map<String,SubController> map = new HashMap();
	
	//싱글톤
	private static FrontController instance;
	private FrontController() {
		System.out.println("[FC] FrontController init..");
		init();
	}
	public static FrontController getInstance() {
		if(instance==null)
			instance = new FrontController();
		return instance;
	}
	//초기화
	private void init() {
		// 인증요청 API(ENDPOINT : 서브컨트롤러객체 저장)
		map.put("/user", new UserController());
		
		// 도서요청 API
		map.put("/book", new BookController());
	}
	
	//View로부터 전달하는 요청 처리 
	public Map<String,Object> execute (Map<String,Object> params)
	{
		System.out.println("[FC] execute invoke....");
		String endPoint =(String)params.get("endPoint"); //사용자의 요청EP를 확인(/book,/user)
		SubController controller =  map.get(endPoint);	//요청사항을 처리할 SubController get
		return controller.execute(params);		 
	}
}

			

```

---

> **SubController**
> 

```java
package Ch38.Controller;

import java.util.Map;

public interface SubController {
	public Map<String,Object> execute (Map<String,Object> params);

}

```

---

> **UserController**
> 

```java
package Ch38.Controller;

import java.util.HashMap;

//인증 ENDPOINT 

//기능	범위		URI		요청 파라미터			응답형태				설명
//인증	공통		/user	Map<String,Object>	Map<String,Object>	인증서비스입니다(C:1,R:2...)
//
//회원가입	개별	/user		"ServiceNo":int		"success":boolean	회원가입 요청 처리입니다
//						"userId":String
//						"username":String
//						"password":String
//		

import java.util.Map;

import Ch38.Domain.Dto.UserDto;
import Ch38.Domain.Service.UserServiceImpl;

public class UserController implements SubController {

	// UserService
	private UserServiceImpl userService;

	Map<String, Object> response;

	public UserController() {
		try {
			userService = UserServiceImpl.getInstance();
		} catch (Exception e) {
			exceptionHandler(e);
		}

	}

	// C(1)R(2)U(3)D(4) + 로그인(5),로그아웃(6)
	@Override
	public Map<String, Object> execute(Map<String, Object> params) {
		System.out.println("[SC] UserController execute invoke..!");
		// 00

		response = new HashMap();

		Integer serviceNo = (Integer) params.get("serviceNo");
		if (serviceNo == null) {
			response.put("status", false);
			response.put("message", "유효하지 않은 서비스 요청입니다.");
			return response;
		}
		try {
			switch (serviceNo) {
			case 1: // C - 회원가입
				System.out.println("[SC] 회원가입 요청 확인");
				// 01 파라미터받기
				String userid = (params.get("userid") != null) ? (String) params.get("userid") : null;
				String username = (params.get("username") != null) ? (String) params.get("username") : null;
				String password = (params.get("password") != null) ? (String) params.get("password") : null;
				String role = "ROLE_USER"; // 기본값
				UserDto userDto = new UserDto(userid, username, password, role);

				// 02 유효성검증(Data Validation)
				boolean isOk = isValid(userDto);
				System.out.println("[No-1 회원가입] : 유효성 검증 확인 : " + isOk);
				if (!isOk) {
					response.put("status", false);
//					response.put("message","유효성 체크 오류발생!");	
					return response;
				}
				// 03 관련 서비스 실행
				boolean isSuccess = userService.userJoin(userDto);

				// 04 뷰로 이동(or 내용전달)
				if (isSuccess) {
					response.put("status", isSuccess);
					response.put("message", "회원가입 성공!");
				}

				break;
			case 2: // R - 개인 회원 정보 조회
				System.out.println("[SC] 회원정보 조회 요청 확인");
				// 01 파라미터받기
				// 02 유효성검증(Data Validation)
				// 03 관련 서비스 실행
				// 04 뷰로 이동(or 내용전달)
				break;
			case 3: // U - 개인 회원 정보 수정
				System.out.println("[SC] 회원정보 수정 요청 확인");
				// 01 파라미터받기
				// 02 유효성검증(Data Validation)
				// 03 관련 서비스 실행
				// 04 뷰로 이동(or 내용전달)
				break;
			case 4: // D - 개인 회원 탈퇴
				System.out.println("[SC] 회원탈퇴 요청 확인");
				// 01 파라미터받기
				// 02 유효성검증(Data Validation)
				// 03 관련 서비스 실행
				// 04 뷰로 이동(or 내용전달)
				break;
			case 5: // P - 로그인
				System.out.println("[SC] 로그인 요청 확인");
				// 01 파라미터받기
				// 02 유효성검증(Data Validation)
				// 03 관련 서비스 실행
				// 04 뷰로 이동(or 내용전달)
				break;
			case 6: // P - 로그아웃
				System.out.println("[SC] 로그아웃 요청 확인");
				// 01 파라미터받기
				// 02 유효성검증(Data Validation)
				// 03 관련 서비스 실행
				// 04 뷰로 이동(or 내용전달)
				break;
			default:
				System.out.println("[SC] 잘못된 서비스번호 요청 확인");
				response.put("status", false);
				response.put("message", "잘못된 서비스번호 요청입니다.");
			}
			
		} catch (Exception e) {
			exceptionHandler(e);
		}

		return response;
	}

	// 유효성 검사 함수
	private boolean isValid(UserDto userDto) {

		if (userDto.getUserid() == null || userDto.getUserid().length() <= 4) {
			response.put("error", "userid의 길이는 최소 5자이상이어야합니다");
			System.out.println("[INVALID] userid의 길이는 최소 5자이상이어야합니다");
			return false;
		}
		if (userDto.getUserid().matches("^[0-9].*")) {
			System.out.println("[INVALID] userid의 첫문자로 숫자가 들어올수 없습니다");
			response.put("error", "userid의 userid의 첫문자로 숫자가 들어올수 없습니다");
			return false;
		}
		// NULL 체크 / 데이터(자료)수준에서의 의미있는데이터가 포함되어져있는지 여부
		// userid 은 첫문자가 숫자인지 여부 - /or 길이가 1글자인지 등등..
		// username 은 첫문자가 숫자인지 여부 -
		// password 복잡도체크는 Business Layer 체크(Policy 에 의한 처리)

		return true;
	}

	// 예외처리함수
	public Map<String, Object> exceptionHandler(Exception e) {

		if (response == null)
			response = new HashMap();

		response.put("status", false);
		response.put("message", e.getMessage());
		response.put("exception", e);

		return response;
	}

}

```

---

# Service

> **UserServiceImpl**
> 

```java
package Ch38.Domain.Service;

import java.sql.SQLException;

import Ch38.Domain.Dao.UserDaoImpl;
import Ch38.Domain.Dto.UserDto;

public class UserServiceImpl {
	
	//
	private UserDaoImpl userDao ;
	
	//싱글톤 패턴
	private static UserServiceImpl instance;
	private UserServiceImpl() throws ClassNotFoundException, SQLException {
		userDao = UserDaoImpl.getInstance();
		System.out.println("[SERVICE] UserServiceImpl init...");
	};
	public static UserServiceImpl getInstance() throws ClassNotFoundException, SQLException {
		if(instance==null)
			instance = new UserServiceImpl();
		return instance ;
	}
	
	//회원가입(+TX처리필요)
	public boolean userJoin(UserDto userDto) throws SQLException{
		
		return  userDao.insert(userDto)>0;
		
	};
	
	//회원조회
	
	//회원정보수정
	
	//회원탈퇴
	
	//로그인
	
	//로그아웃
	

}

```

---

# Test_Controller

> **ControllerTests**
> 

```java
package Ch38.Tests.Controller;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import Ch38.Controller.FrontController;

class ControllerTests {

	FrontController fc = FrontController.getInstance();
	
	@Test
	void test() {
		//View에서 요청정보 담기
		Map<String,Object> params = new HashMap();
		params.put("endPoint", "/user");//endPoint
		params.put("serviceNo", 1);	//ServiceNo
		//회원가입-인자전달
		params.put("userid","ccccc");
		params.put("username","홍길동");
		params.put("password","1234");
		
		//도서등록-인자전달
//		params.put("bookCode","1111111");
//		params.put("bookName","이것이리눅스다");
//		params.put("publisher","한빛미디어");
//		params.put("isbn","1111-1111");
		//요청하기
		Map<String,Object> response =  fc.execute(params);
		
		//응답확인
		for(String key : response.keySet()) {
			System.out.println(key + " : " + response.get(key));
		}
		
		
	}

	
	@Test
	@Disabled
	void test_99() {
		
	}

}

```

---

# Test_Dao

> **DaoTests**
> 

```java
package Ch38.Tests.Dao;

import java.sql.SQLException;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import Ch38.Domain.Dao.BookDaoImpl;
import Ch38.Domain.Dao.UserDaoImpl;
import Ch38.Domain.Dto.BookDto;
import Ch38.Domain.Dto.UserDto;

class DaoTests {

	@Test
	@Disabled
	void test1() throws ClassNotFoundException, SQLException {
		
		UserDaoImpl userDaoImpl = UserDaoImpl.getInstance();
	}
	
	@Test
	@Disabled
	void test2() throws Exception {
		UserDaoImpl userDaoImpl = UserDaoImpl.getInstance();
		userDaoImpl.insert(new UserDto("aaa","홍길동","1234",""));
	}
	
	@Test
	
	void test3() throws Exception {
		BookDaoImpl bookDaoImpl = BookDaoImpl.getInstance();
		bookDaoImpl.insert(new BookDto("1111","리눅스다","한빛미디어","111-111"));
	}
	
	
	@Test
	@Disabled
	void test4() throws Exception {
		
	}
	
}

```

---

# Test_Service

> **ServiceTests**
> 

```java
package Ch38.Tests.Service;

import java.sql.SQLException;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import Ch38.Domain.Dto.UserDto;
import Ch38.Domain.Service.UserServiceImpl;

class ServiceTests {

	
	@Test
	void test() throws ClassNotFoundException, SQLException {

		UserServiceImpl userService=UserServiceImpl.getInstance();
		
		userService.userJoin(new UserDto("bbb","남길동","1234","ROLE_USER"));
	}

	
	@Test
	@Disabled
	void test_99() {
		
	}
}

```

---