# 🔐 JSP 세션(Session) 완벽 가이드

**세션(Session)**은 클라이언트가 서버와 연결되어 있는 동안 정보를 유지하기 위한 저장소입니다.  
로그인 유지, 사용자 설정 보관 등에 꼭 필요해요!

---

## 📌 개요 (Overview)

| 항목       | 내용 |
|------------|------|
| 객체 타입   | `javax.servlet.http.HttpSession` |
| 생성 위치   | JSP 실행 시 자동 생성 (`<%@ page session="true" %>`) |
| 저장 위치   | 서버 메모리 (사용자별로 따로 저장) |
| 구분 방법   | 클라이언트의 **쿠키(JSESSIONID)** 를 사용 |
| 세션 만료   | 기본 30분 동안 요청 없으면 자동 종료 |

---

## 🧠 세션 관련 주요 메서드

| 메서드 | 설명 |
|--------|------|
| `setAttribute(String name, Object value)` | 세션에 데이터 저장 |
| `getAttribute(String name)` | 세션에서 데이터 가져오기 |
| `removeAttribute(String name)` | 세션에서 데이터 삭제 |
| `invalidate()` | 세션 전체 제거 (로그아웃 시) |
| `getCreationTime()` | 세션 생성 시간 |
| `getLastAccessedTime()` | 마지막 요청 시간 |
| `setMaxInactiveInterval(int seconds)` | 세션 유지 시간 설정 (초 단위) |

---

## 💡 핵심 사용 예제 (Key Usage)

### 1️⃣ 세션에 값 저장

```jsp
<%
String userId = request.getParameter("userId");
session.setAttribute("userId", userId); // 세션에 저장
%>
```

---

### 2️⃣ 세션에서 값 읽기

```jsp
<%
String id = (String) session.getAttribute("userId");
if (id != null) {
%>
  <p>로그인한 사용자: <%= id %></p>
<%
} else {
%>
  <p>로그인 정보가 없습니다.</p>
<%
}
%>
```

---

### 3️⃣ 세션 값 삭제

```jsp
<%
session.removeAttribute("userId");
%>
```

---

### 4️⃣ 세션 전체 무효화 (로그아웃 등)

```jsp
<%
session.invalidate();
%>
```

---

### 5️⃣ 세션 유지 시간 설정 (예: 10분)

```jsp
<%
session.setMaxInactiveInterval(600); // 600초 = 10분
%>
```

---

## 🧪 실전 예제 모음

### ✅ 로그인 처리 페이지 (`loginCheck.jsp`)

```jsp
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");

if ("admin".equals(id) && "1234".equals(pw)) {
    session.setAttribute("loginUser", id);
    response.sendRedirect("main.jsp");
} else {
    out.println("로그인 실패");
}
%>
```

---

### ✅ 메인 페이지 (`main.jsp`)

```jsp
<%
String loginUser = (String) session.getAttribute("loginUser");
if (loginUser == null) {
    response.sendRedirect("login.jsp");
}
%>
<h2><%= loginUser %>님, 로그인하셨습니다!</h2>
<a href="logout.jsp">로그아웃</a>
```

---

### ✅ 로그아웃 처리 (`logout.jsp`)

```jsp
<%
session.invalidate(); // 세션 종료
response.sendRedirect("login.jsp");
%>
```

---

## 📝 참고: `page` 지시자의 `session` 속성

```jsp
<%@ page session="false" %>
```

- 이 설정을 하면 JSP 페이지에서 세션을 사용하지 않겠다는 의미입니다.
- `session` 객체를 사용하려 하면 에러가 발생해요!

---

## ✅ 한 줄 요약 (1-Line Summary)

> ✨ JSP 세션은 **사용자별 정보를 서버에 기억**하게 해주는 중요한 기능입니다!

---
