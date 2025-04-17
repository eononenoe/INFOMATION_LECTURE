# 💻 MVC_BOOK 프로젝트 정리

Java 서블릿 기반 MVC 웹 애플리케이션으로, 도서와 사용자 정보를 관리할 수 있는 시스템입니다. Controller, DTO, DAO, Service 계층이 명확히 분리되어 있으며, Connection Pool, Servlet Filter 등 다양한 기술 요소가 포함되어 있습니다.

## 🧠 주요 키워드 설명

- **MVC (Model-View-Controller)**: 입력(Controller), 처리(Service/DAO), 출력(View)으로 분리된 구조
- **Servlet**: Java로 작성된 서버 컴포넌트로 요청을 처리함
- **JSP**: 동적 웹 페이지를 생성하는 Java 기반 템플릿 엔진
- **DTO (Data Transfer Object)**: 계층 간 데이터 전달용 객체
- **DAO (Data Access Object)**: DB 접근을 전담하는 객체
- **Service Layer**: 비즈니스 로직을 처리
- **Connection Pool**: DB 연결을 미리 생성하여 재사용
- **Filter**: 요청/응답 흐름을 가로채 처리하는 컴포넌트

---

## 📄 FrontController.java

**📂 위치:** `main/java/Controller/FrontController.java`

✍️ **파일 설명:** public class FrontController extends HttpServlet { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `service()`
- `init()`
- `exceptionHandler()`

🔍 **코드 속 개념 설명:** 해당 없음

🧠 **등장하는 주요 키워드 설명:**

- 📦 **put()**: Java Map 인터페이스에서 key-value 쌍을 저장하는 메서드입니다.
- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🔧 **init()**: 서블릿 초기화 메서드로, 서블릿이 최초 로딩될 때 호출됩니다.
- 🛠 **service()**: 클라이언트 요청을 받아 적절한 doGet/doPost 메서드로 분기하는 메서드입니다.

---

## 📄 HomeController.java

**📂 위치:** `main/java/Controller/HomeController.java`

✍️ **파일 설명:** public class HomeController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 SubController.java

**📂 위치:** `main/java/Controller/SubController.java`

✍️ **파일 설명:** public interface SubController { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SubController {
	public void execute (HttpServletRequest req, HttpServletResponse resp);
}
```

📌 **등장 메서드 목록:**

- `execute()`

🔍 **코드 속 개념 설명:** 해당 없음

🧠 **등장하는 주요 키워드 설명:**

- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 BookCreateController.java

**📂 위치:** `java/Controller/book/BookCreateController.java`

✍️ **파일 설명:** public class BookCreateController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookCreateController implements SubController{
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 BookDeleteController.java

**📂 위치:** `java/Controller/book/BookDeleteController.java`

✍️ **파일 설명:** public class BookDeleteController implements SubController { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookDeleteController implements SubController {
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 BookListController.java

**📂 위치:** `java/Controller/book/BookListController.java`

✍️ **파일 설명:** public class BookListController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.book;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🛠 **service()**: 클라이언트 요청을 받아 적절한 doGet/doPost 메서드로 분기하는 메서드입니다.

---

## 📄 BookReadController.java

**📂 위치:** `java/Controller/book/BookReadController.java`

✍️ **파일 설명:** public class BookReadController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.book;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.BookServiceImpl;

```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🛠 **service()**: 클라이언트 요청을 받아 적절한 doGet/doPost 메서드로 분기하는 메서드입니다.

---

## 📄 BookUpdateController.java

**📂 위치:** `java/Controller/book/BookUpdateController.java`

✍️ **파일 설명:** public class BookUpdateController implements SubController { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

public class BookUpdateController implements SubController {
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 AdminMainController.java

**📂 위치:** `java/Controller/user/AdminMainController.java`

✍️ **파일 설명:** public class AdminMainController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;

public class AdminMainController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
```

📌 **등장 메서드 목록:**

- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 ManagerMainController.java

**📂 위치:** `java/Controller/user/ManagerMainController.java`

✍️ **파일 설명:** public class ManagerMainController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;

public class ManagerMainController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
```

📌 **등장 메서드 목록:**

- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 UserCreateController.java

**📂 위치:** `java/Controller/user/UserCreateController.java`

✍️ **파일 설명:** public class UserCreateController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Dto.UserDto;
import Domain.Service.UserServiceImpl;

public class UserCreateController implements SubController{
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 UserLoginController.java

**📂 위치:** `java/Controller/user/UserLoginController.java`

✍️ **파일 설명:** public class UserLoginController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.user;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🛠 **service()**: 클라이언트 요청을 받아 적절한 doGet/doPost 메서드로 분기하는 메서드입니다.

---

## 📄 UserLogoutController.java

**📂 위치:** `java/Controller/user/UserLogoutController.java`

✍️ **파일 설명:** public class UserLogoutController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.SubController;
import Domain.Service.UserServiceImpl;
```

📌 **등장 메서드 목록:**

- `isValid()`
- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🛠 **service()**: 클라이언트 요청을 받아 적절한 doGet/doPost 메서드로 분기하는 메서드입니다.

---

## 📄 UserMainController.java

**📂 위치:** `java/Controller/user/UserMainController.java`

✍️ **파일 설명:** public class UserMainController implements SubController{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;

public class UserMainController implements SubController{
	private HttpServletRequest req;
	private HttpServletResponse resp;
```

📌 **등장 메서드 목록:**

- `exceptionHandler()`
- `execute()`

🔍 **코드 속 개념 설명:**

- 🚦 컨트롤러 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🔁 **RequestDispatcher**: 다른 리소스로 요청을 전달하거나 포함할 수 있는 객체입니다.
- ➡ **forward()**: 클라이언트 요청을 다른 리소스로 전달하여 응답하게 합니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.

---

## 📄 BookDao.java

**📂 위치:** `java/Domain/Dao/BookDao.java`

✍️ **파일 설명:** public interface BookDao { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Dao;

import java.sql.SQLException;
import java.util.List;

import Domain.Dto.BookDto;
import Domain.Dto.Criteria;
import Domain.Dto.UserDto;

public interface BookDao {
```

📌 **등장 메서드 목록:**

- `count()`
- `selectAll()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:** 없음

---

## 📄 BookDaoImpl.java

**📂 위치:** `java/Domain/Dao/BookDaoImpl.java`

✍️ **파일 설명:** public class BookDaoImpl implements BookDao { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `select()`
- `delete()`
- `update()`
- `insert()`
- `count()`
- `selectAll()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)
- 🔌 커넥션 풀 또는 DB 연결 처리

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 Dao.java

**📂 위치:** `java/Domain/Dao/Dao.java`

✍️ **파일 설명:** Java 클래스 파일입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Domain.Dao.ConnectionPool.ConnectionItem;
import Domain.Dao.ConnectionPool.ConnectionPool;

public abstract class Dao {
```

📌 **등장 메서드 목록:** 없음

🔍 **코드 속 개념 설명:** 해당 없음

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 UserDao.java

**📂 위치:** `java/Domain/Dao/UserDao.java`

✍️ **파일 설명:** public interface UserDao { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Dao;

import java.sql.SQLException;
import java.util.List;

import Domain.Dto.UserDto;



public interface UserDao {
```

📌 **등장 메서드 목록:** 없음

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:** 없음

---

## 📄 UserDaoImpl.java

**📂 위치:** `java/Domain/Dao/UserDaoImpl.java`

✍️ **파일 설명:** public class UserDaoImpl extends Dao implements UserDao{ 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import Domain.Dto.UserDto;



```

📌 **등장 메서드 목록:**

- `select()`
- `delete()`
- `update()`
- `insert()`
- `selectAll()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)
- 🔌 커넥션 풀 또는 DB 연결 처리

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🔧 **init()**: 서블릿 초기화 메서드로, 서블릿이 최초 로딩될 때 호출됩니다.

---

## 📄 ConnectionItem.java

**📂 위치:** `Domain/Dao/ConnectionPool/ConnectionItem.java`

✍️ **파일 설명:** public class ConnectionItem { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Dao.ConnectionPool;

import java.sql.Connection;

import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;

public class ConnectionItem {
	private Connection conn;
	private boolean isUse;
```

📌 **등장 메서드 목록:**

- `getInTransaction()`
- `setXid()`
- `setInTransaction()`
- `setUse()`
- `getConn()`
- `getXid()`
- `setXaResource()`
- `getXaResource()`
- `isUse()`

🔍 **코드 속 개념 설명:** 해당 없음

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 ConnectionPool.java

**📂 위치:** `Domain/Dao/ConnectionPool/ConnectionPool.java`

✍️ **파일 설명:** public class ConnectionPool { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `commitTransaction()`
- `rollbackTransaction()`
- `getFormatId()`
- `beginTransaction()`

🔍 **코드 속 개념 설명:**

- 🔌 커넥션 풀 또는 DB 연결 처리

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 BookDto.java

**📂 위치:** `java/Domain/Dto/BookDto.java`

✍️ **파일 설명:** public class BookDto { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `setIsbn()`
- `getPublisher()`
- `setBookName()`
- `setPublisher()`
- `toString()`
- `setBookCode()`
- `getIsbn()`
- `getBookName()`
- `getBookCode()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 Criteria.java

**📂 위치:** `java/Domain/Dto/Criteria.java`

✍️ **파일 설명:** public class Criteria { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `toString()`
- `getPageno()`
- `setKeyword()`
- `getAmount()`
- `setAmount()`
- `setPageno()`
- `getType()`
- `getKeyword()`
- `setType()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 PageDto.java

**📂 위치:** `java/Domain/Dto/PageDto.java`

✍️ **파일 설명:** public class PageDto { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `getStartPage()`
- `setTotalBlock()`
- `setPagePerBlock()`
- `getTotalBlock()`
- `getNowBlock()`
- `setStartPage()`
- `setNowBlock()`
- `getTotalpage()`
- `setEndPage()`
- `getPagePerBlock()`
- `getTotalCount()`
- `setCriteria()`
- `toString()`
- `getCriteria()`
- `isNext()`
- `getEndPage()`
- `setTotalpage()`
- `setPrev()`
- `setNext()`
- `isPrev()`
- `setTotalCount()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 UserDto.java

**📂 위치:** `java/Domain/Dto/UserDto.java`

✍️ **파일 설명:** public class UserDto { 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `getPassword()`
- `setRole()`
- `getRole()`
- `toString()`
- `getUsername()`
- `setUsername()`
- `setPassword()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 BookServiceImpl.java

**📂 위치:** `java/Domain/Service/BookServiceImpl.java`

✍️ **파일 설명:** public class BookServiceImpl { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import Domain.Dao.BookDao;
import Domain.Dao.BookDaoImpl;
import Domain.Dto.BookDto;
import Domain.Dto.Criteria;
```

📌 **등장 메서드 목록:**

- `bookRegistration()`
- `modifyBook()`
- `removeBook()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📦 **put()**: Java Map 인터페이스에서 key-value 쌍을 저장하는 메서드입니다.
- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 UserServiceImpl.java

**📂 위치:** `java/Domain/Service/UserServiceImpl.java`

✍️ **파일 설명:** public class UserServiceImpl { 클래스입니다.

🧩 **코드 일부 발췌:**

```java
package Domain.Service;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import Domain.Dao.UserDao;
import Domain.Dao.UserDaoImpl;
```

📌 **등장 메서드 목록:**

- `userJoin()`

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📦 **put()**: Java Map 인터페이스에서 key-value 쌍을 저장하는 메서드입니다.
- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🔧 **init()**: 서블릿 초기화 메서드로, 서블릿이 최초 로딩될 때 호출됩니다.

---

## 📄 PermissionFilter.java

**📂 위치:** `main/java/Filter/PermissionFilter.java`

✍️ **파일 설명:** public class PermissionFilter implements Filter{ 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `doFilter()`
- `init()`

🔍 **코드 속 개념 설명:**

- 🚧 서블릿 필터 클래스

🧠 **등장하는 주요 키워드 설명:**

- 🌐 **getRequestURI()**: 클라이언트가 요청한 URI 경로를 반환합니다. 예: `/books/list`
- 📦 **put()**: Java Map 인터페이스에서 key-value 쌍을 저장하는 메서드입니다.
- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.
- 🚧 **doFilter()**: Filter 클래스에서 요청과 응답을 가로채는 메서드입니다. 필터 체인의 일부로 실행됩니다.
- 🧾 **HttpServletRequest**: 클라이언트 요청 정보를 담고 있는 객체입니다.
- 📨 **HttpServletResponse**: 클라이언트에 대한 응답 정보를 담고 있는 객체입니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🚦 **Filter**: 요청 전/후에 필요한 전처리/후처리 작업을 수행하는 컴포넌트입니다.
- 🔧 **init()**: 서블릿 초기화 메서드로, 서블릿이 최초 로딩될 때 호출됩니다.

---

## 📄 UTF8_EncodingFilter.java

**📂 위치:** `main/java/Filter/UTF8_EncodingFilter.java`

✍️ **파일 설명:** public class UTF8_EncodingFilter implements Filter{ 클래스입니다.

🧩 **코드 일부 발췌:**

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

📌 **등장 메서드 목록:**

- `doFilter()`

🔍 **코드 속 개념 설명:**

- 🚧 서블릿 필터 클래스

🧠 **등장하는 주요 키워드 설명:**

- 🚧 **doFilter()**: Filter 클래스에서 요청과 응답을 가로채는 메서드입니다. 필터 체인의 일부로 실행됩니다.
- 🧩 **Servlet**: Java EE에서 서버에서 실행되는 자바 클래스입니다.
- 🚦 **Filter**: 요청 전/후에 필요한 전처리/후처리 작업을 수행하는 컴포넌트입니다.

---

## 📄 DaoTests.java

**📂 위치:** `main/java/Tests/DaoTests.java`

✍️ **파일 설명:** Java 클래스 파일입니다.

🧩 **코드 일부 발췌:**

```java
package Tests;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import Domain.Dao.BookDao;
import Domain.Dao.BookDaoImpl;
import Domain.Dao.UserDao;
import Domain.Dao.UserDaoImpl;
import Domain.Dto.BookDto;
```

📌 **등장 메서드 목록:** 없음

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 ServiceTests.java

**📂 위치:** `main/java/Tests/ServiceTests.java`

✍️ **파일 설명:** Java 클래스 파일입니다.

🧩 **코드 일부 발췌:**

```java
package Tests;

import org.junit.jupiter.api.Test;

import Domain.Dto.BookDto;
import Domain.Service.BookServiceImpl;

class ServiceTests {

	@Test
```

📌 **등장 메서드 목록:** 없음

🔍 **코드 속 개념 설명:**

- 📦 DTO (데이터 전송 객체)
- ⚙ 서비스 구현 클래스

🧠 **등장하는 주요 키워드 설명:**

- 📤 **get()**: Java Map에서 특정 key에 해당하는 값을 가져옵니다.

---

## 📄 Role.java

**📂 위치:** `main/java/Type/Role.java`

✍️ **파일 설명:** Java 클래스 파일입니다.

🧩 **코드 일부 발췌:**

```java
package Type;

public enum Role {
	ROLE_ANONYMOUS,		//0
	ROLE_USER,			//1
	ROLE_MANAGER,		//2
	ROLE_ADMIN			//3
}
```

📌 **등장 메서드 목록:** 없음

🔍 **코드 속 개념 설명:**

- 📑 열거형(enum) 타입

🧠 **등장하는 주요 키워드 설명:** 없음
