# 🌐 서블릿 (Servlet)

---

## 📌 개요 (Overview)

**서블릿(Servlet)** 은 **Java** 언어로 작성된 **서버 프로그램**이에요.  
웹 애플리케이션에서 클라이언트의 요청을 받아서, 서버에서 처리하고 응답을 돌려주는 역할을 합니다.  
쉽게 말하면, **웹 서버 속의 작은 자바 프로그램**이라고 생각하면 돼요! 🎯

주로 **Apache Tomcat**, **Jetty** 같은 서버 프로그램 위에서 동작하며,  
HTML 같은 웹페이지를 만들거나, 데이터를 다루는 일을 합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

- **HTTP 요청**을 받아서 서버가 이해할 수 있도록 가공합니다. 📩
- **HTTP 응답**을 만들어 클라이언트(브라우저)로 돌려줍니다. 📤
- 서블릿은 **서버가 켜질 때(init)**, **요청이 들어올 때(service)**, **서버가 꺼질 때(destroy)** 각각 동작하는 메서드를 가집니다.
- 기본적으로 **HttpServlet** 클래스를 상속받아서 만들어집니다.

### 기본 구조
```java
public class MyServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        // 서블릿 초기화
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 처리
    }

    @Override
    public void destroy() {
        // 서블릿 종료 처리
    }
}
```

---

## ⚠ 주의사항 (Cautions)

- 서블릿 파일을 **web.xml** 이라는 파일에 등록하거나,  
  최근에는 **어노테이션**(@WebServlet)을 이용해서 등록해야 서버가 인식할 수 있어요.
- HTTP 요청과 응답 처리를 위해 `HttpServletRequest`, `HttpServletResponse` 객체를 잘 다뤄야 해요.
- 직접 HTML 코드를 자바 안에 작성해야 하므로, 복잡해질 수 있어요. (그래서 JSP 같은 기술과 함께 사용하기도 함!)

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🛎️ 비유 : 호텔 프런트 데스크 직원
- 호텔의 프런트 직원이 손님의 요청(체크인, 룸서비스 등)을 받아서
- 호텔 안의 다양한 부서(청소팀, 룸서비스팀 등)에 전달하고
- 다시 손님에게 결과를 알려주는 역할을 해요.

👉 서블릿도 비슷하게, **브라우저(손님)** → **서버 내부(호텔)** → **브라우저(손님)** 사이에서 요청과 응답을 중개하는 역할을 합니다!

---

### 🛠️ 작은 예시 : 간단한 인사하는 서블릿
```java
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class HelloServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<h1>Hello, World!</h1>");
    }
}
```
- `doGet()` 메서드: 브라우저에서 URL을 통해 요청이 들어올 때 작동합니다.
- 결과: 브라우저에 "**Hello, World!**" 문구가 뜨는 HTML 페이지가 만들어집니다. ✨

---

## ✅ 한 줄 요약 (1-Line Summary)

> **서블릿은 Java로 만든 서버 속 작은 프로그램으로, HTTP 요청을 받아 응답을 만들어주는 역할을 한다! 🌟**

---
