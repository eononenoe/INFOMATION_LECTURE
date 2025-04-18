
# 🗂 MVC_INIT 프로젝트 정리

---

## 📄 Controller/FrontController.java - 프론트 컨트롤러

### ✍️ 파일 설명
- 모든 요청을 가장 먼저 받아서 적절한 서브 컨트롤러에게 전달하는 중앙 통제 서블릿입니다.
- **MVC 패턴**에서 핵심 역할을 합니다.

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
- 요청 cmd 파라미터를 기준으로 서브컨트롤러를 매칭해서 실행합니다.  
- 매칭 실패 시 error.jsp로 이동합니다.

---

## 📄 Controller/HomeController.java - 홈 컨트롤러

### ✍️ 파일 설명
- 기본 홈 화면(index.jsp)으로 이동시키는 역할을 합니다.

### 🧩 코드 일부 발췌
```java
req.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(req, resp);
```

### 📌 코드 등장 메서드
- `req.getRequestDispatcher(...).forward()` : 홈 화면 JSP로 요청을 전달합니다.

### 🧠 흐름 정리
- 기본 요청이 들어오면 index.jsp로 포워딩합니다.

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
- `execute(req, resp)` : 요청을 받아 처리하는 메서드, 서브컨트롤러마다 구체적으로 구현합니다.

### 🧠 흐름 정리
- 각 기능별 서브컨트롤러는 이 인터페이스를 구현하여 요청을 처리합니다.

---

## 📄 Domain/Dao/Dao.java - DAO 추상화

### ✍️ 파일 설명
- 데이터베이스 접근을 담당하는 최상위 DAO 추상 클래스입니다.

### 🧩 코드 일부 발췌
```java
protected Connection conn;
protected PreparedStatement pstmt;
protected ResultSet rs;
```

### 📌 코드 등장 메서드
- `Connection` : DB 연결 객체
- `PreparedStatement` : SQL 실행 준비 객체
- `ResultSet` : SQL 실행 결과 저장 객체

### 🧠 흐름 정리
- DAO들이 데이터베이스 작업을 공통적으로 사용할 수 있게 기본 필드를 제공합니다.

---

## 📄 Domain/Dao/ConnectionPool/ConnectionItem.java - 커넥션 풀 아이템

### ✍️ 파일 설명
- 커넥션 풀에 들어가는 각각의 Connection 객체를 포장하는 클래스입니다.

### 🧩 코드 일부 발췌
```java
private Connection conn;
private boolean isUsing;
```

### 📌 코드 등장 메서드
- `Connection conn` : 실제 DB 연결 객체
- `boolean isUsing` : 현재 연결 사용 여부

### 🧠 흐름 정리
- 연결 객체와 사용여부를 묶어서 관리합니다.

---

## 📄 Domain/Dao/ConnectionPool/ConnectionPool.java - 커넥션 풀

### ✍️ 파일 설명
- DB 연결을 미리 생성해놓고 필요할 때 빌려주는 커넥션 풀을 구현합니다.

### 🧩 코드 일부 발췌
```java
public synchronized Connection getConnection() {
    for (ConnectionItem item : pool) {
        if (!item.isUsing()) {
            item.setUsing(true);
            return item.getConn();
        }
    }
    return null;
}
```

### 📌 코드 등장 메서드
- `getConnection()` : 사용 가능한 Connection을 찾아 반환합니다.

### 🧠 흐름 정리
- 커넥션 풀에서 사용 가능한 Connection을 찾아서 반환합니다. 없으면 null 반환.

---

## 📄 Domain/Dao/ConnectionPool/MysqlXADataSourceFactory.java - 데이터소스 팩토리

### ✍️ 파일 설명
- MySQL 데이터베이스를 위한 DataSource를 생성합니다.

---

## 📄 Filter/UTF8_EncodingFilter.java - UTF-8 인코딩 필터

### ✍️ 파일 설명
- 모든 요청과 응답에 대해 UTF-8 인코딩을 설정하는 필터입니다.

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
- UTF-8 인코딩을 적용하고 다음 필터 또는 서블릿으로 요청을 넘깁니다.

---

## 📄 JSP 파일들 (View)

### ✍️ 간단 설명
- **index.jsp** : 홈 화면
- **template.jsp** : 공통 레이아웃 템플릿
- **user/create.jsp** : 사용자 생성 폼
- **error.jsp** : 에러 발생 시 보여줄 화면

---

## 📄 Resources 파일들 (정적 리소스)

### ✍️ 간단 설명
- **common.css** : 공통 스타일시트
- **common.js** : 공통 자바스크립트
- **layouts/nav.jsp, footer.jsp, topHeader.jsp** : 페이지 공통 레이아웃 구성 요소

---

# 📌 개요 (Overview)

**09MVC_INIT**는 Java Servlet을 기반으로 한 **초기형 MVC 패턴 웹 프로젝트**입니다.  
프론트 컨트롤러 패턴을 적용하여 요청을 일관되게 처리하고, 커넥션 풀을 통한 DB 효율성을 확보했습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

- **FrontController** : 모든 요청을 하나의 진입점으로 받아 분배
- **SubController** : 실제 비즈니스 로직을 수행하는 컨트롤러
- **DAO** : 데이터베이스 접근 전담 객체
- **ConnectionPool** : DB 커넥션 재사용을 통한 성능 최적화
- **Filter** : 요청/응답 문자 인코딩 처리

---

# ⚠ 주의사항 (Cautions)

- 커넥션 풀 예외처리 미흡 : 커넥션 반환 누락 시 자원 누수 발생 가능
- 로그인/회원가입 등 실제 서브컨트롤러 구현이 아직 없음 (확장 필요)
- Exception 처리 전반적으로 미흡

---

# 🧪 비유 또는 예제 (Examples or Analogies)

- **FrontController** = 안내 데스크 (모든 손님을 맞이해서 알맞은 창구로 보내줌)
- **ConnectionPool** = 사무실의 공유 복합기 (필요할 때 빌려쓰고 다시 돌려놓음)

---

# ✅ 한 줄 요약 (1-Line Summary)

> \"09MVC_INIT는 FrontController 기반의 MVC 웹 구조를 초기 설정하고, 커넥션 풀로 성능을 고려한 Java 웹 프로젝트의 출발점입니다!\"
```
