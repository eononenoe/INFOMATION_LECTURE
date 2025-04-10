# 🛡️ 서블릿 필터 (Servlet Filter)

---

## 📌 개요 (Overview)

**서블릿 필터(Servlet Filter)** 는 웹 애플리케이션에서 요청(Request)이나 응답(Response)에 **공통적으로 적용할 작업**을 처리하는 도구입니다.  

> 쉽게 말하면, **웹 요청이 서블릿에 도착하기 전에 거치는 "검문소" 같은 역할**을 해요! 🚦

필터를 이용해서  
- 요청을 가로채서 검사하거나,
- 응답을 가공하거나,
- 인증/보안, 로깅(logging), 인코딩 설정 등을 할 수 있습니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

- **Filter**는 **ServletRequest**와 **ServletResponse**를 다룰 수 있습니다.
- **Filter**는 **서블릿이 실행되기 전** 또는 **후에** 동작할 수 있습니다. 🛠️
- 필터를 만들기 위해서는 `javax.servlet.Filter` 인터페이스를 구현해야 해요.
- 필터는 총 3가지 주요 메서드를 가집니다:
  - `init(FilterConfig config)`: 필터 초기화
  - `doFilter(ServletRequest request, ServletResponse response, FilterChain chain)`: 요청/응답 가로채기 처리
  - `destroy()`: 필터 종료

### 필터 동작 순서
1. **사용자 요청**이 서버에 도착한다.
2. **필터 체인(FilterChain)** 을 따라 여러 개의 필터가 순서대로 실행된다.
3. 최종적으로 **서블릿(Servlet)** 이 호출된다.
4. 서블릿 응답이 다시 **필터 체인**을 거쳐서 사용자에게 돌아간다.

---

## ⚠ 주의사항 (Cautions)

- **Filter**는 필수는 아니지만, 보통 **보안**, **로깅**, **요청/응답 가공** 같은 작업에 필수적으로 사용됩니다.
- **FilterChain** 객체를 이용해 다음 필터 또는 서블릿으로 요청을 넘겨줘야 합니다.
- **init()**, **doFilter()**, **destroy()** 메서드의 생명주기(lifecycle)를 잘 이해하고 있어야 합니다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🚥 비유 : 놀이공원 입구 검사대
- 놀이공원 입구에는 가방검사대가 있어요.
- 모든 방문객들은 놀이공원 안으로 들어가기 전에 검사대를 통과해야 해요.
- 검사대에서는 위험한 물건이 없는지 검사하거나, 티켓을 확인해요.
- 검사 후 이상 없으면 통과! 놀이공원(서블릿)으로 들어갈 수 있어요.

👉 필터(Filter)는 웹 서버에 들어오는 요청을 놀이공원 검사대처럼 검토하고, 필요하면 가공/거부할 수 있어요!

---

### 🛠️ 간단한 필터 코드 예시
```java
import javax.servlet.*;
import java.io.IOException;

public class MyFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 작업 (필요할 경우)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        System.out.println("요청이 필터를 통과합니다! 🚀");
        chain.doFilter(request, response); // 다음 필터 또는 서블릿으로 넘기기
    }

    @Override
    public void destroy() {
        // 필터 종료 처리 (필요할 경우)
    }
}
```

---

### 🔗 필터 체인(Filter Chain) 구조 그림
```
클라이언트 → [Filter1] → [Filter2] → [Filter3] → [Servlet] → [응답]
```
- 여러 필터들이 체인처럼 연결되어서 순서대로 처리됩니다.
- 각각의 필터는 `chain.doFilter()`를 호출해서 다음 단계로 넘겨줘야 합니다.

---

## ✅ 한 줄 요약 (1-Line Summary)

> **서블릿 필터는 웹 요청/응답을 가로채서 검사하거나 수정할 수 있는 "웹 요청의 검문소"이다! 🛡️**

---
