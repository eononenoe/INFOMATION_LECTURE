# 📚 FILTER 프로젝트 정리

---

## 📌 개요 (Overview)

이 프로젝트는 **Filter(필터)** 를 연습하는 예제야!  
"필터"는 웹 요청/응답이 서블릿(Servlet)까지 가기 전에 **중간에서 가로채서** 뭔가를 추가하거나 검사하는 기술이야! 🛡️

**예시:**
- 로그인 안 한 사람은 특정 페이지 접근 막기 🚫
- 모든 요청에 자동으로 인코딩(UTF-8) 설정하기 🌐

---

## 💡 핵심 개념 요약 (Key Concepts)

| 역할 | 설명 |
|:---|:---|
| Filter (필터) | 요청을 서블릿으로 보내기 전에 검사/수정하는 역할 |
| Servlet (서블릿) | 클라이언트 요청을 실제로 처리하는 자바 클래스 |
| JSP (웹페이지) | 사용자에게 보여지는 최종 화면 |

---

## 🧪 필터(Filter) 주석 추가 버전

---

### 📄 C01Filter_Test.java

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    System.out.println("C01Filter DOFILTER before...");
    chain.doFilter(request, response); // 다음 필터 or 서블릿으로 넘기기
    System.out.println("C01Filter DOFILTER after...");
}
```

> 📌 **C01Filter**는 요청 전에, 요청 후에 각각 작업을 추가로 할 수 있게 해주는 기본 필터 예제야.

---

### 📄 C02Filter_Test.java

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    System.out.println("C02Filter DOFILTER before...");
    chain.doFilter(request, response);
    System.out.println("C02Filter DOFILTER after...");
}
```

> 📌 **C02Filter**도 기본 필터 흐름을 연습하는 예제야. 필터 여러 개를 적용하면 순서대로 호출돼.

---

### 📄 UTF8_EncodingFilter.java

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    chain.doFilter(request, response);
}
```

> 📌 **UTF8 인코딩 필터**는 요청과 응답 모두 한글 깨짐 없이 처리할 수 있게 도와줘!

---

### 📄 LoginRedirectFilter.java

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        ((HttpServletResponse) response).sendRedirect(req.getContextPath() + "/login.do");
        return;
    }
    chain.doFilter(request, response);
}
```

> 📌 **LoginRedirectFilter**는 로그인하지 않은 사용자를 로그인 페이지로 강제 이동시킨다!

---

### 📄 PermissionFilter.java

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpSession session = req.getSession(false);
    String role = (String) session.getAttribute("role");

    // 권한 체크 (ex: ROLE_ADMIN, ROLE_USER)
    if (!"ROLE_ADMIN".equals(role)) {
        ((HttpServletResponse) response).sendRedirect(req.getContextPath() + "/index.do");
        return;
    }
    chain.doFilter(request, response);
}
```

> 📌 **PermissionFilter**는 사용자의 권한(Role)을 검사해서 접근 가능한지 확인하는 필터야!

---

## 💡 서블릿(Servlet) 핵심 요약

- `/index.do`, `/main.do` 요청은 `Home.java`가 처리
- `/join.do` 요청은 `Join.java`가 처리 (회원가입)
- `/login.do` 요청은 `Login.java`가 처리 (로그인)

**모든 요청은 반드시 필터를 통과하고, 그 다음 서블릿으로 전달된다!**

---

## 💡 JSP 파일 요약

### 🖥️ index.jsp

```jsp
<h1>INDEX PAGE</h1>
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
<!-- 로그인 성공 후 이동하는 메인 화면 -->
```

---

## ⚠ 주의사항 (Cautions)

- **필터 순서 주의!**  
  👉 web.xml에 등록한 순서대로 필터가 실행된다. (예: UTF-8 → 로그인체크 → 권한체크)

- **chain.doFilter 호출 필수!**  
  👉 이걸 호출하지 않으면 요청이 다음 단계로 넘어가지 않는다.

- **UTF-8 인코딩 필터는 제일 먼저 적용**  
  👉 한글 깨짐 방지하려면 항상 인코딩 필터가 제일 먼저 실행되어야 한다.

- **세션 체크 시 null 확인 필수!**  
  👉 세션이 없거나 세션에 로그인 정보가 없으면 안전하게 리다이렉트 처리해야 한다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **Filter는 지하철 개찰구!**  
  👉 지하철 탈 때 티켓 확인하듯이, 요청이 필터를 통과할 때 필요한 검사/처리를 한다!

- **LoginRedirectFilter는 매표소 검문소!**  
  👉 티켓 없는 사람(로그인 안한 사용자)은 입장 못하게 막고, 다시 로그인 페이지로 보내는 역할!

- **PermissionFilter는 VIP 전용 구역 통제!**  
  👉 권한이 없는 사용자는 특정 페이지에 접근하지 못하게 막는다!

---

## ✅ 한 줄 요약 (1-Line Summary)

> **Filter는 요청(Request)을 서블릿으로 보내기 전에 검사/변경하는 보안/편의 기능이다! 🛡️🚀**

---
