# 👂 서블릿 리스너 (Servlet Listener)

---

## 📌 개요 (Overview)

**서블릿 리스너(Servlet Listener)** 는  
**서버에서 일어나는 특정 이벤트**를 자동으로 감지해서,  
특정 동작을 하게 만들어주는 클래스입니다. 🛎️

> 예를 들어 **웹 애플리케이션이 시작될 때**, **세션이 생성될 때**, **요청이 들어올 때**  
> 자동으로 동작하는 코드가 필요하다면, 리스너를 사용합니다!

---

## 💡 핵심 개념 요약 (Key Concepts)

- **리스너**는 서버의 이벤트를 감지합니다. (앱 시작, 세션 생성, 요청 발생 등)
- 리스너는 **인터페이스**를 구현하여 작성합니다.
- 주요 리스너 종류:
  - `ServletContextListener` : 웹 앱 시작/종료 감지
  - `ServletContextAttributeListener` : context 속성 추가/변경/삭제 감지
  - `HttpSessionListener` : 세션 생성/소멸 감지
  - `HttpSessionAttributeListener` : 세션 속성 변경 감지
  - `HttpSessionActivationListener` : 세션 활성화/비활성화 감지 (클러스터링 환경)
  - `ServletRequestListener` : 요청 생성/소멸 감지
  - `ServletRequestAttributeListener` : 요청 속성 변경 감지

- 등록 방법:
  - `@WebListener` 어노테이션 사용
  - 또는 `web.xml` 파일에 설정

---

## ⚠ 주의사항 (Cautions)

- 리스너는 서버 상태와 매우 밀접하게 연결되어 있어요.  
  **잘못 작성하면 서버에 큰 영향을 줄 수 있습니다!** (예: 무한 루프, 대량 로깅 등 주의 🚨)
- 필요한 이벤트에만 최소한으로 사용하도록 주의해요.
- `init`, `destroy` 같은 메서드는 서버가 동작하거나 종료할 때 호출됩니다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🛎️ 비유 : 호텔 매니저
- 호텔 매니저는 손님이 체크인할 때, 체크아웃할 때 자동으로 기록을 남깁니다.
- 매니저는 손님이 뭘 했는지 일일이 명령받지 않고, **이벤트(체크인/체크아웃)** 가 발생할 때 자동으로 반응합니다.

👉 **리스너**는 웹 서버의 **매니저**와 같아요.  
서버 안에서 일어나는 다양한 사건에 맞춰 자동으로 반응합니다!

---

### 🛠️ 코드 예시 모음

#### 1. 웹 애플리케이션 시작/종료 감지 (ServletContextListener)
```java
@WebListener
public class MyContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🌟 웹 애플리케이션 시작됨!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🛑 웹 애플리케이션 종료됨!");
    }
}
```

---

#### 2. 세션 생성/소멸 감지 (HttpSessionListener)
```java
@WebListener
public class MySessionListener implements HttpSessionListener {
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("🆕 세션 생성: " + se.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("❌ 세션 소멸: " + se.getSession().getId());
    }
}
```

---

#### 3. 요청 생성/소멸 감지 (ServletRequestListener)
```java
@WebListener
public class MyRequestListener implements ServletRequestListener {
    
    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        System.out.println("📥 요청 발생: " + sre.getServletRequest().getRemoteAddr());
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        System.out.println("📤 요청 종료");
    }
}
```

---

### 📝 리스너 등록 방법 정리

#### 💬 어노테이션 방식
```java
@WebListener
public class MyListener implements ServletContextListener {
    ...
}
```

#### 🗂️ web.xml 방식
```xml
<listener>
    <listener-class>com.example.MyListener</listener-class>
</listener>
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **서블릿 리스너는 서버 이벤트(앱 시작, 세션 생성 등)를 자동 감지해서 반응하는 귀여운 매니저 클래스다! 👂**

---
