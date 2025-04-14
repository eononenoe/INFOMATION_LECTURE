
# 🗂 RESOURCE 프로젝트 정리

---

## 📄 Filter/UTF8_EncodingFilter.java - UTF-8 인코딩 필터

### ✍️ 파일 설명
- 클라이언트의 요청(Request)과 서버의 응답(Response)의 문자 인코딩을 UTF-8로 설정하는 필터입니다.
- 한글 깨짐 방지를 위해 사용됩니다.

### 🧩 코드 일부 발췌
```java
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
chain.doFilter(request, response);
```

### 📌 코드 등장 메서드
- `request.setCharacterEncoding("UTF-8")` : 요청 데이터를 UTF-8로 인코딩
- `response.setCharacterEncoding("UTF-8")` : 응답 데이터를 UTF-8로 인코딩
- `chain.doFilter(request, response)` : 필터 체인 통해 다음 필터나 서블릿으로 요청 전달

### 🧠 흐름 정리
- 모든 요청과 응답에 UTF-8 인코딩을 적용한 뒤 다음 필터나 서블릿으로 넘깁니다.

---

## 📄 Servlets/Home.java - 홈 서블릿

### ✍️ 파일 설명
- 사용자가 `/home.do`로 접근하면 `main.jsp`로 포워딩하는 서블릿입니다.

### 🧩 코드 일부 발췌
```java
RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/main.jsp");
dispatcher.forward(req, resp);
```

### 📌 코드 등장 메서드
- `req.getRequestDispatcher("/WEB-INF/main.jsp")` : 지정한 JSP로 요청을 전달 준비
- `dispatcher.forward(req, resp)` : 서버 내부에서 JSP로 요청을 전달

### 🧠 흐름 정리
- `/home.do` 요청을 받아 `main.jsp`로 내부 포워딩합니다.

---

## 📄 Servlets/Join.java - 회원가입 처리 서블릿

### ✍️ 파일 설명
- 회원가입 폼으로부터 입력받은 사용자 정보를 데이터베이스에 저장하고 로그인 페이지로 리다이렉트하는 서블릿입니다.

### 🧩 코드 일부 발췌
```java
String username = req.getParameter("username");
String password = req.getParameter("password");
UserDto dto = new UserDto(username, password);
MysqlDbUtils.insert(dto);
resp.sendRedirect(req.getContextPath() + "/user/login.jsp");
```

### 📌 코드 등장 메서드
- `req.getParameter("username")` : 폼에서 입력한 username을 가져옴
- `req.getParameter("password")` : 폼에서 입력한 password를 가져옴
- `new UserDto(username, password)` : 입력한 값을 DTO 객체로 생성
- `MysqlDbUtils.insert(dto)` : 데이터베이스에 사용자 정보 저장
- `resp.sendRedirect(...)` : 회원가입 완료 후 로그인 페이지로 리다이렉트

### 🧠 흐름 정리
- 폼 입력 → DTO 생성 → DB 저장 → 로그인 페이지로 리다이렉트합니다.

---

## 📄 Servlets/Login.java - 로그인 처리 서블릿

### ✍️ 파일 설명
- 로그인 폼 데이터를 받아 세션 정보와 비교하여 로그인 성공 여부를 판별합니다.

### 🧩 코드 일부 발췌
```java
String username = req.getParameter("username");
String password = req.getParameter("password");
HttpSession session = req.getSession();
String dbUsername = (String) session.getAttribute("username");
String dbPassword = (String) session.getAttribute("password");

if (!username.equals(dbUsername) || !password.equals(dbPassword)) {
    req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
} else {
    resp.sendRedirect(req.getContextPath() + "/main.do");
}
```

### 📌 코드 등장 메서드
- `req.getParameter("username")`, `req.getParameter("password")` : 로그인 폼 입력값 가져오기
- `session.getAttribute("username")`, `session.getAttribute("password")` : 세션에 저장된 사용자 정보 가져오기
- `req.getRequestDispatcher(...).forward()` : 로그인 실패 시 다시 로그인 화면으로 이동
- `resp.sendRedirect(...)` : 로그인 성공 시 메인 화면으로 리다이렉트

### 🧠 흐름 정리
- 입력값과 세션값 비교 → 실패 시 로그인 페이지로 이동 → 성공 시 메인 페이지로 이동합니다.

---

## 📄 Utils/MysqlDbUtils.java - MySQL 연결 유틸리티

### ✍️ 파일 설명
- MySQL 데이터베이스에 연결하고 사용자 정보를 저장하는 기능을 담당합니다.

### 🧩 코드 일부 발췌
```java
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection(url, user, password);
PreparedStatement pstmt = conn.prepareStatement("INSERT INTO users VALUES (?, ?)");
pstmt.setString(1, dto.getUsername());
pstmt.setString(2, dto.getPassword());
pstmt.executeUpdate();
```

### 📌 코드 등장 메서드
- `DriverManager.getConnection(url, user, password)` : DB 연결 생성
- `conn.prepareStatement(...)` : SQL 준비
- `pstmt.executeUpdate()` : SQL 실행 (INSERT)

### 🧠 흐름 정리
- DB 연결 → 사용자 INSERT → 실행 완료 후 연결 해제

---

## 📄 Utils/OracleDBUtils.java - Oracle 연결 유틸리티

### ✍️ 파일 설명
- Oracle 데이터베이스 연결을 위한 유틸리티 클래스입니다. (MySQL 버전과 구조 유사)

---

## 📄 Utils/UserDto.java - 사용자 데이터 전송 객체 (DTO)

### ✍️ 파일 설명
- 사용자 ID, 비밀번호를 담는 단순 데이터 객체입니다.

---

## 📄 JSP 파일들

### ✍️ 간단 설명
- **index.jsp** : 프로젝트 기본 진입 페이지
- **join.jsp** : 회원가입 폼
- **login.jsp** : 로그인 폼
- **main.jsp** : 로그인 성공 시 이동하는 메인 화면

---

# 📌 개요 (Overview)

**08RESOURCE**는 Java Servlet과 JSP, JDBC를 이용하여  
회원가입과 로그인 시스템을 직접 구현한 웹 애플리케이션입니다.  
웹 서버와 DB 연동 기본 구조를 이해하는 데 초점을 맞췄습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

- **Servlet** : 서버 요청을 처리하는 자바 프로그램
- **JSP** : 동적 웹페이지를 생성하는 서버 파일
- **Filter** : 요청/응답을 가로채어 조작하는 중간 처리기
- **Session** : 클라이언트 상태 정보를 서버에 저장하는 기술
- **JDBC** : 데이터베이스와 자바 프로그램을 연결하는 표준 API

---

# ⚠ 주의사항 (Cautions)

- **비밀번호 평문 저장** : 실제 서비스에서는 반드시 해시 처리해야 함
- **세션 저장 미흡** : 로그인 시 사용자 객체를 세션에 명시적으로 저장해야 함
- **DB 연결 예외처리 부족** : try-catch-finally로 명확하게 처리해야 안정적임

---

# 🧪 비유 또는 예제 (Examples or Analogies)

- **Servlet**은 식당 주방장과 같음. (주문 받고 요리 제공)
- **Filter**는 식당 입구에서 손 소독시키는 직원과 같음. (사전 처리)
- **Session**은 놀이공원 입장 팔찌처럼 인증정보를 유지시킴.

---

# ✅ 한 줄 요약 (1-Line Summary)

> \"08RESOURCE는 Servlet, JSP, JDBC를 이용하여 웹서버와 DB를 직접 연동해 회원가입/로그인 시스템을 구현하는 기초 웹 프로젝트입니다.\"
```
