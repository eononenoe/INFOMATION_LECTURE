# 🛢️ JSP에서 JDBC 사용하기 (DB 연결 & 데이터 조회)

**JDBC(Java Database Connectivity)**는 자바 애플리케이션에서 데이터베이스에 연결하고 SQL을 실행할 수 있게 해주는 기술입니다.

---

## 📌 개요 (Overview)

- JSP에서 **MySQL, Oracle 등 데이터베이스**와 연결하고 데이터를 조회/삽입/삭제할 수 있도록 도와줍니다.
- JDBC는 SQL 실행을 위한 객체 제공과 연결 관리, 결과 처리 등 다양한 기능을 제공합니다.

---

## 🧱 JDBC 기본 동작 구조

```text
웹 브라우저
     ↓
JSP 페이지 (Java 포함)
     ↓
JDBC 드라이버를 통해 DB 연결
     ↓
SQL 실행 및 결과 처리
     ↓
결과 반환 (웹 페이지로 출력)
```

---

## 🔁 JDBC 처리 순서

1. JDBC 드라이버 로딩  
2. Connection 객체 생성  
3. Statement 또는 PreparedStatement 생성  
4. SQL 실행  
5. ResultSet 으로 결과 받기  
6. ResultSet, Statement, Connection 순서대로 닫기 (Close)

---

## 🔧 주요 객체 설명

| 객체 | 역할 |
|------|------|
| `DriverManager` | JDBC 드라이버를 통해 DB 연결 |
| `Connection` | DB와 연결된 세션 생성 |
| `Statement` | SQL 실행용 객체 생성 |
| `ResultSet` | SQL 실행 결과 저장 |
| `Close()` | 자원 정리 (메모리 낭비 방지) |

---

## 🖥 JSP 코드 예제

### 1️⃣ index.jsp — 입력 폼 페이지

```jsp
<form action="db.jsp" method="post">
  이름: <input type="text" name="name" />
  <input type="submit" value="조회" />
</form>
```

---

### 2️⃣ db.jsp — JDBC 연결 및 데이터 조회

```jsp
<%@ page import="java.sql.*" %>

<%
String name = request.getParameter("name");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "user", "password");
    stmt = conn.createStatement();
    String sql = "SELECT * FROM members WHERE name = '" + name + "'";
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        out.println("이름: " + rs.getString("name"));
        out.println("이메일: " + rs.getString("email"));
    }

} catch(Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
%>
```

---

## 📌 핵심 포인트 요약

- `Class.forName()` → 드라이버 로딩
- `DriverManager.getConnection()` → DB 접속
- `createStatement()` & `executeQuery()` → SQL 실행
- `rs.getString()` → 결과 꺼내기
- `finally` 블록에서 `close()`로 자원 정리

---

## 💡 실무 팁

> 실제 프로젝트에서는 위와 같은 JDBC 코드를 JSP에 직접 작성하기보다, **DAO 클래스**로 따로 분리해서 관리하는 것이 좋습니다!

```text
✔ JSP: 사용자 입력과 결과 출력 담당
✔ DAO: 데이터베이스 연결과 쿼리 실행 담당
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> 📊 JDBC는 JSP에서 **데이터베이스와 연결하고 SQL을 실행**할 수 있도록 도와주는 기술입니다!

---
