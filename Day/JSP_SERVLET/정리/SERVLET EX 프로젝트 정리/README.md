# 📚 EX 프로젝트 정리

---

## 📌 개요 (Overview)

이 프로젝트는 **회원가입, 로그인 기능**을 연습하는 웹 어플리케이션 예제야!  
DB와 연결해서 진짜로 아이디와 비밀번호를 저장하고 확인할 수 있어. 🛠️

**주요 흐름:**
- `index.jsp`: 메인 페이지
- `join.jsp`: 회원가입 페이지
- `login.jsp`: 로그인 페이지
- `main.jsp`: 로그인 성공 후 메인 페이지

---

## 💡 서블릿 파일 주석 추가 버전 (Servlets)

### 📄 Home.java

```java
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 👉 "/index.do" 또는 "/main.do" 요청을 처리하는 서블릿
@WebServlet(urlPatterns = {"/index.do", "/main.do"})
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 요청된 주소(URL)을 가져와서
        String uri = req.getRequestURI();

        // "/index.do"라면 index.jsp로 이동
        if (uri.contains("/index.do")) {
            System.out.println("GET /index.do");
            req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
            return;
        } else {
            // 그 외는 main.jsp로 이동
            System.out.println("GET /main.do");
            req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
            return;
        }
    }
}
```

---

### 📄 Join.java

```java
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utils.MysqlDbUtils;
import Utils.UserDto;

// 👉 "/join.do" 요청을 처리하는 회원가입 서블릿
@WebServlet("/join.do")
public class Join extends HttpServlet {

    private MysqlDbUtils dbutils;

    @Override
    public void init() throws ServletException {
        try {
            // DB 연결 도구 초기화
            dbutils = MysqlDbUtils.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET 요청: 회원가입 폼 보여주기
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /join.do");
        req.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(req, resp);
    }

    // POST 요청: 회원가입 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST /join.do");
        
        // 사용자가 입력한 데이터 가져오기
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        int result = 0;
        try {
            // DB에 저장하기
            result = dbutils.insert(new UserDto(username, password, "ROLE_USER"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 성공하면 로그인 페이지로 이동
        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
        } else {
            // 실패하면 다시 회원가입 페이지로
            req.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(req, resp);
        }
    }
}
```

---

### 📄 Login.java

```java
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Utils.MysqlDbUtils;
import Utils.UserDto;

// 👉 "/login.do" 요청을 처리하는 로그인 서블릿
@WebServlet("/login.do")
public class Login extends HttpServlet {

    private MysqlDbUtils dbutils;

    @Override
    public void init() throws ServletException {
        try {
            dbutils = MysqlDbUtils.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET 요청: 로그인 폼 보여주기
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /login.do");
        req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
    }

    // POST 요청: 로그인 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST /login.do");

        // 입력값 가져오기
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        boolean isAuth = false;
        try {
            // DB에서 사용자 정보 가져오기
            UserDto dbUser = dbutils.selectOne(username);

            // 비밀번호 일치하는지 확인
            if (dbUser != null && dbUser.getPassword().equals(password)) {
                // 로그인 성공 -> 세션에 저장
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", dbUser.getRole());
                isAuth = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 로그인 성공 시 메인 페이지로 이동
        if (isAuth) {
            resp.sendRedirect(req.getContextPath() + "/main.do");
        } else {
            // 실패 시 다시 로그인 페이지로
            req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
        }
    }
}
```

---

## 💡 DB 유틸리티 파일 주석 추가 버전 (Utils)

### 📄 MysqlDbUtils.java

```java
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// 👉 MySQL 데이터베이스와 연결하는 유틸리티 클래스
public class MysqlDbUtils {

    private String url = "jdbc:mysql://localhost/testDB"; // DB 주소
    private String id = "root"; // DB 사용자명
    private String pw = "1234"; // DB 비밀번호

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // ⭐ 싱글톤 패턴 적용
    private static MysqlDbUtils instance;
    private MysqlDbUtils() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, id, pw);
    }
    public static MysqlDbUtils getInstance() throws Exception {
        if (instance == null)
            instance = new MysqlDbUtils();
        return instance;
    }

    // 회원정보 저장 (INSERT)
    public int insert(UserDto userDto) throws Exception {
        pstmt = conn.prepareStatement("INSERT INTO tbl_user VALUES (?, ?, ?)");
        pstmt.setString(1, userDto.getUsername());
        pstmt.setString(2, userDto.getPassword());
        pstmt.setString(3, userDto.getRole());

        int result = pstmt.executeUpdate();
        pstmt.close();
        return result;
    }

    // 사용자 한 명 조회 (SELECT)
    public UserDto selectOne(String username) throws Exception {
        pstmt = conn.prepareStatement("SELECT * FROM tbl_user WHERE username=?");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        UserDto userDto = null;
        if (rs != null && rs.next()) {
            userDto = new UserDto(rs.getString(1), rs.getString(2), rs.getString(3));
        }
        return userDto;
    }
}
```

---

## 💡 DTO 파일 주석 추가 버전

### 📄 UserDto.java

```java
package Utils;

// 👉 사용자 정보를 담는 데이터 객체 (DTO)
public class UserDto {
    private String username;
    private String password;
    private String role;

    public UserDto() {}

    public UserDto(String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // getter & setter
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    @Override
    public String toString() {
        return "UserDto [username=" + username + ", password=" + password + ", role=" + role + "]";
    }
}
```

---

## 💡 JSP 파일 주석 추가 버전

### 🖥️ index.jsp

```jsp
<h1>INDEX PAGE</h1>
<!-- 회원가입/로그인 링크 -->
<a href="${pageContext.request.contextPath}/join.do">회원가입</a>
<a href="${pageContext.request.contextPath}/login.do">로그인</a>
```

---

### 🖥️ join.jsp

```jsp
<h1>JOIN PAGE</h1>
<form action="${pageContext.request.contextPath}/join.do" method="post">
    <input name="username" /><br/>
    <input name="password" /><br/>
    <button>회원가입</button>
</form>
```

---

### 🖥️ login.jsp

```jsp
<h1>LOGIN PAGE</h1>
<form action="${pageContext.request.contextPath}/login.do" method="post">
    <input name="username" /><br/>
    <input name="password" /><br/>
    <button>로그인</button>
</form>
```

---

### 🖥️ main.jsp

```jsp
<h1>MAIN PAGE</h1>
<!-- 로그인 성공 후 도착하는 메인 페이지 -->
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> 데이터베이스와 연결해서 진짜 회원가입/로그인을 연습하는 서블릿+JSP 프로젝트! 🎯

---
