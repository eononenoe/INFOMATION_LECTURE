# 🌊 JSP에서 Connection Pool (연결 풀) 사용하기

**Connection Pool(연결 풀)**은 데이터베이스와의 연결을 **미리 여러 개 만들어 두고**,  
필요할 때 꺼내서 쓰고 다시 돌려주는 구조입니다.  
매번 연결을 새로 생성하는 것보다 훨씬 효율적이고 빠릅니다 🚀

---

## 📌 개요 (Overview)

| 항목 | 설명 |
|------|------|
| 목적 | DB 연결의 재사용을 통해 성능 향상 |
| 구성 | 미리 생성된 `Connection` 객체들을 풀(Pool) 형태로 보관 |
| 방식 | 사용 후 반납하면 풀로 돌아가 다른 사용자가 재사용 가능 |

---

## 💡 장점 (Why use Connection Pool?)

- ✅ **성능 향상**  
  → 매번 연결하지 않아도 되므로 속도 개선  
- ✅ **자원 절약**  
  → 필요 이상으로 DB 자원을 소비하지 않음  
- ✅ **효율적인 관리**  
  → 커넥션 수 제한으로 서버 과부하 방지

---

## ⚙️ DBCP란?

**DBCP (Database Connection Pool)**는  
Apache Commons에서 제공하는 커넥션 풀 라이브러리입니다.

> 💡 주요 클래스: `BasicDataSource`  
> 👉 연결 개수, 최대/최소 커넥션 수 등 다양한 설정 가능

---

## 🔌 사용 흐름

1. `BasicDataSource` 객체 생성  
2. DB 설정 (URL, 계정, 비밀번호 등)  
3. `getConnection()`으로 연결 획득  
4. SQL 실행  
5. `close()`로 연결 반환

---

## 🧪 예제 코드 (JSP 내에서 DBCP 사용)

### 📦 DBCP 설정 및 사용

```jsp
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="java.sql.*" %>

<%
BasicDataSource ds = new BasicDataSource();
ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
ds.setUrl("jdbc:mysql://localhost:3306/mydb");
ds.setUsername("root");
ds.setPassword("1234");
ds.setInitialSize(5); // 최초 커넥션 수
ds.setMaxTotal(10);   // 최대 커넥션 수

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    conn = ds.getConnection();
    String sql = "SELECT * FROM members";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        out.println("이름: " + rs.getString("name") + "<br>");
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close(); // 풀에 반납됨!
}
%>
```

---

## 📌 주요 설정 요약

| 메서드 | 설명 |
|--------|------|
| `setDriverClassName()` | JDBC 드라이버 설정 |
| `setUrl()` | DB 연결 URL |
| `setUsername()` / `setPassword()` | 계정 정보 |
| `setInitialSize()` | 초기 커넥션 수 |
| `setMaxTotal()` | 최대 커넥션 수 제한 |

---

## ⚠ 주의사항 (Cautions)

- `conn.close()`는 **연결을 종료하는 게 아니라, 커넥션 풀로 반환**하는 것이에요!
- **라이브러리 필요**: `commons-dbcp2`, `commons-pool2` 등을 프로젝트에 포함해야 함
- 실무에서는 **서블릿 컨텍스트나 Spring의 DataSource 설정**을 통해 분리 관리하는 것이 일반적입니다.

---

## ✅ 한 줄 요약 (1-Line Summary)

> 🌊 Connection Pool은 **DB 연결을 재사용하여 성능을 극대화**하는 강력한 기술입니다!

---
