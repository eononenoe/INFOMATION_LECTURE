# 01

## Servlet

---

> C01Servlet_Test.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
@WebServlet("/TEST_01")
public class C01Servlet_Test extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("INIT() invoke...");
    }

    @Override
    public void service(ServletRequest arg0, ServletResponse arg1) throws ServletException, IOException {
        System.out.println("SERVICE() invoke...");
    }

    @Override
    public void destroy() {
        System.out.println("DESTROY() invoke...");
    }
}

```

---

> C02Servlet_Test.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

public class C02Servlet_Test extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("INIT() invoke...");
    }

    @Override
    public void service(ServletRequest arg0, ServletResponse arg1) throws ServletException, IOException {
        System.out.println("SERVICE() invoke...");
    }

    @Override
    public void destroy() {
        System.out.println("DESTROY() invoke...");
    }
}

```

---

> C03Servlet_Test.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/main.do")
public class C03Servlet_Test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /main.do...");
        req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
    }
}

```

---

> C04Servlet_Test.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/join.do")
public class C04Servlet_Test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /join.do...");
        req.getRequestDispatcher("/WEB-INF/join.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST /join.do...");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();
        session.setAttribute("username", username);
        session.setAttribute("password", password);

        resp.sendRedirect(req.getContextPath() + "/login.do");
    }
}

```

---

> C05Servlet_test.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login.do")
public class C05Servlet_test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /login.do...");
        req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST /login.do...");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();
        String dbUsername = (String) session.getAttribute("username");
        String dbPassword = (String) session.getAttribute("password");

        if (!username.equals(dbUsername)) {
            req.setAttribute("username_msg", "ID가 일치하지 않습니다.");
        }
        if (!password.equals(dbPassword)) {
            req.setAttribute("password_msg", "PW가 일치하지 않습니다.");
        }
        if (!username.equals(dbUsername) || !password.equals(dbPassword)) {
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/main.do");
    }
}

```

---

## webapp

---

> index.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>INDEX PAGE</h1>
</body>
</html>

```

---

## WEB-INF

---

> join.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <h1>JOIN PAGE</h1>
    <form action="${pageContext.request.contextPath}/join.do" method="post">
        <input name="username" /><br/>
        <input name="password" /><br/>
        <button>회원가입</button>
    </form>

</body>
</html>

```

---

> login.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <h1>LOGIN PAGE</h1>
    <form action="${pageContext.request.contextPath}/login.do" method="post">
        <input name="username" /><br/>
        <input name="password" /><br/>
        <button>로그인</button>
    </form>
    <div>${username_msg}</div>
    <div>${password_msg}</div>

</body>
</html>

```

---

> main.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <h1>MAIN PAGE</h1>

</body>
</html>

```

---

## Servlets

---

> Home.java
> 

```java
java
복사편집
package Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/index.do","/main.do"})
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("/index.do")) {
            System.out.println("GET /index.do");
            req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
            return;
        } else {
            System.out.println("GET /main.do");
            req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
            return;
        }
    }
}

```

---

> Join.java
> 

```java
java
복사편집
package Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utils.MysqlDbUtils;
import Utils.UserDto;

@WebServlet("/join.do")
public class Join extends HttpServlet {

    private MysqlDbUtils dbutils;

    @Override
    public void init() throws ServletException {
        try {
            dbutils = MysqlDbUtils.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /join.do");
        req.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST /join.do");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        int result = 0;
        try {
            result = dbutils.insert(new UserDto(username, password, "ROLE_USER"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(result > 0) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
        } else {
            req.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(req, resp);
        }
    }
}

```

---

> Login.java
> 

```java
java
복사편집
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /login.do");
        req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("POST /login.do");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        boolean isAuth = false;
        try {
            UserDto dbUser = dbutils.selectOne(username);
            if(dbUser != null && dbUser.getPassword().equals(password)) {
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", dbUser.getRole());
                isAuth = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(isAuth) {
            resp.sendRedirect(req.getContextPath() + "/main.do");
        } else {
            req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
        }
    }
}

```

---

## Utils

---

> MysqlDbUtils.java
> 

```java
java
복사편집
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MysqlDbUtils {

    private String url = "jdbc:mysql://localhost/testDB";
    private String id = "root";
    private String pw = "1234";

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static MysqlDbUtils instance;
    private MysqlDbUtils() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, id, pw);
    }
    public static MysqlDbUtils getInstance() throws Exception {
        if(instance == null)
            instance = new MysqlDbUtils();
        return instance;
    }

    public int insert(UserDto userDto) throws Exception {
        pstmt = conn.prepareStatement("insert into tbl_user values(?,?,?)");
        pstmt.setString(1, userDto.getUsername());
        pstmt.setString(2, userDto.getPassword());
        pstmt.setString(3, userDto.getRole());

        int result = pstmt.executeUpdate();
        pstmt.close();
        return result;
    }

    public UserDto selectOne(String username) throws Exception {
        pstmt = conn.prepareStatement("select * from tbl_user where username=?");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        UserDto userDto = null;
        if(rs != null && rs.next()) {
            userDto = new UserDto(rs.getString(1), rs.getString(2), rs.getString(3));
        }
        return userDto;
    }
}

```

---

> OracleDBUtils.java
> 

```java
java
복사편집
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OracleDBUtils {

    private String url = "jdbc:oracle:thin:@localhost:1521:xe";
    private String id = "system";
    private String pw = "1234";

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static OracleDBUtils instance;
    private OracleDBUtils() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, id, pw);
    }
    public static OracleDBUtils getInstance() throws Exception {
        if(instance == null)
            instance = new OracleDBUtils();
        return instance;
    }
}

```

---

> UserDto.java
> 

```java
java
복사편집
package Utils;

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

## WEB-INF

---

> index.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>INDEX PAGE</h1>

<a href="${pageContext.request.contextPath}/join.do">회원가입</a>
<a href="${pageContext.request.contextPath}/login.do">로그인</a>

</body>
</html>

```

---

> main.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>
</head>
<body>

<h1>MAIN PAGE</h1>

</body>
</html>

```

---

## user

---

> join.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Page</title>
</head>
<body>

<h1>JOIN PAGE</h1>
<form action="${pageContext.request.contextPath}/join.do" method="post">
    <input name="username" /><br/>
    <input name="password" /><br/>
    <button>회원가입</button>
</form>

</body>
</html>

```

---

> login.jsp
> 

```
jsp
복사편집
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
</head>
<body>

<h1>LOGIN PAGE</h1>
<form action="${pageContext.request.contextPath}/login.do" method="post">
    <input name="username" /><br/>
    <input name="password" /><br/>
    <button>로그인</button>
</form>

</body>
</html>

```

---

## Filter

---

> C01Filter_Test.java
> 

```java
java
복사편집
package Filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

//@WebFilter("/index.do")
public class C01Filter_Test implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        System.out.println("[FILTER] INDEX FILTER START...");
        chain.doFilter(req, resp);
        System.out.println("[FILTER] INDEX FILTER END...");
    }
}

```

---

> C02Filter_Test.java
> 

```java
java
복사편집
package Filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

//@WebFilter("/main.do")
public class C02Filter_Test implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        System.out.println("[FILTER] MAIN FILTER START...");
        chain.doFilter(req, resp);
        System.out.println("[FILTER] MAIN FILTER END...");
    }
}

```

---

> UTF8_EncodingFilter.java
> 

```java
java
복사편집
package Filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class UTF8_EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
        response.setContentType("text/html; charset=UTF-8");
    }
}

```

---

## Servlet

---

> Home.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet(urlPatterns = {"/index.do", "/main.do"})
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/index.do")) {
            System.out.println("GET /index.do");
            req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
        } else {
            System.out.println("GET /main.do");
            req.getRequestDispatcher("/WEB-INF/main.jsp").forward(req, resp);
        }
    }
}

```

---

> Join.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utils.MysqlDbUtils;
import Utils.UserDto;

//@WebServlet("/join.do")
public class Join extends HttpServlet {

    private MysqlDbUtils dbutils;

    @Override
    public void init() throws ServletException {
        try {
            dbutils = MysqlDbUtils.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /join.do");
        req.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.println("POST /join.do username: " + username);

        int result = 0;
        try {
            // result = dbutils.insert(new UserDto(username, password, "ROLE_USER"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
        } else {
            req.getRequestDispatcher("/WEB-INF/user/join.jsp").forward(req, resp);
        }
    }
}

```

---

> Login.java
> 

```java
java
복사편집
package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Utils.MysqlDbUtils;
import Utils.UserDto;

//@WebServlet("/login.do")
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET /login.do");
        req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        boolean isAuth = false;
        try {
            UserDto dbUser = dbutils.selectOne(username);
            if (dbUser != null && dbUser.getPassword().equals(password)) {
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", dbUser.getRole());
                isAuth = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isAuth) {
            resp.sendRedirect(req.getContextPath() + "/main.do");
        } else {
            req.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(req, resp);
        }
    }
}

```