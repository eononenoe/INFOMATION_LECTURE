
# 💻 MVC_REPLY 프로젝트 정리

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

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/FrontController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
```

📌 **등장 메서드 목록**
- `System.out.println`
- `String endPoint = req.getServletPath`
- `protected void service`
- `void exceptionHandler`
- `void init`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.
🛠 **init()**: 서블릿 초기화 시 실행되는 메서드입니다.

---

## 📄 HomeController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/HomeController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
```

📌 **등장 메서드 목록**
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 SubController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/SubController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SubController {
	public void execute (HttpServletRequest req, HttpServletResponse resp);
}
```

📌 **등장 메서드 목록**
- `void execute`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookCreateController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookCreateController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `String publisher = req.getParameter`
- `String isbn = req.getParameter`
- `String bookCode = req.getParameter`
- `String uri = req.getMethod`
- `BookCreateController`
- `boolean isadded =  bookService.bookRegistration`
- `private boolean isValid`
- `void execute`
- `void exceptionHandler`
- `String bookName = req.getParameter`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookDeleteController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookDeleteController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `String pageno = req.getParameter`
- `String bookCode = req.getParameter`
- `boolean isDelete = bookService.removeBook`
- `BookDeleteController`
- `private boolean isValid`
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookListController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookListController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `String pageno = req.getParameter`
- `String keyword =req.getParameter`
- `void exceptionHandler`
- `String type = req.getParameter`
- `BookListController`
- `private boolean isValid`
- `void execute`
- `String amount = req.getParameter`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookReadController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookReadController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `String pageno = req.getParameter`
- `String bookCode = req.getParameter`
- `BookReadController`
- `private boolean isValid`
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookReplyCreateController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookReplyCreateController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `String contents = req.getParameter`
- `String bookCode = req.getParameter`
- `boolean isAdded=bookService.bookReplyAdd`
- `void exceptionHandler`
- `private boolean isValid`
- `void execute`
- `String username = null;`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
🔐 **getSession()**: 사용자와 서버 간의 세션 객체를 가져올 때 사용됩니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookReplyListController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookReplyListController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `private boolean isValid`
- `String JsonData = objectMapper.writeValueAsString`
- `String bookCode =req.getParameter`
- `BookReplyListController`
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookUpdateController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/book/BookUpdateController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `String pageno = req.getParameter`
- `String publisher = req.getParameter`
- `BookUpdateController`
- `String isbn = req.getParameter`
- `String bookCode = req.getParameter`
- `boolean isUpdate = bookService.modifyBook`
- `private boolean isValid`
- `void execute`
- `void exceptionHandler`
- `String bookName = req.getParameter`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 AdminMainController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/user/AdminMainController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 ManagerMainController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/user/ManagerMainController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 UserCreateController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/user/UserCreateController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.UserDto;
import Domain.Service.UserServiceImpl;

public class UserCreateController implements SubController{
```

📌 **등장 메서드 목록**
- `String username = req.getParameter`
- `String uri = req.getMethod`
- `UserCreateController`
- `boolean isJoin =  userService.userJoin`
- `String role = "ROLE_USER";`
- `boolean isOk = isValid`
- `private boolean isValid`
- `void execute`
- `String password = req.getParameter`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 UserLoginController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/user/UserLoginController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
```

📌 **등장 메서드 목록**
- `String username = req.getParameter`
- `String uri = req.getMethod`
- `UserLoginController`
- `String message =`
- `boolean isOk = isValid`
- `boolean isLogin = false;`
- `private boolean isValid`
- `void execute`
- `String password = req.getParameter`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
🔡 **getParameter()**: 사용자의 폼 입력 값 등 요청 파라미터를 읽어오는 메서드입니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
🔐 **getSession()**: 사용자와 서버 간의 세션 객체를 가져올 때 사용됩니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 UserLogoutController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/user/UserLogoutController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Controller.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.SubController;
import Domain.Service.UserServiceImpl;
```

📌 **등장 메서드 목록**
- `boolean isOk =  isValid`
- `String role =`
- `void exceptionHandler`
- `private boolean isValid`
- `UserLogoutController`
- `void execute`
- `String username =`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
🔐 **getSession()**: 사용자와 서버 간의 세션 객체를 가져올 때 사용됩니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 UserMainController.java

📂 **위치**: `12MVC_REPLY/src/main/java/Controller/user/UserMainController.java`

✍️ **파일 간단 설명**  
요청을 받아서 처리 흐름을 제어하는 클래스입니다.

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
- `void execute`
- `void exceptionHandler`

🧠 **흐름 정리**  
이 클래스는 **Controller** 역할을 수행하며, 요청을 받아서 처리 흐름을 제어하는 클래스입니다.

🔍 **추가 개념 설명**  
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
➡ **forward()**: 다른 JSP나 서블릿으로 요청을 전달(포워딩)합니다.
🧭 **execute()**: SubController에서 요청을 처리하는 핵심 메서드입니다.

---

## 📄 BookDao.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/BookDao.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

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
- `long count`
- `int update`
- `int delete`
- `List<BookDto> selectAll`
- `int insert`
- `BookDto select`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookDaoImpl.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/BookDaoImpl.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

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
- `String type = criteria.getType`
- `long count`
- `//	private String id="root";`
- `UserDto select`
- `//	private String pw="1234";`
- `int update`
- `String keyword = criteria.getKeyword`
- `int delete`
- `List<BookDto> selectAll`
- `int insert`
- `BookDto select`
- `//	private String url="jdbc:mysql://localhost:3306/bookDB";`
- `static BookDao getInstance`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookReplyDaoImpl.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/BookReplyDaoImpl.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

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
- `static BookReplyDaoImpl getInstance`
- `List<BookReplyDto> selectAll`
- `int insert`
- `long count`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 Dao.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/Dao.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Domain.Dao.ConnectionPool.ConnectionItem;
import Domain.Dao.ConnectionPool.ConnectionPool;

public abstract class Dao {
```

📌 **등장 메서드 목록**
- `Dao`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 UserDao.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/UserDao.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.SQLException;
import java.util.List;

import Domain.Dto.UserDto;



public interface UserDao {
```

📌 **등장 메서드 목록**
- `int delete`
- `int insert`
- `UserDto select`
- `int update`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 UserDaoImpl.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/UserDaoImpl.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import Domain.Dto.UserDto;
```

📌 **등장 메서드 목록**
- `UserDto select`
- `int update`
- `static UserDao getInstance`
- `int delete`
- `List<UserDto> selectAll`
- `int insert`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 ConnectionItem.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/ConnectionPool/ConnectionItem.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Dao.ConnectionPool;

import java.sql.Connection;

import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;

public class ConnectionItem {
	private Connection conn;
	private boolean isUse;
```

📌 **등장 메서드 목록**
- `boolean isUse`
- `void setXaResource`
- `boolean getInTransaction`
- `ConnectionItem`
- `void setInTransaction`
- `private boolean isUse;`
- `private boolean inTransaction;`
- `XAResource getXaResource`
- `void setXid`
- `Xid getXid`
- `void setUse`
- `Connection getConn`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 ConnectionPool.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dao/ConnectionPool/ConnectionPool.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

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
```

📌 **등장 메서드 목록**
- `int getFormatId`
- `byte[] getGlobalTransactionId`
- `private String id="root";`
- `private static Xid createXid`
- `private int formatId = 1;`
- `private String url="jdbc:mysql://localhost:3306/testDB";;`
- `private final int size=10;`
- `void beginTransaction`
- `synchronized ConnectionItem getConnection`
- `for`
- `private String pw="1234";`
- `synchronized void releaseConnection`
- `void commitTransaction`
- `byte[] getBranchQualifier`
- `static ConnectionPool getInstance`
- `void rollbackTransaction`
- `int prepare = xaResource.prepare`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookDto.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dto/BookDto.java`

✍️ **파일 간단 설명**  
데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

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
- `String getBookCode`
- `void setBookCode`
- `void setBookName`
- `String getIsbn`
- `private String publisher;`
- `void setIsbn`
- `void setPublisher`
- `private String bookName;`
- `private String isbn;`
- `private String bookCode;`
- `String getPublisher`
- `String toString`
- `BookDto`
- `String getBookName`

🧠 **흐름 정리**  
이 클래스는 **DTO** 역할을 수행하며, 데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookReplyDto.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dto/BookReplyDto.java`

✍️ **파일 간단 설명**  
데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

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
- `String getBookCode`
- `void setBookCode`
- `void setCreateAt`
- `void setUsername`
- `void setNo`
- `String getContents`
- `private String username;`
- `private int no;`
- `LocalDateTime getCreateAt`
- `private String bookCode;`
- `String getUsername`
- `BookReplyDto`
- `int getNo`
- `void setContents`
- `String toString`
- `private String contents;`

🧠 **흐름 정리**  
이 클래스는 **DTO** 역할을 수행하며, 데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 Criteria.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dto/Criteria.java`

✍️ **파일 간단 설명**  
데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

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
- `private int amount;		//페이지 당 보여줄 게시물 건수`
- `void setType`
- `String getKeyword`
- `void setKeyword`
- `private int pageno; 	//현재 페이지`
- `void setAmount`
- `String getType`
- `int getPageno`
- `int getAmount`
- `Criteria`
- `private String keyword;	//키워드`
- `private String type;	//타입`
- `String toString`
- `void setPageno`

🧠 **흐름 정리**  
이 클래스는 **DTO** 역할을 수행하며, 데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 PageDto.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dto/PageDto.java`

✍️ **파일 간단 설명**  
데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

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
- `private int nowBlock;			//현재페이지번호 /pagePerBlock`
- `private int startPage;`
- `void setTotalCount`
- `private int pagePerBlock;		//블럭에 표시할 페이지개수`
- `void setTotalBlock`
- `int getStartPage`
- `long getTotalCount`
- `void setPrev`
- `void setStartPage`
- `boolean isPrev`
- `void setEndPage`
- `void setCriteria`
- `private int totalpage;			//총게시물건수 / amount`
- `int getTotalBlock`
- `private boolean prev,next;`
- `void setNowBlock`
- `Criteria getCriteria`
- `void setTotalpage`
- `private int endPage;`
- `void setNext`
- `int getNowBlock`
- `boolean isNext`
- `private int totalBlock;			//totalpage / pagePerBlock`
- `void setPagePerBlock`
- `int getTotalpage`
- `PageDto`
- `int getPagePerBlock`
- `int getEndPage`
- `String toString`

🧠 **흐름 정리**  
이 클래스는 **DTO** 역할을 수행하며, 데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 UserDto.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Dto/UserDto.java`

✍️ **파일 간단 설명**  
데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

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
```

📌 **등장 메서드 목록**
- `private String role;`
- `void setUsername`
- `String getRole`
- `private String username;`
- `UserDto`
- `String getUsername`
- `void setPassword`
- `String getPassword`
- `void setRole`
- `String toString`
- `private String password;`

🧠 **흐름 정리**  
이 클래스는 **DTO** 역할을 수행하며, 데이터 전달 객체로, 계층 간 데이터 이동을 담당합니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 BookServiceImpl.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Service/BookServiceImpl.java`

✍️ **파일 간단 설명**  
비즈니스 로직을 처리하는 서비스 클래스입니다.

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
- `int amount = criteria.getAmount`
- `int offset =`
- `String type = criteria.getType`
- `boolean removeBook`
- `static BookServiceImpl getInstance`
- `String keyword = criteria.getKeyword`
- `int result = bookDao.update`
- `boolean bookReplyAdd`
- `int result = bookDao.delete`
- `boolean modifyBook`
- `Map<String, Object> getAllBooks`
- `int result = bookReplyDaoImpl.insert`
- `long bookReplyCount`
- `boolean bookRegistration`
- `Map<String, Object> getBook`
- `int result = bookDao.insert`
- `List<BookReplyDto> getAllBookReply`
- `Map<String,Object> getAllBooks`

🧠 **흐름 정리**  
이 클래스는 **Service** 역할을 수행하며, 비즈니스 로직을 처리하는 서비스 클래스입니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.

---

## 📄 UserServiceImpl.java

📂 **위치**: `12MVC_REPLY/src/main/java/Domain/Service/UserServiceImpl.java`

✍️ **파일 간단 설명**  
비즈니스 로직을 처리하는 서비스 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Domain.Service;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import Domain.Dao.UserDao;
import Domain.Dao.UserDaoImpl;
```

📌 **등장 메서드 목록**
- `Map<String, Object> logout`
- `boolean isJoin = false;`
- `boolean userJoin`
- `static UserServiceImpl getInstance`
- `boolean isLogin = false;`
- `Map<String,Object> login`

🧠 **흐름 정리**  
이 클래스는 **Service** 역할을 수행하며, 비즈니스 로직을 처리하는 서비스 클래스입니다.

🔍 **추가 개념 설명**  
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.

---

## 📄 PermissionFilter.java

📂 **위치**: `12MVC_REPLY/src/main/java/Filter/PermissionFilter.java`

✍️ **파일 간단 설명**  
요청/응답을 전처리/후처리하는 필터 클래스입니다.

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
- `String projectPath = filterConfig.getServletContext`
- `void doFilter`
- `String myRole =`
- `String requestUri = request.getRequestURI`
- `String uri = request.getRequestURI`
- `void init`

🧠 **흐름 정리**  
이 클래스는 **Filter** 역할을 수행하며, 요청/응답을 전처리/후처리하는 필터 클래스입니다.

🔍 **추가 개념 설명**  
🌐 **getRequestURI()**: 클라이언트가 요청한 URI 경로를 반환합니다.
🚧 **doFilter()**: 필터 체인에서 요청을 가로채어 전처리/후처리를 수행하는 메서드입니다.
📦 **put()**: Java Map에서 Key-Value 형태로 데이터를 저장할 때 사용합니다.
📌 **setAttribute()**: request 또는 session에 데이터를 저장하는 메서드입니다.
🔐 **getSession()**: 사용자와 서버 간의 세션 객체를 가져올 때 사용됩니다.
🛠 **init()**: 서블릿 초기화 시 실행되는 메서드입니다.

---

## 📄 UTF8_EncodingFilter.java

📂 **위치**: `12MVC_REPLY/src/main/java/Filter/UTF8_EncodingFilter.java`

✍️ **파일 간단 설명**  
요청/응답을 전처리/후처리하는 필터 클래스입니다.

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
```

📌 **등장 메서드 목록**
- `void doFilter`

🧠 **흐름 정리**  
이 클래스는 **Filter** 역할을 수행하며, 요청/응답을 전처리/후처리하는 필터 클래스입니다.

🔍 **추가 개념 설명**  
🚧 **doFilter()**: 필터 체인에서 요청을 가로채어 전처리/후처리를 수행하는 메서드입니다.

---

## 📄 DaoTests.java

📂 **위치**: `12MVC_REPLY/src/main/java/Tests/DaoTests.java`

✍️ **파일 간단 설명**  
데이터베이스 접근을 담당하는 클래스입니다.

🧩 **코드 일부 발췌**
```java
package Tests;

import java.time.LocalDateTime;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import Domain.Dao.BookDao;
import Domain.Dao.BookDaoImpl;
import Domain.Dao.BookReplyDaoImpl;
```

📌 **등장 메서드 목록**
- `void test5`
- `void test6`
- `void test4`
- `void test3`
- `void test`
- `void test2`
- `void test7`

🧠 **흐름 정리**  
이 클래스는 **DAO** 역할을 수행하며, 데이터베이스 접근을 담당하는 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 ServiceTests.java

📂 **위치**: `12MVC_REPLY/src/main/java/Tests/ServiceTests.java`

✍️ **파일 간단 설명**  
비즈니스 로직을 처리하는 서비스 클래스입니다.

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
- `void test`

🧠 **흐름 정리**  
이 클래스는 **Service** 역할을 수행하며, 비즈니스 로직을 처리하는 서비스 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---

## 📄 Role.java

📂 **위치**: `12MVC_REPLY/src/main/java/Type/Role.java`

✍️ **파일 간단 설명**  
역할이나 상수 타입을 정의한 클래스입니다.

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
없음

🧠 **흐름 정리**  
이 클래스는 **Enum or Type** 역할을 수행하며, 역할이나 상수 타입을 정의한 클래스입니다.

🔍 **추가 개념 설명**  
특이 키워드 없음

---