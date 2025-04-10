# 📚 FILTER 프로젝트 정리

---

## 📌 개요 (Overview)

이 프로젝트는 **Filter(필터)** 를 연습하는 예제야!  
"필터"는 웹 요청/응답이 서블릿(Servlet)까지 가거나 오기 전에 **중간에서 가로채서** 뭔가를 추가하거나 검사하는 기술이야! 🛡️

**예시:**
- 로그인 안 한 사람은 특정 페이지 접근 못하게 막기 🚫
- 모든 요청에 자동으로 인코딩 설정(UTF-8) 해주기 🌐

---

## 💡 핵심 개념 요약 (Key Concepts)

| 역할 | 설명 |
|:---|:---|
| Filter (필터) | 서블릿 전에 요청을 가로채서 검사, 수정, 처리하는 역할 |
| Servlet (서블릿) | 요청을 받아 실제 비즈니스 로직 처리하는 역할 |
| JSP (웹페이지) | 최종적으로 사용자에게 보여지는 화면 |

---

## 🧪 필터(Filter) 주석 추가 버전

---

### 📄 C01Filter_Test.java

```java
package Filter;

import java.io.IOException;
import javax.servlet.*;

public class C01Filter_Test implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터가 처음 생성될 때 호출
        System.out.println("C01Filter INIT...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // 요청이 필터를 지나갈 때 실행
        System.out.println("C01Filter DOFILTER before...");
        
        chain.doFilter(request, response); // 다음 필터 or 서블릿으로 넘기기
        
        System.out.println("C01Filter DOFILTER after...");
    }

    @Override
    public void destroy() {
        // 필터가 제거될 때 호출
        System.out.println("C01Filter DESTROY...");
    }
}
```

---

### 📄 C02Filter_Test.java

```java
package Filter;

import java.io.IOException;
import javax.servlet.*;

public class C02Filter_Test implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("C02Filter INIT...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        System.out.println("C02Filter DOFILTER before...");
        
        chain.doFilter(request, response);
        
        System.out.println("C02Filter DOFILTER after...");
    }

    @Override
    public void destroy() {
        System.out.println("C02Filter DESTROY...");
    }
}
```

---

### 📄 UTF8_EncodingFilter.java

```java
package Filter;

import java.io.IOException;
import javax.servlet.*;

public class UTF8_EncodingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // 요청과 응답 둘 다 UTF-8 인코딩으로 설정해줘!
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        chain.doFilter(request, response); // 다음 단계로 넘기기
    }

    @Override
    public void destroy() {}
}
```

> 📌 **UTF8 필터**는 한글이 깨지는 걸 막아주는 필터야!

---

## 💡 서블릿(Servlet) 주석 추가 버전

(※ Home.java, Join.java, Login.java는 거의 **05EX 프로젝트**랑 비슷하지만, 필터가 적용된 상태야!)

### 🛠️ 핵심은 "필터를 거쳐서 서블릿으로 간다!"는 점!

- `/index.do`, `/main.do` → Home 서블릿
- `/join.do` → Join 서블릿 (회원가입)
- `/login.do` → Login 서블릿 (로그인)

---

## 💡 JSP 파일 주석 추가 버전

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
<!-- 로그인 성공 시 도착하는 페이지 -->
```

---

## ⚠️ 주의사항 (Cautions)

- **필터 순서**: web.xml에 등록된 순서대로 필터가 동작해!
- **chain.doFilter() 호출 잊지 말기**: 이거 안 하면 다음 단계(서블릿)로 요청이 넘어가지 않는다.
- **UTF-8 필터**를 제일 먼저 설정하는 게 좋아! (글자 깨짐 방지)

---

## ✅ 한 줄 요약 (1-Line Summary)

> 필터(Filter)는 요청과 응답을 중간에서 가로채서 추가 처리하거나 검사하는 웹 서버의 보안/편의 기술이다! 🛡️✨

---
