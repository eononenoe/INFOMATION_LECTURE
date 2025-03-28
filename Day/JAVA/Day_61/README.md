# 01

# Controller

---

> **BookController**
> 

```java
package Controller;

import java.util.HashMap;
import java.util.Map;

import Domain.BookDTO;
import Service.BookServiceImpl;

public class BookController implements Controller {

	private BookServiceImpl bookService;

	public BookController() {
		try {
			bookService = BookServiceImpl.getInstance();
		} catch (Exception e) {
			exceptionHandler(e);
		}
	}

	Map<String, Object> response;

	@Override
	public Map<String, Object> execute(Map<String, Object> params) {
		System.out.println("[SC] BookController execute invoke..!");
		// 00
		response = new HashMap<>();
		Integer serviceNo = (Integer) params.get("serviceNo");

		if (serviceNo == null) {
			response.put("status", false);
			response.put("message", "유효하지 않은 서비스 번호 입니다.");
		}
		try {
			switch (serviceNo) {
			
			case 1:
				System.out.println("[SUB] 도서 등록 요청 확인");

				// 파라미터 받기
				String book_code = (params.get("BOOK_CODE") != null) ? (String) params.get("BOOK_CODE") : null;
				String classification_id = (params.get("CLASSIFICATION_ID") != null)
						? (String) params.get("CLASSIFICATION_ID")
						: null;
				String book_author = (params.get("BOOK_AUTHOR") != null) ? (String) params.get("BOOK_AUTHOR") : null;
				String book_name = (params.get("BOOK_NAME") != null) ? (String) params.get("BOOK_NAME") : null;
				String publisher = (params.get("PUBLISHER") != null) ? (String) params.get("PUBLISHER") : null;
				String isreserve = (params.get("ISRESERVE") != null) ? (String) params.get("ISRESERVE") : null;
				BookDTO bookDTO = new BookDTO(book_code, classification_id, book_author, book_name, publisher,isreserve);
				
				// 유효성 검증
				boolean isOk = isValid(bookDTO);
				System.out.println("[No-1 회원가입] : 유효성 검증 확인 : " + isOk);
						
				if (!isOk) {
					response.put("status", false);
					return response;
				}
				
				// 관련 서비스 실행
				boolean isSuccess = bookService.bookJoin(bookDTO);
				if (isSuccess) {
					response.put("status", isSuccess);
					response.put("message", "회원가입 성공");
				}

				break;
				
			case 2:
				System.out.println();
				break;
			
			case 3:
				System.out.println();
				break;
				
			default:
				System.out.println("[SC] 잘못된 번호입니다.");
				response.put("status", false);
				response.put("message", "잘못된 번호입니다.");
			}
			
		} catch (Exception e) {
			exceptionHandler(e);
		}
		return response;
	}
	
	
	// 유효성 검사를 위한 메서드
	private boolean isValid(BookDTO bookDTO) {
		
		if(bookDTO.getBOOK_CODE() == null || bookDTO.getBOOK_CODE().length() <= 5 ) {
			response.put("ERROR", "북 코드는 5자 이상으로 만들어야합니다");
			return false;
		}
		return true;
	}
	
	
	// 예외 처리를 위한 메서드
	public Map<String, Object> exceptionHandler(Exception e){
		if(response == null) {
			response = new HashMap<>();
		}
		response.put("status", false);
		response.put("message", e.getMessage());
		response.put("exception", e);
	
		
		return response;
	}
}

```

---

> **Controller**
> 

```java
package Controller;

import java.util.Map;

public interface Controller{
		public Map<String, Object> execute(Map <String, Object> params);
}

```

---

> **FrontController**
> 

```java
package Controller;

import java.util.HashMap;
import java.util.Map;

public class FrontController {
	private Map<String, Controller> map = new HashMap<>();
	
	private static FrontController instance;
	private FrontController() {
		System.out.println("[FC] FrontController init...");
		init();
	}
	
	public static FrontController getInstance() {
		if(instance == null) {
			instance = new FrontController();
		}
		return instance;
	}
	
	// 초기화
	private void init() {
		map.put("/book", new BookController());
	}
	
	// View 로부터 전달 하는 요청 처리
	public Map<String, Object> execute (Map<String, Object> params){
		
		System.out.println("[FC] execute invoke..");
		String endPoint = (String)params.get("endPoint");
		Controller controller = map.get(endPoint);
		
		return controller.execute(params);	
	}
}

```

---

# Domain

---

> **BookDAO**
> 

```java
package Domain;

import java.sql.SQLException;
import java.util.List;

public interface BookDAO {
	
	int insert(BookDTO bookDTO) throws Exception;
	int update(BookDTO bookDTO) throws SQLException;
	int delete(BookDTO bookDTO) throws SQLException;

	BookDTO select(BookDTO bookDTO);
	
	List<BookDTO> selectAll();
	
}

```

---

> **BookDAOImpl**
> 

```java
package Domain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import Domain.ConnectionPool.ConnectionItem;
import Domain.ConnectionPool.ConnectionPool;

public class BookDAOImpl implements BookDAO {

	// DB ATTR
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private String id = "system";
	private String pw = "1234";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";

	// 싱글톤
	private static BookDAOImpl instance;

	private BookDAOImpl() throws ClassNotFoundException, SQLException {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("BookDAOImpl DB Connection Success");

	}

	public static BookDAO getInstance() throws ClassNotFoundException, SQLException {
		if (instance == null) {
			instance = new BookDAOImpl();
		}
		return instance;
	}

	@Override
	public int insert(BookDTO bookDTO) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;

		try {
			// 여기 중요!!!
			ConnectionItem connItem = ConnectionPool.getInstance().getConnection();
			conn = connItem.getConn();

			pstmt = conn.prepareStatement("INSERT INTO book_tbl VALUES (?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, bookDTO.getBOOK_CODE());
			pstmt.setString(2, bookDTO.getCLASSIFICATION_ID());
			pstmt.setString(3, bookDTO.getBOOK_AUTHOR());
			pstmt.setString(4, bookDTO.getBOOK_NAME());
			pstmt.setString(5, bookDTO.getPUBLISHER());
			pstmt.setString(6, bookDTO.getISRESERVE());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new SQLException("BookDAO's INSERT SQL EXCEPTION !!");
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception ignore) {
				}
		}
	}

	@Override
	public int update(BookDTO bookDTO) throws SQLException {

		return 0;
	}

	@Override
	public int delete(BookDTO bookDTO) throws SQLException {
		try {

			pstmt = conn.prepareStatement("DELETE FROM book_tbl WHERE BOOK_CODE = ?");
			pstmt.setString(1, bookDTO.getBOOK_CODE());

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new SQLException("BookDAO's DELETE SQL EXCEPTION !!");
		} finally {
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}
	}

	@Override
	public BookDTO select(BookDTO bookDTO) {
		return null;
	}

	@Override
	public List<BookDTO> selectAll() {
		return null;
	}

}

```

---

> **BookDTO**
> 

```java
package Domain;

public class BookDTO {
	private String BOOK_CODE;
	private String CLASSIFICATION_ID;
	private String BOOK_AUTHOR;
	private String BOOK_NAME;	
	private String PUBLISHER;
	private String ISRESERVE;
	
	public BookDTO() {}

	public BookDTO(String bOOK_CODE, String cLASSIFICATION_ID, String bOOK_AUTHOR, String bOOK_NAME, String pUBLISHER,
			String iSRESERVE) {
		super();
		BOOK_CODE = bOOK_CODE;
		CLASSIFICATION_ID = cLASSIFICATION_ID;
		BOOK_AUTHOR = bOOK_AUTHOR;
		BOOK_NAME = bOOK_NAME;
		PUBLISHER = pUBLISHER;
		ISRESERVE = iSRESERVE;
	}

	public String getBOOK_CODE() {
		return BOOK_CODE;
	}

	public void setBOOK_CODE(String bOOK_CODE) {
		BOOK_CODE = bOOK_CODE;
	}

	public String getCLASSIFICATION_ID() {
		return CLASSIFICATION_ID;
	}

	public void setCLASSIFICATION_ID(String cLASSIFICATION_ID) {
		CLASSIFICATION_ID = cLASSIFICATION_ID;
	}

	public String getBOOK_AUTHOR() {
		return BOOK_AUTHOR;
	}

	public void setBOOK_AUTHOR(String bOOK_AUTHOR) {
		BOOK_AUTHOR = bOOK_AUTHOR;
	}

	public String getBOOK_NAME() {
		return BOOK_NAME;
	}

	public void setBOOK_NAME(String bOOK_NAME) {
		BOOK_NAME = bOOK_NAME;
	}

	public String getPUBLISHER() {
		return PUBLISHER;
	}

	public void setPUBLISHER(String pUBLISHER) {
		PUBLISHER = pUBLISHER;
	}

	public String getISRESERVE() {
		return ISRESERVE;
	}

	public void setISRESERVE(String iSRESERVE) {
		ISRESERVE = iSRESERVE;
	}

	@Override
	public String toString() {
		return "BookDTO [BOOK_CODE=" + BOOK_CODE + ", CLASSIFICATION_ID=" + CLASSIFICATION_ID + ", BOOK_AUTHOR="
				+ BOOK_AUTHOR + ", BOOK_NAME=" + BOOK_NAME + ", PUBLISHER=" + PUBLISHER + ", ISRESERVE=" + ISRESERVE
				+ "]";
	}

	
}

```

---

# Main

---

> **Main**
> 

```java
package Main;

import Viewer.Viewer;

public class Main {
	public static void main(String[] args) throws Exception{
		new Viewer().MainMenu();
	}
}
```

---

# Service

> **BookServiceImpl**
> 

```java
package Service;

import java.sql.SQLException;

import Domain.BookDAO;
import Domain.BookDAOImpl;
import Domain.BookDTO;
import Domain.ConnectionPool.ConnectionPool;

public class BookServiceImpl {
	
	private BookDAO bookDAO;
	private ConnectionPool connectionPool;
	
	
	private static BookServiceImpl instance;
	private BookServiceImpl() throws ClassNotFoundException, SQLException {
		bookDAO = BookDAOImpl.getInstance();
		connectionPool = ConnectionPool.getInstance();
		System.out.println("[Service] BookServiceImpl init..");
	}
	public static BookServiceImpl getInstance() throws ClassNotFoundException, SQLException {
		if(instance == null) {
			instance = new BookServiceImpl();
		}
		return instance;
	}
	
	// 회원가입 (tx)
	public boolean bookJoin(BookDTO bookDTO) throws Exception {
		boolean isJoin = false;
		try {
	        connectionPool.beginTransaction();

	        int result = bookDAO.insert(bookDTO);
	        if (result <= 0) {
	            throw new Exception("도서 등록 실패 (insert 결과 0)");
	        }

	        isJoin = true;
	        connectionPool.commitTransaction();

	    } catch (Exception e) {
	        System.err.println("[bookJoin] 예외 발생 → 롤백 수행");
	        connectionPool.rollbackTransaction();
	        e.printStackTrace();
	        throw e; // 상위로 예외 전달
	    }
		
		
		return  isJoin;

	}
//	public boolean bookRegistration(BookDTO bookDTO) throws Exception {
//		return bookDAO.insert(bookDTO) > 0;
//	}
}

```

---

# Test

> **ControllerTest**
> 

```java
package Test;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Test;

import Controller.FrontController;

public class ControllerTest {

	FrontController fc = FrontController.getInstance();
	
	@Test
	void test() {
		//View에서 요청정보 담기
		Map<String,Object> params = new HashMap<>();
		params.put("endPoint", "/book");//endPoint
		params.put("serviceNo", 1);	//ServiceNo
		//도서등록-인자전달
		params.put("BOOK_CODE","21111112");
		params.put("CLASSIFICATION_ID","이것이리눅스다");
		params.put("BOOK_AUTHOR","한빛미디어");
		params.put("BOOK_NAME","1111-1111");
		params.put("PUBLISHER","ddddd");
		params.put("ISRESERVE","1111-1111");
		//요청하기
		Map<String,Object> response =  fc.execute(params);
		
		//응답확인
		for(String key : response.keySet()) {
			System.out.println(key + " : " + response.get(key));
		}
	}
}
```

---

> **DAOTest**
> 

```java
package Test;

import org.junit.jupiter.api.Test;

import Domain.BookDAO;
import Domain.BookDAOImpl;
import Domain.BookDTO;

public class DAOTest {
	
	@Test
	void test1() throws Exception{
		BookDAO bookDAOImpl = BookDAOImpl.getInstance();
	}
	
	
	@Test
	void test2() throws Exception {
		BookDAO bookDAOImpl = BookDAOImpl.getInstance();
		bookDAOImpl.insert(new BookDTO("aabbccc","홍길동12","12341212","11234","qwerq","asdf"));
	}
}
```

---

> **ServiceTest**
> 

```java
package Test;

import org.junit.jupiter.api.Test;
import Domain.BookDTO;
import Service.BookServiceImpl;

public class ServiceTest {
	
	@Test
	void test() throws Exception{
		BookServiceImpl bookService = BookServiceImpl.getInstance();
		bookService.bookJoin(new BookDTO("q2ww2201","C언어기본","코리아미디어","1010-1010","asdfas","1324qwearf"));
	}
}
```

---

# Viewer

> **Viewer**
> 

```java
package Viewer;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import Controller.FrontController;

public class Viewer {
	// 사용자의 상태정보
	private String userid; // UserId
	private String username; // Username
	private String role;

	private Scanner sc = new Scanner(System.in);

	private FrontController controller;

	public Viewer() throws Exception {
		controller = FrontController.getInstance();
	}

	public void MainMenu() {

		while (true) {
		    System.out.println("------------M E N U--------------");
		    System.out.println("1 Book_Tbl");
		    System.out.println("2 Member_Tbl");
		    System.out.println("3 Rental_Tbl");
		    System.out.println("4 Exit");
		    System.out.print("번호 : ");
		    int num = sc.nextInt();

		    if (num == 4) {
		    	System.out.println("[SYSTEM] 시스템을 종료합니다!!");
		    	break; // 종료 조건
		    }

		    if (num != 1) {
		        System.out.println("다시 입력해주세요");
		        continue; // 메뉴 처음으로 다시
		    }

		    while (true) { // Book_Tbl 서브 메뉴 루프
		        System.out.println("1 Insert");
		        System.out.println("2 Update");
		        System.out.println("3 Select");
		        System.out.println("4 SelectAll");
		        System.out.println("5 Delete");
		        System.out.println("6 Prev");
		        System.out.print("번호 : ");
		        int subNum = sc.nextInt();

		        switch (subNum) {
		            case 1:
		                // insert 메서드
		                break;
		            case 2:
		                // update 메서드
		                break;
		            case 3:
		                // Select 메서드
		                break;
		            case 4:
		                // selectAll 메서드
		                break;
		            case 5:
		                // delete 메서드
		                break;
		            case 6:
		                // 서브메뉴 종료 → 메인 메뉴로 돌아감
		                System.out.println("메인 메뉴로 돌아갑니다.");
		                break;
		            default:
		                System.out.println("다시 입력해주세요.");
		        }

		        if (subNum == 6) break; // 내부 while 탈출
		    }
		}

	}

	public void Insert() {
		System.out.println("--------------------------");
		System.out.println("회원정보 입력");
		System.out.println("--------------------------");
		System.out.print("USERID : ");
		String id = sc.next();
		System.out.print("USERNAME : ");
		String name = sc.next();
		System.out.print("PASSWORD: ");
		String pw = sc.next();

		// 요청처리
		Map<String, Object> params = new HashMap<>();
		params.put("endPoint", "/user");
		params.put("serviceNo", 1);
		params.put("userid", id);
		params.put("username", name);
		params.put("password", pw);

		Map<String, Object> response = controller.execute(params);

		for (String key : response.keySet())
			System.out.println(key + " : " + response.get(key));

	}

	public void loginMenu() {
		System.out.println("--------------------------");
		System.out.println("로그인");
		System.out.println("--------------------------");
		System.out.print("ID : ");
		String id = sc.next();
		System.out.print("PW : ");
		String pw = sc.next();

	}

	public void 사서Menu() {
		while (true) {
			System.out.println("--------------------------");
			System.out.println("사서메뉴");
			System.out.println("--------------------------");
			System.out.println("[도서]			[회원]			[대여]");
			System.out.println("1 도서조회하기		5 회원 전체조회		7 도서 대여");
			System.out.println("2 도서추가하기		6 회원 단건조회		8 도서 반납");
			System.out.println("3 도서수정하기		 						");
			System.out.println("4 도서삭제하기								");
			System.out.println("9 이전으로");
			System.out.println("10로그아웃");
			System.out.print("번호 : ");
			int num = sc.nextInt();
			switch (num) {
			case 1:

				break;
			case 2:
				BookMenu();
				break;
			case 3:
				break;

			case 7:

				break;

			case 10:

				// 로그아웃
				return;
			}

		}
	}

	public void 회원Menu() {
		while (true) {
			System.out.println("--------------------------");
			System.out.println("회원메뉴");
			System.out.println("--------------------------");
			System.out.println("[도서]			[회원]			[대여]");
			System.out.println("1 도서조회하기		5 나의 정보조회		8 대여 도서 조회");
			System.out.println("2 도서추가하기		6 나의 정보수정		9 대여 도서 예약");
			System.out.println("3 도서수정하기		7 회원 탈퇴					");
			System.out.println("4 도서삭제하기									");

			System.out.println("10 이전으로");
			System.out.println("11 로그아웃");
			System.out.print("번호 : ");
			int num = sc.nextInt();
			switch (num) {
			case 1:
				break;
			case 2:
				break;
			case 3:
				break;

			case 5:
				return;

			}
		}
	}

	public void BookMenu() {
		System.out.println("--------------------------");
		System.out.println("도서 정보 입력");
		System.out.println("--------------------------");
		System.out.printf("도서코드 도서명 출판사 ISBN순으로 입력 : ");
		String bookcode = sc.next();
		String bookname = sc.next();
		String publisher = sc.next();
		String isbn = sc.next();

		// 컨트롤러 호출!

	}

	public void MemberMenu() {
		System.out.println("--------------------------");
		System.out.println("회원 정보 입력");
		System.out.println("--------------------------");
		System.out.printf("ID PW USERNAME ROLE 순으로 입력 : ");
		String id = sc.next();
		String pw = sc.next();
		String username = sc.next();
		String role = sc.next();

	}

	public void LendMenu() {
		System.out.println("--------------------------");
		System.out.println("대여 정보 입력");
		System.out.println("--------------------------");

		System.out.printf("BOOKCODE USERID 입력 : ");
		int bookcode = sc.nextInt();
		String id = sc.next();

	}
}

```

---