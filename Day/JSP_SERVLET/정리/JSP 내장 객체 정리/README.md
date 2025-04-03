# 💼 JSP 내장 객체 (Implicit Objects) 완전 정리

JSP는 별도의 선언 없이도 자동으로 제공되는 **내장 객체들**을 가지고 있어요!  
이 객체들은 **클라이언트 요청 처리, 세션 관리, 출력, 설정 접근** 등을 쉽게 할 수 있게 도와줘요.

---

## 📌 개요 (Overview)

| 객체 이름     | 타입 (클래스)         | 설명 |
|---------------|------------------------|------|
| `request`     | `HttpServletRequest`   | 클라이언트 요청 정보를 담고 있음 (파라미터, 헤더 등) |
| `response`    | `HttpServletResponse`  | 클라이언트에게 응답을 보내는 객체 |
| `session`     | `HttpSession`          | 클라이언트의 세션을 관리하는 객체 |
| `application` | `ServletContext`       | 웹 애플리케이션 전역 정보를 저장하는 객체 |
| `out`         | `JspWriter`            | HTML 등을 클라이언트로 출력하는 스트림 |
| `config`      | `ServletConfig`        | JSP 초기 설정 정보를 담고 있음 |
| `pageContext` | `PageContext`          | JSP 전체 객체들을 관리하는 도우미 객체 |
| `page`        | `Object` (`this`)      | 현재 JSP 페이지 자신을 가리키는 객체 |
| `exception`   | `Throwable`            | 예외 처리용 객체 (`isErrorPage="true"`일 때만 사용 가능) |

---

## 💡 핵심 객체 요약 (Key Concepts)

### 1. 🔍 `request` — 클라이언트 요청 정보 접근

- 파라미터, 헤더, IP 등 다양한 요청 정보에 접근할 수 있어요.
```jsp
<%= request.getParameter("userId") %>
```

---

### 2. 📤 `response` — 응답 설정 (리디렉션, 상태 코드 등)

```jsp
<% response.sendRedirect("login.jsp"); %>
```

---

### 3. 🧳 `session` — 사용자 상태 유지 (로그인 등)

```jsp
<% session.setAttribute("userName", "홍길동"); %>
<%= session.getAttribute("userName") %>
```

---

### 4. 🏢 `application` — 전체 사용자에게 공유되는 전역 저장소

```jsp
<% application.setAttribute("counter", 100); %>
```

---

### 5. 🖨 `out` — 출력 스트림 (System.out.print() ❌)

```jsp
<% out.println("Hello JSP!"); %>
```

---

### 6. ⚙ `config` — JSP 설정 정보 접근

```jsp
<%= config.getServletName() %>
```

---

### 7. 📦 `pageContext` — JSP의 모든 영역 객체에 접근 가능

- `page`, `request`, `session`, `application` 객체에 접근 가능
- 태그 처리, forward, include, 예외 정보도 포함

```jsp
<%= pageContext.getRequest().getRemoteAddr() %>
```

---

### 8. 📄 `page` — 현재 JSP 페이지 자신 (`this`)

```jsp
<%= page.getClass().getName() %>
```

---

### 9. 🚨 `exception` — 예외 처리 전용 객체

- `isErrorPage="true"` 설정된 페이지에서만 사용 가능해요!

```jsp
<%@ page isErrorPage="true" %>
<%= exception.getMessage() %>
```

---

## ⚠ 주의사항 (Cautions)

- `exception` 객체는 **오직 오류 처리용 페이지**에서만 쓸 수 있어요.
- `session`, `application`은 저장된 값을 꺼낼 때 `getAttribute()` 사용!
- `out` 객체는 JSP 기본 출력 도구이고, `System.out.print()`는 콘솔 출력이에요 (서버 로그로만 나옴).

---

## 🧪 예제 또는 비유 (Examples or Analogies)

> 📦 `request`는 택배 상자 (클라이언트가 보낸 정보)  
> 📤 `response`는 택배 기사 (서버가 응답을 보냄)  
> 🧳 `session`은 개인 사물함  
> 🏢 `application`은 회사 전체 공유 폴더  
> 🖨 `out`은 출력 프린터  
> ⚙ `config`는 초기 설정서  
> 📦 `pageContext`는 종합 안내 데스크  
> 📄 `page`는 현재 JSP 파일 자신  
> 🚨 `exception`은 오류 보고서

---

## ✅ 한 줄 요약 (1-Line Summary)

> JSP 내장 객체는 서버와 클라이언트의 **정보 전달과 처리 흐름을 자동화**해주는 필수 도구입니다! ⚙️

---
