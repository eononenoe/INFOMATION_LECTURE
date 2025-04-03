# 🚀 JSP 액션 태그(Action Tag) 완벽 정리

JSP에서 **액션 태그**는 `<jsp:...>` 형식으로 사용되며,  
**동적인 처리**를 도와주는 특수한 태그입니다!

---

## 📌 개요 (Overview)

| 액션 태그 | 설명 |
|-----------|------|
| `<jsp:useBean>` | 자바빈(JavaBean) 선언 및 생성 |
| `<jsp:setProperty>` | 자바빈의 속성 값 설정 |
| `<jsp:getProperty>` | 자바빈의 속성 값 출력 |
| `<jsp:include>` | 다른 JSP 파일을 **동적으로 포함** |
| `<jsp:forward>` | **요청을 다른 페이지로 전달** |
| `<jsp:param>` | 파라미터를 전달할 때 사용 (include/forward와 함께) |
| `<jsp:plugin>` | Java Applet/Bean을 삽입 (거의 사용 안함) |
| `<jsp:fallback>` | plugin이 안 될 때 대체 내용 제공 |

---

## 💡 핵심 개념 요약 (Key Concepts)

### 1. 🧱 `<jsp:useBean>` — 자바 빈 선언 및 생성

```jsp
<jsp:useBean id="user" class="com.example.User" scope="session" />
```

| 속성 | 설명 |
|------|------|
| `id` | 사용할 이름 |
| `class` | 자바빈 클래스 경로 |
| `scope` | 유효 범위 (`page`, `request`, `session`, `application`) |

---

### 2. 🧩 `<jsp:setProperty>` — 자바빈 값 설정

```jsp
<jsp:setProperty name="user" property="name" value="홍길동" />
<jsp:setProperty name="user" property="*" />
```

- `property="*"`: 요청 파라미터 이름과 일치하는 프로퍼티를 자동으로 설정

---

### 3. 🔍 `<jsp:getProperty>` — 자바빈 값 출력

```jsp
<jsp:getProperty name="user" property="name" />
```

---

### 4. 🧬 `<jsp:include>` — JSP 파일을 **동적으로 포함**

```jsp
<jsp:include page="header.jsp" />
```

> 🧠 포함 시점에 실행되므로 항상 최신 결과를 반영해요!

---

### 5. 🛫 `<jsp:forward>` — 페이지 전환 (요청 전달)

```jsp
<jsp:forward page="login.jsp" />
```

> 💡 클라이언트에게 응답 없이 서버 내부에서 바로 이동합니다!

---

### 6. 📦 `<jsp:param>` — 파라미터 전달 (include, forward와 함께 사용)

```jsp
<jsp:forward page="login.jsp">
  <jsp:param name="msg" value="로그인이 필요합니다" />
</jsp:forward>
```

---

### 7. 🧃 `<jsp:plugin>` & `<jsp:fallback>` (거의 사용 ❌)

```jsp
<jsp:plugin type="applet" code="MyApplet.class" width="300" height="200">
  <jsp:fallback>
    이 브라우저는 자바 애플릿을 지원하지 않습니다.
  </jsp:fallback>
</jsp:plugin>
```

> 🛑 현대 웹에서는 거의 사용하지 않아요.

---

## ⚠ 주의사항 (Cautions)

- `jsp:include`는 동적 포함이며, `<%@ include %>`는 정적 포함이에요.
- `jsp:forward`는 클라이언트에게 리다이렉트 없이 서버에서 이동합니다.
- `useBean` 사용 시 클래스는 반드시 **기본 생성자**를 가져야 해요!

---

## 🧪 예제 또는 비유 (Examples or Analogies)

> 🍱 `useBean`은 자바 객체를 준비하는 도시락통  
> ✍️ `setProperty`는 도시락에 밥과 반찬을 담는 것  
> 👀 `getProperty`는 도시락을 열어 안에 뭐 들었는지 보는 것  
> 📬 `forward`는 다른 부서로 요청서를 넘기는 것  
> 🧾 `param`은 요청서에 추가 메모를 붙이는 것!

---

## ✅ 한 줄 요약 (1-Line Summary)

> JSP 액션 태그는 동적인 페이지 처리와 자바빈 관리를 위한 **도구 상자**입니다! 🔧

---
