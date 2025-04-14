# 01

---

## settings

---

> org.eclipse.wst.common.project.facet.core.xml
> 

```java
<?xml version="1.0" encoding="UTF-8"?>
<faceted-project>
  <runtime name="Apache Tomcat v9.0"/>
  <fixed facet="jst.web"/>
  <fixed facet="wst.jsdt.web"/>
  <fixed facet="java"/>
  <installed facet="java" version="21"/>
  <installed facet="jst.web" version="4.0"/>
  <installed facet="wst.jsdt.web" version="1.0"/>
</faceted-project>
```

---

## Filter

---

> UTF8_EncodingFilter.java
> 

```java
package Filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

//@WebFilter("/*") //url : /* 모든 url , *.do : 확장자가 do인 모든 요청
public class UTF8_EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        System.out.println("[Filter] UTF8_EncodingFilter..Start");
        request.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
        response.setContentType("text/html; charset=UTF-8");
        System.out.println("[Filter] UTF8_EncodingFilter..End");
    }
}

```

---

## Servlets

---

> Home.java
> 

```java
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().append("Home Servlet");
    }
}

```

> Join.java
> 

```java
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/join")
public class Join extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 회원가입 로직
    }
}

```

> Login.java
> 

```java
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 로그인 로직
    }
}

```

---

## Utils

---

> MysqlDbUtils.java
> 

```java
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlDbUtils {

    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/dbname";
        String user = "root";
        String password = "password";
        return DriverManager.getConnection(url, user, password);
    }
}

```

> OracleDBUtils.java
> 

```java
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleDBUtils {

    public static Connection getConnection() throws SQLException {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String user = "user";
        String password = "password";
        return DriverManager.getConnection(url, user, password);
    }
}

```

> UserDto.java
> 

```java
package Utils;

public class UserDto {
    private String id;
    private String password;

    public UserDto() {}

    public UserDto(String id, String password) {
        this.id = id;
        this.password = password;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

```

---

## webapp

---

> index.jsp
> 

```java
<html>
<body>
<h1>Welcome to the Home Page</h1>
</body>
</html>

```

---

## META-INF

---

> MANIFEST.MF
> 

```java
Manifest-Version: 1.0

```

> context.xml
> 

```java
<?xml version="1.0" encoding="UTF-8"?>
<Context>
</Context>

```

---

## WEB-INF

---

> index.jsp
> 

```java
<html>
<body>
<h1>WEB-INF Index Page</h1>
</body>
</html>

```

> main.jsp
> 

```java
<html>
<body>
<h1>Main Page</h1>
</body>
</html>

```

> web.xml
> 

```java
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="<http://xmlns.jcp.org/xml/ns/javaee>"
         version="3.1">
    <display-name>08RESOURCE</display-name>
</web-app>

```

---

## user

---

> join.jsp
> 

```java
<html>
<body>
<h1>Join Page</h1>
</body>
</html>

```

> login.jsp
> 

```java
<html>
<body>
<h1>Login Page</h1>
</body>
</html>

```

---

## Controller

---

> FrontController
> 

```java
package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        System.out.println("프론트 컨트롤러 동작!");
    }
}
```

> HomeController.java
> 

```java
package Controller;

public class HomeController {
    // 추후 Home 처리
}

```

> SubController.java
> 

```java
package Controller;

public interface SubController {
}

```

---

## Dao

---

> Dao.java
> 

```java
package Domain.Dao;

public interface Dao {
}

```

---

## ConnectionPool

---

> ConnectionItem.java
> 

```java
package Domain.Dao.ConnectionPool;

public class ConnectionItem {
}

```

> ConnectionPool.java
> 

```java
package Domain.Dao.ConnectionPool;

public class ConnectionPool {
}

```

> MysqlXADataSourceFactory.java
> 

```java
package Domain.Dao.ConnectionPool;

public class MysqlXADataSourceFactory {
}

```

---

## Filter

---

> UTF8_EncodingFilter.java
> 

```java
package Filter;

import jakarta.servlet.*;
import java.io.IOException;

public class UTF8_EncodingFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }
}

```

---

## WEB-INF

---

> web.xml
> 

```html
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="<http://jakarta.ee/xml/ns/jakartaee>" version="5.0">
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>Filter.UTF8_EncodingFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>

```

---

## view

---

> error.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>에러 페이지입니다</h1>

```

> index.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>인덱스 페이지</h1>

```

> template.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/resources/layouts/topHeader.jsp" />
<jsp:include page="/resources/layouts/nav.jsp" />
<jsp:include page="/resources/layouts/link.jsp" />
<jsp:include page="/resources/layouts/footer.jsp" />

```

> create.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>회원가입 페이지</h1>

```

> error.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>사용자 에러 페이지</h1>

```

---

## css

---

> common.css
> 

```css
body {
    font-family: Arial, sans-serif;
}

```

---

## js

---

> common.js
> 

```jsx
console.log("공통 자바스크립트 파일입니다.");

```

---

## layouts

---

> footer.jsp
> 

```html
<footer>
    <p>Footer 영역</p>
</footer>

```

> link.jsp
> 

```html
<link rel="stylesheet" href="/resources/css/common.css">
<script src="/resources/js/common.js"></script>

```

> nav.jsp
> 

```html
<nav>
    <ul>
        <li><a href="/">Home</a></li>
    </ul>
</nav>

```

> topHeader.jsp
> 

```html
<header>
    <h1>Top Header</h1>
</header>

```

---

## Controller

---

> Controller
> 

```java
package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        System.out.println("프론트 컨트롤러 동작!");
    }
}

```

---

> HomeController.java
> 

```java
package Controller;

public class HomeController {
}

```

> SubController.java
> 

```java
package Controller;

public interface SubController {
}

```

> UserCreateController.java
> 

```java
package Controller.user;

public class UserCreateController {
}

```

---

## Dao

---

> BookDao.java
> 

```java
package Domain.Dao;

public interface BookDao {
}

```

> BookDaoImpl.java
> 

```java
package Domain.Dao;

public class BookDaoImpl {
}

```

> Dao.java
> 

```java
package Domain.Dao;

public interface Dao {
}

```

> UserDao.java
> 

```java
package Domain.Dao;

public interface UserDao {
}

```

> UserDaoImpl.java
> 

```java
package Domain.Dao;

public class UserDaoImpl {
}

```

---

## ConnectionPool

---

> ConnectionItem.java
> 

```java
package Domain.Dao.ConnectionPool;

public class ConnectionItem {
}

```

> ConnectionPool.java
> 

```java
package Domain.Dao.ConnectionPool;

public class ConnectionPool {
}

```

> MysqlXADataSourceFactory.java
> 

```java
package Domain.Dao.ConnectionPool;

public class MysqlXADataSourceFactory {
}

```

---

## Dto

---

> UserDto.java
> 

```java
package Domain.Dto;

public class UserDto {
}

```

---

## Service

---

> UserServiceImpl.java
> 

```java
package Domain.Service;

public class UserServiceImpl {
}

```

---

## Filter

---

> UTF8_EncodingFilter.java
> 

```java
package Filter;

import jakarta.servlet.*;
import java.io.IOException;

public class UTF8_EncodingFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }
}

```

---

## Tests

---

> DaoTests.java
> 

```java
package Tests;

public class DaoTests {
}

```

---

## META-INF

---

> context.xml
> 

```html
<?xml version="1.0" encoding="UTF-8"?>
<Context>
</Context>

```

---

## WEB-INF

---

> web.xml
> 

```html
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="<http://jakarta.ee/xml/ns/jakartaee>" version="5.0">
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>Filter.UTF8_EncodingFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>

```

---

## view

---

> error.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>에러 페이지입니다</h1>

```

> index.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>인덱스 페이지</h1>

```

> template.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/resources/layouts/topHeader.jsp" />
<jsp:include page="/resources/layouts/nav.jsp" />
<jsp:include page="/resources/layouts/link.jsp" />
<jsp:include page="/resources/layouts/footer.jsp" />

```

> create.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>회원가입 페이지</h1>

```

> error.jsp
> 

```html
<%@ page contentType="text/html;charset=UTF-8" %>
<h1>사용자 에러 페이지</h1>

```

---

## css

---

> common.css
> 

```css
body {
    font-family: Arial, sans-serif;
}

```

---

## js

---

> common.js
> 

```jsx
console.log("공통 자바스크립트 파일입니다.");

```

---

## layouts

---

> footer.jsp
> 

```html
<footer>
    <p>Footer 영역</p>
</footer>

```

> link.jsp
> 

```html
<link rel="stylesheet" href="/resources/css/common.css">
<script src="/resources/js/common.js"></script>

```

> nav.jsp
> 

```html
<nav>
    <ul>
        <li><a href="/">Home</a></li>
    </ul>
</nav>

```

> topHeader.jsp
> 

```html
<header>
    <h1>Top Header</h1>
</header>

```