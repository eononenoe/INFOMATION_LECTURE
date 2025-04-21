
# 📁 MVC_FILEUPDOWNLOAD 프로젝트 정리

---
## 📄 BookCreateController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookCreateController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookCreateController implements SubController{
```

📌 **등장 메서드 목록**
- `execute`
- `BookCreateController`
- `class BookCreateController implements SubController{`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookDeleteController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookDeleteController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookDeleteController implements SubController {
```

📌 **등장 메서드 목록**
- `execute`
- `class BookDeleteController implements SubController {`
- `BookDeleteController`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookListController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookListController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
```

📌 **등장 메서드 목록**
- `execute`
- `class BookListController implements SubController{`
- `BookListController`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookReadController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookReadController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.BookServiceImpl;
```

📌 **등장 메서드 목록**
- `execute`
- `BookReadController`
- `class BookReadController implements SubController{`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookReplyCreateController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookReplyCreateController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import java.io.PrintWriter;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
```

📌 **등장 메서드 목록**
- `BookReplyCreateController`
- `execute`
- `class BookReplyCreateController implements SubController{`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
🔐 **getSession()**: 사용자와 서버 간의 세션 객체를 가져올 때 사용됩니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookReplyListController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookReplyListController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
```

📌 **등장 메서드 목록**
- `execute`
- `class BookReplyListController implements SubController{`
- `BookReplyListController`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookUpdateController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/book/BookUpdateController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookUpdateController implements SubController {
```

📌 **등장 메서드 목록**
- `execute`
- `exceptionHandler`
- `BookUpdateController`
- `class BookUpdateController implements SubController {`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 ListController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/file/ListController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.file;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
```

📌 **등장 메서드 목록**
- `execute`
- `ListController`
- `class ListController implements SubController{`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 Properties.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/file/Properties.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.file;

public class Properties {
	public static String ROOT_PATH = "c:";
	public static String UPLOAD_PATH = "upload";
}
```

📌 **등장 메서드 목록**
- `static String UPLOAD_PATH = "upload";`
- `class Properties {`
- `static String ROOT_PATH = "c:";`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 UploadController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/file/UploadController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.file;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.FileServiceImpl;

public class UploadController implements SubController{
```

📌 **등장 메서드 목록**
- `execute`
- `class UploadController implements SubController{`
- `UploadController`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 AdminMainController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/user/AdminMainController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;

public class AdminMainController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
```

📌 **등장 메서드 목록**
- `execute`
- `class AdminMainController implements SubController{`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 ManagerMainController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/user/ManagerMainController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;

public class ManagerMainController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
```

📌 **등장 메서드 목록**
- `execute`
- `class ManagerMainController implements SubController{`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 UserMainController.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Controller/user/UserMainController.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;

public class UserMainController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
```

📌 **등장 메서드 목록**
- `execute`
- `class UserMainController implements SubController{`
- `exceptionHandler`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookDao.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dao/BookDao.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.SQLException;
import java.util.List;

import Domain.Dto.BookDto;
import Domain.Dto.Criteria;
import Domain.Dto.UserDto;

public interface BookDao {
```

📌 **등장 메서드 목록**
- `interface BookDao {`
- `long count`
- `List<BookDto> selectAll`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookDaoImpl.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dao/BookDaoImpl.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import Domain.Dao.ConnectionPool.ConnectionItem;
```

📌 **등장 메서드 목록**
- `BookDto select`
- `int insert`
- `int update`
- `static BookDao getInstance`
- `int delete`
- `UserDto select`
- `long count`
- `List<BookDto> selectAll`
- `class BookDaoImpl implements BookDao {`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookReplyDaoImpl.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dao/BookReplyDaoImpl.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import Domain.Dto.BookDto;
import Domain.Dto.BookReplyDto;
```

📌 **등장 메서드 목록**
- `int insert`
- `List<BookReplyDto> selectAll`
- `class BookReplyDaoImpl extends Dao {`
- `long count`
- `static BookReplyDaoImpl getInstance`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookDto.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dto/BookDto.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
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
```

📌 **등장 메서드 목록**
- `setIsbn`
- `String getIsbn`
- `String getBookName`
- `setPublisher`
- `setBookName`
- `String toString`
- `setBookCode`
- `String getBookCode`
- `String getPublisher`
- `BookDto`
- `class BookDto {`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookReplyDto.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dto/BookReplyDto.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dto;

import java.time.LocalDateTime;

public class BookReplyDto {
	private int no;
	private String bookCode;
	private String username;
	private String contents;
	private LocalDateTime createAt;
```

📌 **등장 메서드 목록**
- `int getNo`
- `LocalDateTime getCreateAt`
- `setCreateAt`
- `setUsername`
- `String getContents`
- `class BookReplyDto {`
- `String toString`
- `setBookCode`
- `String getBookCode`
- `BookReplyDto`
- `setContents`
- `setNo`
- `String getUsername`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 Criteria.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dto/Criteria.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dto;

public class Criteria {
	private int pageno; 	//현재 페이지
	private int amount;		//페이지 당 보여줄 게시물 건수
	private String type;	//타입(도서명 , 도서코드 , 출판사)
	private String keyword;	//키워드
	
	public Criteria() {
		//처음페이지로 들어왔을떄 기본값
```

📌 **등장 메서드 목록**
- `setType`
- `setPageno`
- `String toString`
- `setKeyword`
- `int getAmount`
- `String getType`
- `String getKeyword`
- `setAmount`
- `class Criteria {`
- `int getPageno`
- `Criteria`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 PageDto.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Dto/PageDto.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dto;

public class PageDto {
	private static final long serialVersionUID = 5L;

	private long totalCount;		//전체 게시물 건수 count
	//페이지정보
	private int totalpage;			//총게시물건수 / amount
	private Criteria criteria;		//현재페이지,한페이지당 읽을 게시물의 건수가 저장되어있음
	//블럭정보
```

📌 **등장 메서드 목록**
- `setEndPage`
- `setNowBlock`
- `int getNowBlock`
- `int getEndPage`
- `int getPagePerBlock`
- `int getTotalBlock`
- `int getStartPage`
- `Criteria getCriteria`
- `long getTotalCount`
- `setTotalCount`
- `setCriteria`
- `String toString`
- `setNext`
- `int getTotalpage`
- `class PageDto {`
- `setPagePerBlock`
- `setTotalBlock`
- `setPrev`
- `boolean isNext`
- `setStartPage`
- `PageDto`
- `boolean isPrev`
- `setTotalpage`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookServiceImpl.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Service/BookServiceImpl.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import Domain.Dao.BookDao;
import Domain.Dao.BookDaoImpl;
import Domain.Dao.BookReplyDaoImpl;
import Domain.Dto.BookDto;
```

📌 **등장 메서드 목록**
- `Map<String, Object> getBook`
- `boolean modifyBook`
- `boolean bookReplyAdd`
- `boolean removeBook`
- `Map<String, Object> getAllBooks`
- `long bookReplyCount`
- `Map<String,Object> getAllBooks`
- `static BookServiceImpl getInstance`
- `List<BookReplyDto> getAllBookReply`
- `class BookServiceImpl {`
- `boolean bookRegistration`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.

---

## 📄 FileServiceImpl.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Domain/Service/FileServiceImpl.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
```

📌 **등장 메서드 목록**
- `Map<String , List<File> > getFileList`
- `class FileServiceImpl {`
- `boolean upload`
- `static FileServiceImpl getInstance`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.

---

## 📄 PermissionFilter.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Filter/PermissionFilter.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
```

📌 **등장 메서드 목록**
- `init`
- `class PermissionFilter implements Filter{`
- `doFilter`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
🌐 **getRequestURI()**: 클라이언트가 요청한 URI 경로를 반환합니다.
🚧 **doFilter()**: 필터 체인에서 요청을 가로채어 전처리/후처리를 수행하는 메서드입니다.
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
🔐 **getSession()**: 사용자와 서버 간의 세션 객체를 가져올 때 사용됩니다.
🛠 **init()**: 서블릿 초기화 시 실행되는 메서드입니다.

---

## 📄 ServiceTests.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Tests/ServiceTests.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Tests;

import org.junit.jupiter.api.Test;

import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

class ServiceTests {

	@Test
```

📌 **등장 메서드 목록**
- `test`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 Role.java

📂 **위치**: `13MVC_FILEUPDOWNLOAD/src/main/java/Type/Role.java`

✍️ **파일 간단 설명**  
도서 관련 기능을 처리하는 서브 컨트롤러입니다.

🧩 **코드 일부 발췌**
```java
package Type;

public enum Role {
	ROLE_ANONYMOUS,		//0
	ROLE_USER,			//1
	ROLE_MANAGER,		//2
	ROLE_ADMIN			//3
}
```

📌 **등장 메서드 목록**
- `enum Role {`

🧠 **흐름 정리**  
SubController를 구현하여 요청 URI에 따라 실행되며, 요청 정보를 처리하고 뷰로 포워딩합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---