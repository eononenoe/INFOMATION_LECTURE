```markdown
# 🗂 MVC_USER 프로젝트 정리

---

## 📄 Controller/FrontController.java - 프론트 컨트롤러

### ✍️ 파일 설명
- 모든 요청을 가장 먼저 받아서 적절한 서브 컨트롤러에게 전달하는 역할을 하는 서블릿입니다.
- MVC 패턴에서 중요한 중앙 집중식 요청 처리를 담당합니다.

### 🧩 코드 일부 발췌
```java
String cmd = req.getParameter("cmd");
SubController subController = mappings.get(cmd);

if (subController != null) {
    subController.execute(req, resp);
} else {
    req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
}
```

### 📌 코드 등장 메서드
- `req.getParameter("cmd")` : 클라이언트로부터 명령어(command) 파라미터를 받습니다.
- `subController.execute(req, resp)` : 명령어에 해당하는 서브 컨트롤러를 실행합니다.
- `req.getRequestDispatcher(...).forward()` : 에러 발생 시 에러 페이지로 포워딩합니다.

### 🧠 흐름 정리
- 요청에서 `cmd` 값을 가져와 해당하는 서브 컨트롤러를 실행합니다.  
- 서브 컨트롤러가 없으면 에러 페이지로 포워딩합니다.

---

## 📄 Controller/HomeController.java - 홈 컨트롤러

### ✍️ 파일 설명
- 기본 홈 화면(index.jsp)으로 이동시키는 역할을 합니다.

### 🧩 코드 일부 발췌
```java
req.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(req, resp);
```

### 📌 코드 등장 메서드
- `req.getRequestDispatcher("/WEB-INF/view/index.jsp")` : 홈 화면 JSP로 요청을 전달합니다.
- `dispatcher.forward(req, resp)` : 홈 페이지로 내부 포워딩합니다.

### 🧠 흐름 정리
- 사용자가 기본 요청을 보내면 `index.jsp`로 포워딩합니다.

---

## 📄 Controller/SubController.java - 서브 컨트롤러 인터페이스

### ✍️ 파일 설명
- 모든 서브 컨트롤러가 구현해야 하는 인터페이스입니다.

### 🧩 코드 일부 발췌
```java
public interface SubController {
    void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
}
```

### 📌 코드 등장 메서드
- `execute(req, resp)` : 서브 컨트롤러에서 실제로 요청을 처리하는 메서드입니다.

### 🧠 흐름 정리
- 각 서브 컨트롤러는 이 인터페이스를 구현하여 요청을 처리합니다.

---

## 📄 Controller/user/UserCreateController.java - 사용자 생성 컨트롤러

### ✍️ 파일 설명
- 사용자를 생성하는 비즈니스 로직을 담당하는 컨트롤러입니다.

### 🧩 코드 일부 발췌
```java
UserDto user = new UserDto(req.getParameter("username"), req.getParameter("password"));
UserDao dao = new UserDaoImpl();
dao.insertUser(user);
req.getRequestDispatcher("/WEB-INF/view/user/create.jsp").forward(req, resp);
```

### 📌 코드 등장 메서드
- `new UserDto(...)` : 사용자 정보 DTO 객체를 생성합니다.
- `dao.insertUser(user)` : 사용자 정보를 데이터베이스에 삽입합니다.
- `req.getRequestDispatcher(...).forward()` : 사용자 생성 후 해당 페이지로 포워딩합니다.

### 🧠 흐름 정리
- 사용자가 입력한 데이터를 받아 DTO 생성 → 데이터베이스에 저장 → 결과 페이지로 이동합니다.

---

## 📄 Domain/Dao/BookDao.java - 도서 DAO 인터페이스

### ✍️ 파일 설명
- 도서 관련 데이터베이스 작업을 처리하는 DAO 인터페이스입니다.

### 🧩 코드 일부 발췌
```java
public interface BookDao {
    void insertBook(BookDto book);
    List<BookDto> getAllBooks();
}
```

### 📌 코드 등장 메서드
- `insertBook(BookDto book)` : 책 정보를 데이터베이스에 삽입하는 메서드.
- `getAllBooks()` : 모든 책 정보를 반환하는 메서드.

### 🧠 흐름 정리
- 도서 정보를 DB에 삽입하고 조회하는 기능을 제공하는 인터페이스입니다.

---

## 📄 Domain/Dao/BookDaoImpl.java - 도서 DAO 구현

### ✍️ 파일 설명
- `BookDao` 인터페이스를 구현한 클래스입니다.

### 🧩 코드 일부 발췌
```java
public void insertBook(BookDto book) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = dataSource.getConnection();
        pstmt = conn.prepareStatement("INSERT INTO books (title, author) VALUES (?, ?)");
        pstmt.setString(1, book.getTitle());
        pstmt.setString(2, book.getAuthor());
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        close(conn, pstmt);
    }
}
```

### 📌 코드 등장 메서드
- `dataSource.getConnection()` : 커넥션 풀에서 DB 연결을 가져옵니다.
- `pstmt.executeUpdate()` : SQL 명령을 실행하여 데이터를 삽입합니다.

### 🧠 흐름 정리
- 데이터베이스에서 도서 정보를 삽입하는 작업을 구현한 클래스입니다.

---

## 📄 Domain/Dao/UserDao.java - 사용자 DAO 인터페이스

### ✍️ 파일 설명
- 사용자 관련 데이터베이스 작업을 처리하는 DAO 인터페이스입니다.

### 🧩 코드 일부 발췌
```java
public interface UserDao {
    void insertUser(UserDto user);
    UserDto getUserByUsername(String username);
}
```

### 📌 코드 등장 메서드
- `insertUser(UserDto user)` : 사용자 정보를 데이터베이스에 삽입합니다.
- `getUserByUsername(String username)` : 특정 사용자 정보를 조회합니다.

### 🧠 흐름 정리
- 사용자 관련 데이터베이스 작업을 위한 메서드 정의 인터페이스입니다.

---

## 📄 Domain/Dao/UserDaoImpl.java - 사용자 DAO 구현

### ✍️ 파일 설명
- `UserDao` 인터페이스를 구현하여 사용자 정보를 처리하는 클래스입니다.

### 🧩 코드 일부 발췌
```java
public void insertUser(UserDto user) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = dataSource.getConnection();
        pstmt = conn.prepareStatement("INSERT INTO users (username, password) VALUES (?, ?)");
        pstmt.setString(1, user.getUsername());
        pstmt.setString(2, user.getPassword());
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        close(conn, pstmt);
    }
}
```

### 📌 코드 등장 메서드
- `dataSource.getConnection()` : DB 연결 객체를 가져옵니다.
- `pstmt.executeUpdate()` : SQL INSERT 명령을 실행합니다.

### 🧠 흐름 정리
- 사용자 정보를 데이터베이스에 삽입하는 작업을 처리합니다.

---

## 📄 Filter/UTF8_EncodingFilter.java - UTF-8 인코딩 필터

### ✍️ 파일 설명
- 요청과 응답의 문자 인코딩을 UTF-8로 설정하는 필터입니다.

### 🧩 코드 일부 발췌
```java
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
chain.doFilter(request, response);
```

### 📌 코드 등장 메서드
- `request.setCharacterEncoding("UTF-8")` : 요청 인코딩을 UTF-8로 설정합니다.
- `response.setCharacterEncoding("UTF-8")` : 응답 인코딩을 UTF-8로 설정합니다.
- `chain.doFilter(request, response)` : 다음 필터나 서블릿으로 요청을 전달합니다.

### 🧠 흐름 정리
- UTF-8 인코딩을 적용하고 다음 필터나 서블릿으로 요청을 넘깁니다.

---

## 📄 JSP 파일들 (View)

### ✍️ 간단 설명
- **index.jsp** : 기본 진입 페이지
- **user/create.jsp** : 사용자 생성 폼
- **user/error.jsp** : 에러 페이지
- **template.jsp** : 공통 레이아웃 템플릿

---

## 📄 Resources 파일들 (정적 리소스)

### ✍️ 간단 설명
- **common.css** : 공통 스타일시트
- **common.js** : 공통 자바스크립트
- **layouts/nav.jsp, footer.jsp** : 페이지 공통 레이아웃 구성 요소

---

# 📌 개요 (Overview)

**10MVC_USER**는 **MVC 패턴**을 기반으로 한 **사용자 관리 웹 애플리케이션**입니다.  
사용자 관리, 도서 관리 기능을 제공하며, `FrontController`로 요청을 처리하고, `DAO`와 `Service`를 통해 비즈니스 로직을 분리하고 있습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

- **FrontController** : 모든 요청을 중앙에서 처리하고 서브 컨트롤러로 분배
- **DAO** : 데이터베이스 작업을 처리하는 객체
- **Service** : 비즈니스 로직을 처리하는 서비스 클래스
- **Filter** : 요청/응답을 UTF-8로 설정하여 한글 깨짐 방지

---

# ⚠ 주의사항 (Cautions)

- **비밀번호 평문 저장** : 실제 서비스에서는 반드시 비밀번호를 암호화해야 합니다.
- **세션 관리 부족** : 로그인 상태를 제대로 관리할 필요가 있습니다.
- **DB 예외 처리** : DB 작업 시 예외 처리 부분을 더 강화할 필요가 있습니다.

---

# 🧪 비유 또는 예제 (Examples or Analogies)

- **FrontController** = 관리자가 모든 손님을 맞이하여 알맞은 창구로 보냄
- **DAO** = 도서나 사용자 정보 관리 대장 (DB 작업 담당)
- **Service** = 비즈니스 로직을 담당하는 부서

---

# ✅ 한 줄 요약 (1-Line Summary)

> \"10MVC_USER는 MVC 패턴을 활용한 사용자 및 도서 관리 웹 애플리케이션으로, 프론트 컨트롤러 방식으로 요청을 처리하고, DAO와 Service로 구조화된 시스템입니다!\"
```
