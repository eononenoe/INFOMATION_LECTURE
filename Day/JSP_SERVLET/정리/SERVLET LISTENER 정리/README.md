# 📚 LISTENER 프로젝트 정리

---

## 📌 개요 (Overview)

이 프로젝트는 **Servlet Listener(리스너)** 를 연습하는 예제야!  
리스너는 서버에서 특정 이벤트(서버 시작, 세션 생성, 요청 처리 등)가 발생했을 때 **자동으로 감지해서** 동작하는 기술이야! 🛎️

**예시:**
- 서버 시작 시 필요한 작업 미리 실행하기 🚀
- 세션이 생성될 때 초기화 작업하기 🎫

---

## 💡 핵심 개념 요약 (Key Concepts)

| 역할 | 설명 |
|:---|:---|
| Listener (리스너) | 서버 이벤트(시작/종료/요청/세션 생성 등)를 감지하는 클래스 |
| Servlet (서블릿) | 클라이언트 요청을 받아 실제 로직을 수행하는 클래스 |
| JSP (웹페이지) | 사용자에게 보여지는 최종 화면 |

---

## 🧪 리스너(Listener) 주석 추가 버전

---

### 📄 C01ServletContextListener.java

```java
public void contextInitialized(ServletContextEvent sce) { 
    // 서버 시작될 때 호출
}
public void contextDestroyed(ServletContextEvent sce) { 
    // 서버 종료될 때 호출
}
```

> 📌 **애플리케이션이 시작되거나 종료될 때 자동으로 호출된다.**

---

### 📄 C02ServletContextAttributeListener.java

```java
public void attributeAdded(ServletContextAttributeEvent event) { }
public void attributeRemoved(ServletContextAttributeEvent event) { }
public void attributeReplaced(ServletContextAttributeEvent event) { }
```

> 📌 **Application에 속성(Attribute)이 추가/삭제/변경될 때 호출된다.**

---

### 📄 C03HttpSessionListener.java

```java
public void sessionCreated(HttpSessionEvent se) { }
public void sessionDestroyed(HttpSessionEvent se) { }
```

> 📌 **세션(Session)이 생성되거나 소멸될 때 호출된다.**

---

### 📄 C04HttpSessionAttributeListener.java

```java
public void attributeAdded(HttpSessionBindingEvent event) { }
public void attributeRemoved(HttpSessionBindingEvent event) { }
public void attributeReplaced(HttpSessionBindingEvent event) { }
```

> 📌 **세션 안에 속성이 추가/삭제/변경될 때 호출된다.**

---

### 📄 C05ServletRequestListener.java

```java
public void requestInitialized(ServletRequestEvent sre) { }
public void requestDestroyed(ServletRequestEvent sre) { }
```

> 📌 **HTTP 요청이 생성되거나 종료될 때 호출된다.**

---

### 📄 C06ServletRequestAttributeListener.java

```java
public void attributeAdded(ServletRequestAttributeEvent event) { }
public void attributeRemoved(ServletRequestAttributeEvent event) { }
public void attributeReplaced(ServletRequestAttributeEvent event) { }
```

> 📌 **HTTP 요청 안에 속성이 추가/삭제/변경될 때 호출된다.**

---

## 💡 서블릿(Servlet) 핵심 요약

- `C02ListenerTest` : Application 속성 추가 테스트
- `C03ListenerTest` : 세션 속성 추가 테스트
- `C05ListenerTest` : 요청 속성 추가 테스트

---

## 💡 JSP 파일 요약

- `index.jsp` : 테스트 시작 페이지

---

## ⚠️ 주의사항 (Cautions)

- **web.xml에 리스너 등록 필수**  
- **이벤트가 발생해야 리스너가 호출된다** (예: 서버 재시작, 세션 생성)
- **Attribute 변경 이벤트는 반드시 setAttribute()를 호출해야 발생**

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **Listener는 학교 종소리!**  
  👉 종이 울리면 자동으로 수업 시작하거나 종료하듯 서버도 자동으로 이벤트를 감지해서 동작한다. 🔔

---

## ✅ 한 줄 요약 (1-Line Summary)

> **서버의 이벤트를 자동으로 감지하고 처리하는 Listener 개념을 연습하는 프로젝트! 🚀**

---
